import Foundation

// MARK: - إعدادات التنبيهات
/// كل التنبيهات الصوتية والبصرية وحساسيتها

struct AlertSettings: Codable, Equatable {
    // MARK: التنبيهات الصوتية
    /// تفعيل التنبيهات الصوتية بشكل عام
    var soundAlertsEnabled: Bool = true

    /// نوع الصوت المستخدم للتنبيه
    var alertSoundType: AlertSoundType = .voice

    /// مستوى صوت التنبيهات (0.0 - 1.0)
    var alertVolume: Double = 0.7

    // MARK: تنبيهات المسار
    /// تنبيه عند الخروج عن المسار
    var laneDepartureAlert: Bool = true

    /// تنبيه عند الاقتراب من حافة المسار
    var laneEdgeWarning: Bool = true

    // MARK: تنبيهات السرعة
    /// تنبيه عند تجاوز حد السرعة
    var speedingAlert: Bool = true

    /// نسبة التفاوت المسموحة فوق حد السرعة
    var speedTolerance: Int = 5

    /// تنبيه عند الاقتراب من كاميرا مراقبة السرعة
    var speedCameraAlert: Bool = true

    // MARK: تنبيهات المسافة
    /// تنبيه عند الاقتراب الشديد من السيارة الأمامية
    var forwardCollisionAlert: Bool = true

    /// الحساسية لتنبيه التصادم
    var collisionAlertSensitivity: SensitivityLevel = .medium

    // MARK: تنبيهات السائق
    /// تنبيه عند شعور السائق بالنعاس
    var drowsinessAlert: Bool = true

    /// تنبيه عند تشتت الانتباه (هاتف، طعام...)
    var distractionAlert: Bool = true

    /// تنبيه دوري للمس السائق للمقود
    var steeringReminder: Bool = true

    // MARK: تنبيهات إضافية
    /// تنبيه عند الاقتراب من نقطة وصول محددة
    var destinationApproachAlert: Bool = true

    /// تنبيه عند انخفاض الوقود/البطارية
    var lowFuelAlert: Bool = true

    /// اهتزاز الهاتف مع التنبيه
    var hapticFeedback: Bool = true
}

// MARK: - نوع صوت التنبيه

enum AlertSoundType: String, Codable, CaseIterable, Identifiable {
    case voice     // صوت بشري طبيعي
    case tone      // نغمة بسيطة
    case chime     // رنين لطيف
    case minimal   // الحد الأدنى من الصوت

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .voice:   return "صوت بشري"
        case .tone:    return "نغمة"
        case .chime:   return "رنين"
        case .minimal: return "أقل قدر"
        }
    }

    var icon: String {
        switch self {
        case .voice:   return "person.wave.2"
        case .tone:    return "speaker.wave.1"
        case .chime:   return "bell"
        case .minimal: return "speaker.wave.1"
        }
    }

    var description: String {
        switch self {
        case .voice:   return "تنبيهات بصوت بشري طبيعي وواضح"
        case .tone:    return "نغمات بسيطة وسريعة"
        case .chime:   return "رنين لطيف غير مزعج"
        case .minimal: return "أقل قدر من الصوت الممكن"
        }
    }
}
