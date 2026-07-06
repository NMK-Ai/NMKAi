import Foundation

// MARK: - إعدادات القيادة
/// كل المزايا القابلة للتفعيل/التعطيل في تبويب القيادة

struct DrivingSettings: Codable, Equatable {
    // MARK: تغيير المسار
    /// تحديد كيفية تغيير المسار: تلقائي، باللمس، أو معطّل
    var laneChangeMode: LaneChangeMode = .nudge

    // MARK: التحكم بالسرعة
    /// تفعيل مثبت السرعة التكيفي (ACC)
    var adaptiveCruiseControlEnabled: Bool = true

    /// الحد الأقصى للسرعة (كم/س)
    var maxSpeedLimit: Int = 120

    /// نسبة التباطؤ عند الاقتراب من المنعطفات
    var curveSlowdownPercentage: Int = 20

    // MARK: تثبيت المسار (Lane Centering)
    /// تفعيل تثبيت السيارة في منتصف المسار
    var laneCenteringEnabled: Bool = true

    /// قوة التثبيت (كلما زادت = تثبيت أقوى وأسرع)
    var laneCenteringStrength: LaneCenteringStrength = .medium

    // MARK: المسافة الأمامية
    /// المسافة الافتراضية من السيارة الأمامية
    var followingDistance: FollowingDistance = .medium

    /// إبطاء تلقائي عند اقتراب السيارة الأمامية بشكل مفاجئ
    var dynamicSlowDownEnabled: Bool = true

    // MARK: مراقبة السائق
    /// تنبيه إذا غاب السائق عن الانتباه
    var driverMonitoringEnabled: Bool = true

    /// الحساسية لكشف الانتباه
    var driverMonitoringSensitivity: SensitivityLevel = .medium

    // MARK: أوضاع القيادة
    /// الوضع الحالي للقيادة
    var drivingMode: DrivingMode = .balanced

    /// تفعيل الوضع التجريبي (مزايا متقدمة)
    var experimentalModeEnabled: Bool = false
}

// MARK: - أنواع تعدادات القيادة

enum LaneChangeMode: String, Codable, CaseIterable, Identifiable {
    case disabled   // معطّل
    case nudge      // باللمس (نudge الدركسون)
    case automatic  // تلقائي

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .disabled:  return "معطّل"
        case .nudge:     return "بلمس الدركسون"
        case .automatic: return "تلقائي"
        }
    }

    var icon: String {
        switch self {
        case .disabled:  return "xmark.circle"
        case .nudge:     return "hand.tap"
        case .automatic: return "arrow.left.arrow.right"
        }
    }

    var description: String {
        switch self {
        case .disabled:  return "تغيير المسار معطّل تماماً"
        case .nudge:     return "اضغط الدركسون لتأكيد تغيير المسار"
        case .automatic: return "السيارة تغيّر المسار تلقائياً عند الحاجة"
        }
    }
}

enum LaneCenteringStrength: String, Codable, CaseIterable, Identifiable {
    case gentle, medium, firm

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .gentle: return "لطيف"
        case .medium: return "متوسط"
        case .firm:   return "قوي"
        }
    }

    var percentage: Double {
        switch self {
        case .gentle: return 0.4
        case .medium: return 0.7
        case .firm:   return 1.0
        }
    }
}

enum FollowingDistance: String, Codable, CaseIterable, Identifiable {
    case close, medium, far, veryFar

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .close:   return "قريب"
        case .medium:  return "متوسط"
        case .far:     return "بعيد"
        case .veryFar: return "بعيد جداً"
        }
    }

    /// المسافة بالمتر عند 100 كم/س
    var metersAt100kmh: Double {
        switch self {
        case .close:   return 15
        case .medium:  return 25
        case .far:     return 35
        case .veryFar: return 50
        }
    }

    var icon: String {
        switch self {
        case .close:   return "arrow.down"
        case .medium:  return "arrow.down.right"
        case .far:     return "arrow.right"
        case .veryFar: return "arrow.up.right"
        }
    }
}

enum SensitivityLevel: String, Codable, CaseIterable, Identifiable {
    case low, medium, high

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .low:    return "منخفضة"
        case .medium: return "متوسطة"
        case .high:   return "عالية"
        }
    }
}

enum DrivingMode: String, Codable, CaseIterable, Identifiable {
    case eco, balanced, sport

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .eco:      return "موفّر"
        case .balanced: return "متوازن"
        case .sport:    return "رياضي"
        }
    }

    var icon: String {
        switch self {
        case .eco:      return "leaf"
        case .balanced: return "scalemass"
        case .sport:    return "bolt"
        }
    }

    var description: String {
        switch self {
        case .eco:      return "قيادة هادئة وموفّرة للوقود"
        case .balanced: return "توازن بين الراحة والأداء"
        case .sport:    return "استجابة سريعة وقيادة ديناميكية"
        }
    }
}
