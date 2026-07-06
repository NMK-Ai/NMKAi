import SwiftUI

// MARK: - نظام الألوان والهوية البصرية لـ NMK Ai
// كل الألوان هنا أصلية ومصمّمة خصيصاً لـ NMK Ai

extension Color {
    /// اللون الأساسي — أزرق نيون (هوية NMK Ai)
    static let nmkPrimary = Color(red: 0.10, green: 0.56, blue: 1.0)

    /// اللون الثانوي — بنفسجي كهربائي
    static let nmkSecondary = Color(red: 0.49, green: 0.31, blue: 0.97)

    /// لون التأكيد / النجاح — أخضر نيون
    static let nmkSuccess = Color(red: 0.20, green: 0.85, blue: 0.45)

    /// لون التحذير — برتقالي
    static let nmkWarning = Color(red: 1.0, green: 0.62, blue: 0.15)

    /// لون الخطر — أحمر
    static let nmkDanger = Color(red: 0.95, green: 0.27, blue: 0.32)

    /// خلفية التطبيق — أسود مزرق عميق
    static let nmkBackground = Color(red: 0.05, green: 0.06, blue: 0.09)

    /// خلفية البطاقات — رمادي داكن شفاف
    static let nmkCard = Color(red: 0.11, green: 0.12, blue: 0.16)

    /// خلفية البطاقات المُضافة عليها لمسة
    static let nmkCardHighlighted = Color(red: 0.15, green: 0.16, blue: 0.21)

    /// لون النص الأساسي
    static let nmkTextPrimary = Color.white

    /// لون النص الثانوي
    static let nmkTextSecondary = Color(red: 0.62, green: 0.64, blue: 0.70)

    /// لون النص الثالث
    static let nmkTextTertiary = Color(red: 0.43, green: 0.45, blue: 0.50)

    /// الحدود
    static let nmkBorder = Color(red: 0.20, green: 0.21, blue: 0.26)

    /// لون معطّل
    static let nmkDisabled = Color(red: 0.30, green: 0.31, blue: 0.36)
}

// MARK: - توافق الألوان مع ShapeStyle
// ضروري في Swift 6 / iOS 17+ ليقبل foregroundStyle(.nmkPrimary)

extension ShapeStyle where Self == Color {
    public static var nmkPrimary: Color { .init(red: 0.10, green: 0.56, blue: 1.0) }
    public static var nmkSecondary: Color { .init(red: 0.49, green: 0.31, blue: 0.97) }
    public static var nmkSuccess: Color { .init(red: 0.20, green: 0.85, blue: 0.45) }
    public static var nmkWarning: Color { .init(red: 1.0, green: 0.62, blue: 0.15) }
    public static var nmkDanger: Color { .init(red: 0.95, green: 0.27, blue: 0.32) }
    public static var nmkBackground: Color { .init(red: 0.05, green: 0.06, blue: 0.09) }
    public static var nmkCard: Color { .init(red: 0.11, green: 0.12, blue: 0.16) }
    public static var nmkCardHighlighted: Color { .init(red: 0.15, green: 0.16, blue: 0.21) }
    public static var nmkTextPrimary: Color { .white }
    public static var nmkTextSecondary: Color { .init(red: 0.62, green: 0.64, blue: 0.70) }
    public static var nmkTextTertiary: Color { .init(red: 0.43, green: 0.45, blue: 0.50) }
    public static var nmkBorder: Color { .init(red: 0.20, green: 0.21, blue: 0.26) }
    public static var nmkDisabled: Color { .init(red: 0.30, green: 0.31, blue: 0.36) }
}


// MARK: - الخطوط
enum NMKFont {
    static func title() -> Font { .system(.title2, design: .rounded).weight(.bold) }
    static func headline() -> Font { .system(.headline, design: .rounded).weight(.semibold) }
    static func body() -> Font { .system(.body, design: .rounded) }
    static func subheadline() -> Font { .system(.subheadline, design: .rounded) }
    static func caption() -> Font { .system(.caption, design: .rounded) }
    static func largeTitle() -> Font { .system(.largeTitle, design: .rounded).weight(.bold) }
}

// MARK: - قيم التصميم الثابتة
enum NMKMetrics {
    static let cornerRadius: CGFloat = 16
    static let cornerRadiusSmall: CGFloat = 10
    static let cardPadding: CGFloat = 16
    static let sectionSpacing: CGFloat = 24
    static let itemSpacing: CGFloat = 12
}
