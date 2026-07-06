import Foundation

// MARK: - إعدادات العرض المباشر
/// خيارات بث كاميرا الجهاز وعرض المعلومات الحية

struct LiveViewSettings: Codable, Equatable {
    // MARK: البث
    /// تفعيل العرض المباشر للكاميرا
    var liveViewEnabled: Bool = true

    /// جودة البث
    var streamQuality: StreamQuality = .auto

    /// عدد الإطارات في الثانية
    var frameRate: FrameRate = .fps30

    /// زمن استجابة البث (كلما قلّ = أسرع)
    var latencyMode: LatencyMode = .balanced

    // MARK: عرض المعلومات
    /// إظهار معلومات القيادة فوق الفيديو (Overlay)
    var showDrivingOverlay: Bool = true

    /// إظهار السرعة الحالية
    var showCurrentSpeed: Bool = true

    /// إظهار حد السرعة
    var showSpeedLimit: Bool = true

    /// إظهار حالة المسار
    var showLaneStatus: Bool = true

    /// إظهار المسافة من السيارة الأمامية
    var showFollowingDistance: Bool = true

    // MARK: التسجيل
    /// تسجيل تلقائي للرحلات
    var autoRecordDrives: Bool = true

    /// جودة التسجيل (منفصلة عن جودة البث)
    var recordQuality: RecordQuality = .high

    /// الاحتفاظ بالتسجيلات (بالأيام)
    var retentionDays: Int = 14

    /// تسجيل بالصوت
    var recordAudio: Bool = false
}

// MARK: - جودة البث

enum StreamQuality: String, Codable, CaseIterable, Identifiable {
    case auto, low, medium, high

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .auto:   return "تلقائي"
        case .low:    return "منخفضة"
        case .medium: return "متوسطة"
        case .high:   return "عالية"
        }
    }

    var resolution: String {
        switch self {
        case .auto:   return "تلقائي حسب الشبكة"
        case .low:    return "480p"
        case .medium: return "720p"
        case .high:   return "1080p"
        }
    }
}

enum FrameRate: Int, Codable, CaseIterable, Identifiable {
    case fps15 = 15
    case fps24 = 24
    case fps30 = 30
    case fps60 = 60

    var id: Int { rawValue }

    var displayName: String { "\(rawValue) إطار/ث" }
}

enum LatencyMode: String, Codable, CaseIterable, Identifiable {
    case ultraLow, balanced, quality

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .ultraLow: return "أسرع استجابة"
        case .balanced: return "متوازن"
        case .quality:  return "أفضل جودة"
        }
    }

    var targetLatencyMs: Int {
        switch self {
        case .ultraLow: return 100
        case .balanced: return 300
        case .quality:  return 800
        }
    }
}

enum RecordQuality: String, Codable, CaseIterable, Identifiable {
    case standard, high, ultra

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .standard: return "عادية (720p)"
        case .high:     return "عالية (1080p)"
        case .ultra:    return "فائقة (4K)"
        }
    }
}
