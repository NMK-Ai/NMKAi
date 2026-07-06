import Foundation

// MARK: - ملف السيارة
/// بيانات السيارة المتصلة بالتطبيق

struct CarProfile: Codable, Equatable {
    /// الاسم المعروض للسيارة (يختاره المستخدم)
    var displayName: String = "سيارتي"

    /// العلامة التجارية
    var brand: String = ""

    /// الموديل
    var model: String = ""

    /// سنة الصنع
    var year: Int = 2024

    /// نوع الوقود
    var fuelType: FuelType = .gasoline

    /// اللون (اختياري)
    var colorName: String = ""

    /// رقم اللوحة (اختياري)
    var plateNumber: String = ""

    /// نوع ناقل الحركة
    var transmission: TransmissionType = .automatic

    /// هل السيارة مدعومة بالكامل؟
    var isFullySupported: Bool = true

    /// مستوى الدعم
    var supportLevel: SupportLevel = .full
}

// MARK: - نوع الوقود

enum FuelType: String, Codable, CaseIterable, Identifiable {
    case gasoline, diesel, hybrid, electric, pluginHybrid

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .gasoline:     return "بنزين"
        case .diesel:       return "ديزل"
        case .hybrid:       return "هجين"
        case .electric:     return "كهربائي"
        case .pluginHybrid: return "هجين قابل للشحن"
        }
    }

    var icon: String {
        switch self {
        case .gasoline:     return "fuelpump"
        case .diesel:       return "fuelpump"
        case .hybrid:       return "bolt.car"
        case .electric:     return "bolt.car.fill"
        case .pluginHybrid: return "bolt.car"
        }
    }
}

// MARK: - نوع ناقل الحركة

enum TransmissionType: String, Codable, CaseIterable, Identifiable {
    case automatic, manual

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .automatic: return "أوتوماتيك"
        case .manual:    return "يدوي"
        }
    }
}

// MARK: - مستوى الدعم

enum SupportLevel: String, Codable, CaseIterable, Identifiable {
    case full, partial, limited

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .full:     return "مدعومة بالكامل"
        case .partial:  return "مدعومة جزئياً"
        case .limited:  return "دعم محدود"
        }
    }

    var color: String {
        switch self {
        case .full:     return "nmkSuccess"
        case .partial:  return "nmkWarning"
        case .limited:  return "nmkDanger"
        }
    }
}
