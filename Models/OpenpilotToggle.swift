import SwiftUI

// MARK: - إعدادات القائد الآلي الحقيقية
/// هذه هي الـ toggles الفعلية التي يرسلها تطبيقك لجهاز القائد الآلي عبر API
/// (مفتاح params + فئة + وصف عربي)

struct OpenpilotToggle: Identifiable, Codable, Equatable {
    let id: String          // المفتاح الفريد (يُستخدم كـ params key)
    let title: String       // العنوان بالعربية
    let description: String // الوصف بالعربية
    let icon: String        // أيقونة SF Symbols
    let iconColorName: String
    let category: OpenpilotCategory
    var isEnabled: Bool
    let requiresReboot: Bool
    let isAlpha: Bool       // ميزة تجريبية

    var iconColor: Color {
        // تحويل اسم اللون المخزّن إلى Color فعلي
        switch iconColorName {
        case "blue":   return .nmkPrimary
        case "green":  return .nmkSuccess
        case "orange": return .nmkWarning
        case "red":    return .nmkDanger
        case "purple": return .nmkSecondary
        case "cyan":   return .cyan
        case "pink":   return .pink
        case "indigo": return .indigo
        case "gray":   return .nmkTextSecondary
        case "yellow": return .yellow
        default:       return .nmkPrimary
        }
    }
}

enum OpenpilotCategory: String, Codable, CaseIterable, Identifiable {
    case main = "الإعدادات الرئيسية"
    case longitudinal = "التحكم الطولي"
    case lateral = "التحكم الجانبي"
    case experimental = "الميزات التجريبية"
    case ui = "واجهة المستخدم"
    case safety = "السلامة"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .main:         return "car.fill"
        case .longitudinal: return "arrow.up.arrow.down"
        case .lateral:      return "arrow.left.arrow.right"
        case .experimental: return "flask.fill"
        case .ui:           return "eye"
        case .safety:       return "shield.lefthalf.filled"
        }
    }
}

// MARK: - القائمة الافتراضية للإعدادات
/// نفس الإعدادات الموجودة في تطبيق AlQaedAlali الأصلي

