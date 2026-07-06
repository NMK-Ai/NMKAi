import Foundation

// MARK: - الحاوية الكاملة للإعدادات
/// تجمع كل إعدادات التطبيق في مكان واحد، تُحفظ في UserDefaults

struct AppSettings: Codable, Equatable {
    var driving: DrivingSettings = .init()
    var car: CarProfile = .init()
    var map: MapSettings = .init()
    var liveView: LiveViewSettings = .init()
    var alerts: AlertSettings = .init()

    // إعدادات عامة
    var language: AppLanguage = .arabic
    var theme: AppTheme = .dark
    var onboardingCompleted: Bool = false
    var devicePaired: Bool = false
    var deviceSerial: String = ""
}

// MARK: - لغة التطبيق

enum AppLanguage: String, Codable, CaseIterable, Identifiable {
    case arabic, english

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .arabic: return "العربية"
        case .english: return "English"
        }
    }

    var locale: Locale {
        switch self {
        case .arabic: return Locale(identifier: "ar")
        case .english: return Locale(identifier: "en")
        }
    }

    var layoutDirection: String {
        switch self {
        case .arabic: return "rtl"
        case .english: return "ltr"
        }
    }
}

// MARK: - سمة التطبيق

enum AppTheme: String, Codable, CaseIterable, Identifiable {
    case dark, light, auto

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .dark: return "داكن"
        case .light: return "فاتح"
        case .auto: return "تلقائي"
        }
    }
}

// MARK: - حالة الجهاز المتصل

struct DeviceStatus: Codable, Equatable {
    var isConnected: Bool = false
    var serialNumber: String = ""
    var firmwareVersion: String = "1.0.0"
    var batteryLevel: Int = 100  // النسبة المئوية
    var storageUsedGB: Double = 0
    var storageTotalGB: Double = 64
    var temperatureC: Double = 25.0
    var lastConnected: Date = .init()
}

// MARK: - بيانات الرحلة (لعرض السجل)

struct DriveTrip: Identifiable, Codable, Equatable {
    let id: UUID
    var date: Date
    var durationMinutes: Int
    var distanceKm: Double
    var averageSpeed: Double
    var maxSpeed: Double
    var startLocation: String
    var endLocation: String
    var autopilotEngagedKm: Double
    var interventionsCount: Int
    var score: Int  // 0-100

    var autopilotPercentage: Double {
        guard distanceKm > 0 else { return 0 }
        return (autopilotEngagedKm / distanceKm) * 100
    }
}
