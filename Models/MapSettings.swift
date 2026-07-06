import Foundation
import CoreGraphics

// MARK: - إعدادات الخريطة
/// كل خيارات تثبيت/عرض الخريطة

struct MapSettings: Codable, Equatable {
    // MARK: تثبيت الخريطة
    /// تثبيت الخريطة في وضع العرض الثابت (Lock)
    var lockMapEnabled: Bool = false

    /// تثبيت موقع السيارة في منتصف الخريطة دائماً
    var lockToVehicleEnabled: Bool = true

    // MARK: عرض الخريطة
    /// نوع الخريطة: قياسية / قمر صناعي / هجين
    var mapType: MapViewType = .standard

    /// تدوير الخريطة مع اتجاه القيادة
    var autoRotateEnabled: Bool = true

    /// إظهار اتجاه الشمال دائماً
    var showCompassEnabled: Bool = true

    /// حجم النص على الخريطة
    var mapTextSize: MapTextSize = .medium

    // MARK: عرض المعلومات
    /// إظهار حد السرعة على الخريطة
    var showSpeedLimitSign: Bool = true

    /// إظهار اسم الشارع الحالي
    var showStreetName: Bool = true

    /// إظهار حركة المرور (ألوان ازدحام)
    var showTraffic: Bool = true

    /// إظهار المسار المُتوقَّع للسيارة
    var showPredictedPath: Bool = true

    // MARK: عدم الإزعاج
    /// تعتيم الخريطة ليلاً
    var nightModeAuto: Bool = true

    /// إخفاء الخريطة أثناء القيادة لتركيز الانتباه
    var distractionFreeMode: Bool = false
}

// MARK: - أنواع تعدادات الخريطة

enum MapViewType: String, Codable, CaseIterable, Identifiable {
    case standard, satellite, hybrid

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .standard:  return "قياسية"
        case .satellite: return "قمر صناعي"
        case .hybrid:    return "هجين"
        }
    }

    var icon: String {
        switch self {
        case .standard:  return "map"
        case .satellite: return "globe.americas"
        case .hybrid:    return "square.stack.3d.up"
        }
    }
}

enum MapTextSize: String, Codable, CaseIterable, Identifiable {
    case small, medium, large

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .small:  return "صغير"
        case .medium: return "متوسط"
        case .large:  return "كبير"
        }
    }

    var scale: CGFloat {
        switch self {
        case .small:  return 0.85
        case .medium: return 1.0
        case .large:  return 1.2
        }
    }
}
