import SwiftUI

// MARK: - نقطة دخول تطبيق NMK Ai (المدمج مع القائد الآلي)
// يجمع: نظام تصميم NMK Ai + كل مزايا القائد الآلي الأصلية + شاشات الإعدادات الخمس

@main
struct NMKAiApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                // ✅ ضبط العربية على الواجهة فقط (بدون إجبار UserDefaults — يحترم لغة الجهاز)
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.layoutDirection, .rightToLeft)
                .preferredColorScheme(.dark)
        }
    }
}
