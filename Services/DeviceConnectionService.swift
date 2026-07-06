import Foundation
import Network

// MARK: - خدمة اتصال الجهاز
/// تتعامل مع كل الاتصال الشبكي بجهاز القائد الآلي (المنفذ 8082)
/// مستخرجة من ControlView الأصلي ومُعاد تنظيمها بطبقة خدمة نظيفة

@Observable
final class DeviceConnectionService {
    // MARK: - الحالة

    var isConnected: Bool = false
    var deviceIP: String = ""
    var isSearching: Bool = false
    var searchProgress: String = "غير متصل"
    var discoveredDevices: [DiscoveredDevice] = []
    var deviceInfo: DeviceInfo = DeviceInfo()

    /// ✅ الوضع التجريبي (Demo Mode) — يحاكي جهاز متصل فعلياً
    var isDemoMode: Bool = false

    // MARK: - ثوابت

    /// منفذ جهاز القائد الآلي
    let devicePort: UInt16 = 8082

    /// عنوان API الأساسي
    var baseURL: String {
        if isDemoMode { return "demo://القائد الآلي" }
        return "http://\(deviceIP):\(devicePort)"
    }

    // MARK: - تفعيل الوضع التجريبي

    /// تفعيل/تعطيل الوضع التجريبي — يملأ بيانات جهاز وهمية واقعية
    func toggleDemoMode() {
        if isDemoMode {
            // تعطيل
            isDemoMode = false
            isConnected = false
            searchProgress = "غير متصل"
            deviceInfo = DeviceInfo()
            deviceIP = ""
        } else {
            // تفعيل
            isDemoMode = true
            isConnected = true
            deviceIP = "192.168.1.100"
            searchProgress = "متصل (وضع تجريبي)"
            deviceInfo = DeviceInfo(
                dongleId: "a1b2c3d4e5",
                serialNumber: "NMK2024-001234",
                softwareVersion: "0.9.8-release",
                hardwareType: "comma 3X",
                freeStorage: "42.6 GB",
                usedStorage: "21.4 GB",
                networkType: "WiFi 5GHz",
                uptime: "3 أيام، 7 ساعات"
            )
        }
    }

    // MARK: - البحث عن الأجهزة