extension OpenpilotToggle {
    static let defaultToggles: [OpenpilotToggle] = [
        // === الإعدادات الرئيسية ===
        .init(id: "OpenpilotEnabledToggle", title: "تفعيل القائد الآلي",
              description: "تفعيل أو تعطيل نظام القائد الآلي", icon: "car.fill",
              iconColorName: "blue", category: .main, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "IsLdwEnabled", title: "تنبيه مغادرة المسار",
              description: "تفعيل تنبيهات مغادرة المسار", icon: "road.lanes",
              iconColorName: "orange", category: .main, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "IsMetric", title: "النظام المتري",
              description: "استخدام الكيلومتر بدلاً من الأميال", icon: "speedometer",
              iconColorName: "green", category: .main, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "RecordFront", title: "تسجيل الكاميرا الأمامية",
              description: "تسجيل فيديو الكاميرا الأمامية", icon: "camera.fill",
              iconColorName: "red", category: .main, isEnabled: false,
              requiresReboot: false, isAlpha: false),

        // === التحكم الطولي ===
        .init(id: "ExperimentalLongitudinalEnabled", title: "التحكم الطولي ألفا",
              description: "تفعيل التحكم الطولي التجريبي للتسارع والفرامل", icon: "arrow.up.arrow.down",
              iconColorName: "purple", category: .longitudinal, isEnabled: false,
              requiresReboot: true, isAlpha: true),
        .init(id: "DisableRadar", title: "تعطيل الرادار",
              description: "تعطيل استخدام رادار السيارة", icon: "antenna.radiowaves.left.and.right.slash",
              iconColorName: "gray", category: .longitudinal, isEnabled: false,
              requiresReboot: true, isAlpha: true),
        .init(id: "EndToEndLongitudinal", title: "التحكم الطولي الشامل",
              description: "استخدام نموذج الذكاء الاصطناعي للتحكم الكامل", icon: "brain",
              iconColorName: "pink", category: .longitudinal, isEnabled: false,
              requiresReboot: false, isAlpha: true),

        // === التحكم الجانبي ===
        .init(id: "LateralControlEnabled", title: "التحكم الجانبي",
              description: "تفعيل التحكم بالتوجيه", icon: "arrow.left.arrow.right",
              iconColorName: "blue", category: .lateral, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "AlwaysOnLateral", title: "التوجيه المستمر",
              description: "الحفاظ على التحكم الجانبي عند الضغط على البنزين أو الفرامل", icon: "infinity",
              iconColorName: "cyan", category: .lateral, isEnabled: false,
              requiresReboot: false, isAlpha: false),
        .init(id: "LanelessMode", title: "الوضع بدون خطوط",
              description: "القيادة بدون الاعتماد على خطوط المسار", icon: "road.lanes.curved.right",
              iconColorName: "indigo", category: .lateral, isEnabled: false,
              requiresReboot: false, isAlpha: false),

        // === الميزات التجريبية ===
        .init(id: "ExperimentalMode", title: "الوضع التجريبي",
              description: "تفعيل الميزات التجريبية مثل التوقف عند الإشارات", icon: "flask.fill",
              iconColorName: "orange", category: .experimental, isEnabled: false,
              requiresReboot: false, isAlpha: true),
        .init(id: "NavigateOnOpenpilot", title: "الملاحة على القائد الآلي",
              description: "السماح للقائد الآلي بتغيير المسارات تلقائياً", icon: "map.fill",
              iconColorName: "green", category: .experimental, isEnabled: false,
              requiresReboot: false, isAlpha: true),
        .init(id: "EnableMads", title: "تفعيل MADS",
              description: "نظام مساعدة القيادة المعدل", icon: "gearshape.2.fill",
              iconColorName: "purple", category: .experimental, isEnabled: false,
              requiresReboot: true, isAlpha: true),

        // === واجهة المستخدم ===
        .init(id: "ShowDebugUI", title: "واجهة التصحيح",
              description: "عرض معلومات التصحيح على الشاشة", icon: "ladybug.fill",
              iconColorName: "red", category: .ui, isEnabled: false,
              requiresReboot: false, isAlpha: false),
        .init(id: "ShowDMCamera", title: "عرض كاميرا السائق",
              description: "عرض صورة كاميرا مراقبة السائق", icon: "person.fill.viewfinder",
              iconColorName: "blue", category: .ui, isEnabled: false,
              requiresReboot: false, isAlpha: false),
        .init(id: "ShowSpeedLimit", title: "عرض حد السرعة",
              description: "عرض حد السرعة على الشاشة", icon: "gauge.with.dots.needle.33percent",
              iconColorName: "yellow", category: .ui, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "ShowSteeringSaturated", title: "تنبيه التوجيه",
              description: "عرض تنبيه عند الوصول لحد التوجيه", icon: "exclamationmark.triangle.fill",
              iconColorName: "orange", category: .ui, isEnabled: true,
              requiresReboot: false, isAlpha: false),

        // === السلامة ===
        .init(id: "IsFcwEnabled", title: "تنبيه الاصطدام الأمامي",
              description: "تفعيل تنبيهات الاصطدام الأمامي", icon: "car.front.waves.up.fill",
              iconColorName: "red", category: .safety, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "DisenageOnAccel", title: "إلغاء بالتسارع",
              description: "إلغاء القائد الآلي عند الضغط على البنزين", icon: "bolt.car.fill",
              iconColorName: "orange", category: .safety, isEnabled: true,
              requiresReboot: false, isAlpha: false),
        .init(id: "DisengageOnBrake", title: "إلغاء بالفرامل",
              description: "إلغاء القائد الآلي عند الضغط على الفرامل", icon: "car.side.rear.and.collision.and.car.side.front.slash",
              iconColorName: "red", category: .safety, isEnabled: true,
              requiresReboot: false, isAlpha: false),
    ]
}
