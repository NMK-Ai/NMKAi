import SwiftUI

// MARK: - مخزن الإعدادات المركزي
/// يحفظ كل الإعدادات في UserDefaults تلقائياً عند أي تغيير

@Observable
final class SettingsStore {
    var settings: AppSettings {
        didSet { save() }
    }

    var deviceStatus: DeviceStatus
    var recentTrips: [DriveTrip]

    private static let storageKey = "com.nmkai.settings"

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.storageKey),
           let decoded = try? JSONDecoder().decode(AppSettings.self, from: data) {
            self.settings = decoded
        } else {
            self.settings = AppSettings()
        }

        // بيانات تجريبية للعرض
        self.deviceStatus = DeviceStatus(
            isConnected: true,
            serialNumber: "NMK-2024-001234",
            firmwareVersion: "2.1.0",
            batteryLevel: 87,
            storageUsedGB: 12.4,
            storageTotalGB: 64,
            temperatureC: 28.5
        )

        self.recentTrips = DriveTrip.sampleTrips
    }

    // MARK: - الحفظ

    private func save() {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: Self.storageKey)
        }
    }

    // MARK: - مساعدات

    func resetAllSettings() {
        settings = AppSettings()
    }
}

// MARK: - بيانات تجريبية للرحلات

extension DriveTrip {
    static let sampleTrips: [DriveTrip] = [
        DriveTrip(
            id: UUID(),
            date: .now.addingTimeInterval(-3600 * 2),
            durationMinutes: 45,
            distanceKm: 52.3,
            averageSpeed: 70,
            maxSpeed: 95,
            startLocation: "الرياض",
            endLocation: "الخرج",
            autopilotEngagedKm: 48.1,
            interventionsCount: 3,
            score: 92
        ),
        DriveTrip(
            id: UUID(),
            date: .now.addingTimeInterval(-3600 * 26),
            durationMinutes: 120,
            distanceKm: 145.0,
            averageSpeed: 72,
            maxSpeed: 120,
            startLocation: "الرياض",
            endLocation: "القصيم",
            autopilotEngagedKm: 138.5,
            interventionsCount: 7,
            score: 88
        ),
        DriveTrip(
            id: UUID(),
            date: .now.addingTimeInterval(-3600 * 50),
            durationMinutes: 22,
            distanceKm: 18.6,
            averageSpeed: 50,
            maxSpeed: 70,
            startLocation: "البيت",
            endLocation: "المكتب",
            autopilotEngagedKm: 12.2,
            interventionsCount: 1,
            score: 97
        )
    ]
}