    /// البحث التلقائي في الشبكة المحلية
    func startAutoScan() {
        isSearching = true
        discoveredDevices = []
        searchProgress = "بدء البحث السريع..."

        guard let localIP = getLocalIPAddress() else {
            searchProgress = "فشل الحصول على عنوان IP"
            isSearching = false
            return
        }

        let subnet = localIP.components(separatedBy: ".").prefix(3).joined(separator: ".")
        let queue = DispatchQueue(label: "nmk.network.scan", attributes: .concurrent)
        let group = DispatchGroup()

        for i in 1...254 {
            group.enter()
            let ipToCheck = "\(subnet).\(i)"

            queue.async {
                self.quickCheckDevice(ip: ipToCheck, port: self.devicePort) { found in
                    if found {
                        DispatchQueue.main.async {
                            let device = DiscoveredDevice(name: "القائد الآلي", ip: ipToCheck, signalStrength: 85)
                            if !self.discoveredDevices.contains(where: { $0.ip == ipToCheck }) {
                                self.discoveredDevices.append(device)
                                self.searchProgress = "تم العثور على جهاز!"
                            }
                        }
                    }
                    group.leave()
                }
            }
        }

        // ✅ تحديث نص "جاري البحث..." باستخدام Task (بدل Thread.sleep على GCD)
        // أكثر أماناً: قابل للإلغاء ولا يحجز خيطاً من تجمّع GCD
        Task { @MainActor [weak self] in
            var dots = 0
            while let self, self.isSearching && self.discoveredDevices.isEmpty {
                dots = (dots + 1) % 4
                let dotsStr = String(repeating: ".", count: dots + 1)
                if self.discoveredDevices.isEmpty {
                    self.searchProgress = "جاري البحث\(dotsStr)"
                }
                do {
                    try await Task.sleep(nanoseconds: 300_000_000) // 0.3 ثانية
                } catch {
                    break // تم إلغاء الـ Task
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            self.isSearching = false
            if self.discoveredDevices.isEmpty {
                self.searchProgress = "لم يتم العثور على أجهزة"
            } else {
                self.searchProgress = "تم العثور على \(self.discoveredDevices.count) جهاز"
            }
        }
    }

    /// فحص سريع لجهاز على منفذ معيّن
    private func quickCheckDevice(ip: String, port: UInt16, completion: @escaping (Bool) -> Void) {
        let host = NWEndpoint.Host(ip)
        let port = NWEndpoint.Port(rawValue: port)!
        let connection = NWConnection(host: host, port: port, using: .tcp)

        let timeout = DispatchWorkItem {
            connection.cancel()
            completion(false)
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.15, execute: timeout)

        connection.stateUpdateHandler = { state in
            timeout.cancel()
            switch state {
            case .ready:
                connection.cancel()
                completion(true)
            case .failed, .cancelled:
                completion(false)
            default:
                break
            }
        }
        connection.start(queue: DispatchQueue.global(qos: .userInitiated))
    }

    /// الحصول على عنوان IP المحلي للجوال
    func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                guard let interface = ptr?.pointee else { continue }
                let addrFamily = interface.ifa_addr.pointee.sa_family

                if addrFamily == UInt8(AF_INET) {
                    let name = String(cString: interface.ifa_name)
                    if name == "en0" || name == "en1" || name.starts(with: "pdp_ip") {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(
                            interface.ifa_addr,
                            socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST
                        )
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }

    // MARK: - الاتصال والقطع

    /// الاتصال بالجهاز أو قطع الاتصال
    @discardableResult
    func toggleConnection() -> Bool {
        if isConnected {
            disconnect()
            return false
        } else {
            return connect()
        }
    }

    /// الاتصال بجهاز محدّد
    func connect() -> Bool {
        guard isValidIP(deviceIP) else { return false }
        isConnected = true
        searchProgress = "متصل بنجاح"
        fetchDeviceInfo()
        return true
    }

    /// قطع الاتصال
    func disconnect() {
        isConnected = false
        searchProgress = "غير متصل"
        deviceInfo = DeviceInfo()
    }

    /// التحقق من صحة عنوان IP
    func isValidIP(_ ip: String) -> Bool {
        let components = ip.split(separator: ".")
        guard components.count == 4 else { return false }
        for component in components {
            guard let num = Int(component), num >= 0, num <= 255 else { return false }
        }
        return true
    }

    // MARK: - أوامر الجهاز

    /// إرسال أمر للجهاز (reboot / shutdown / reset_calibration / change_language)
    func sendCommand(endpoint: String) async -> Bool {
        guard let url = URL(string: "\(baseURL)/api/\(endpoint)") else { return false }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }

    /// تحديث إعداد على الجهاز (params PUT)
    func updateParam(key: String, value: Bool) async {
        guard let url = URL(string: "\(baseURL)/api/params/\(key)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(["value": value ? "1" : "0"])
        _ = try? await URLSession.shared.data(for: request)
    }

    /// جلب قيمة معامل من الجهاز
    func fetchParam(key: String) async -> String? {
        guard let url = URL(string: "\(baseURL)/api/params/\(key)") else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return nil
        }
    }

    /// جلب كل معلومات الجهاز
    func fetchDeviceInfo() {
        Task {
            async let dongle = fetchParam(key: "DongleId")
            async let serial = fetchParam(key: "HardwareSerial")
            async let version = fetchParam(key: "Version")
            async let hardware = fetchParam(key: "HardwareType")

            let (d, s, v, h) = await (dongle, serial, version, hardware)
            await MainActor.run {
                self.deviceInfo.dongleId = d ?? "غير متوفر"
                self.deviceInfo.serialNumber = s ?? "غير متوفر"
                self.deviceInfo.softwareVersion = v ?? "غير متوفر"
                self.deviceInfo.hardwareType = h ?? "comma device"
            }
        }
    }

    // MARK: - روابط مباشرة

    /// فتح واجهة الويب الكاملة في المتصفح
    func webInterfaceURL() -> URL? { URL(string: baseURL) }

    /// رابط كاميرا السائق
    func driverCameraURL() -> URL? { URL(string: "\(baseURL)/driver_camera") }

    /// رابط دليل التدريب
    func trainingGuideURL() -> URL? { URL(string: "\(baseURL)/training") }
}

// MARK: - نماذج البيانات

struct DiscoveredDevice: Identifiable {
    let id = UUID()
    let name: String
    let ip: String
    let signalStrength: Int
}

struct DeviceInfo: Equatable {
    var dongleId: String = "---"
    var serialNumber: String = "---"
    var softwareVersion: String = "---"
    var hardwareType: String = "---"
    var freeStorage: String = "---"
    var usedStorage: String = "---"
    var networkType: String = "WiFi"
    var uptime: String = "---"
}
