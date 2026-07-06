import SwiftUI

// MARK: - شاشة إعدادات الخريطة
/// تشمل: تثبيت الخريطة، نوعها، تدوير، اتجاه الشمال، عرض المعلومات، الوضع الليلي

struct MapSettingsView: View {
    @Binding var settings: MapSettings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                // MARK: تثبيت الخريطة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تثبيت الخريطة", subtitle: "تثبيت العرض على وضع معيّن")

                    NMKToggleCard(
                        "تثبيت الخريطة",
                        subtitle: "إيقاف تحريك الخريطة يدوياً (Lock)",
                        icon: "lock",
                        iconColor: .nmkWarning,
                        isOn: $settings.lockMapEnabled
                    )

                    NMKToggleCard(
                        "تثبيت على السيارة",
                        subtitle: "إبقاء موقع السيارة في منتصف الخريطة دائماً",
                        icon: "location.circle",
                        iconColor: .nmkPrimary,
                        isOn: $settings.lockToVehicleEnabled
                    )
                }

                // MARK: نوع الخريطة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("نوع الخريطة", subtitle: "نمط العرض")

                    NMKSelectionList(
                        title: "النوع",
                        icon: "map",
                        options: MapViewType.allCases,
                        selection: $settings.mapType,
                        optionLabel: { $0.displayName },
                        optionIcon: { $0.icon }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: تدوير واتجاه
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("التدوير والاتجاه", subtitle: "تحكّم بدوران الخريطة")

                    NMKToggleCard(
                        "تدوير تلقائي",
                        subtitle: "تدوير الخريطة مع اتجاه القيادة",
                        icon: "arrow.triangle.2.circlepath",
                        iconColor: .nmkPrimary,
                        isOn: $settings.autoRotateEnabled
                    )

                    NMKToggleCard(
                        "إظهار الشمال",
                        subtitle: "عرض سهم اتجاه الشمال دائماً",
                        icon: "location.north.line",
                        iconColor: .nmkPrimary,
                        isOn: $settings.showCompassEnabled
                    )
                }

                // MARK: حجم النص والتكبير
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("الحجم", subtitle: "ضبط حجم النص على الخريطة")

                    NMKSelectionList(
                        title: "حجم النص",
                        icon: "textformat.size",
                        options: MapTextSize.allCases,
                        selection: $settings.mapTextSize,
                        optionLabel: { $0.displayName }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: عرض المعلومات
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("المعلومات المعروضة", subtitle: "ما يظهر فوق الخريطة")

                    NMKToggleCard(
                        "حد السرعة",
                        subtitle: "إظهار لافتة حد السرعة الحالي",
                        icon: "speedometer",
                        isOn: $settings.showSpeedLimitSign
                    )

                    NMKToggleCard(
                        "اسم الشارع",
                        subtitle: "إظهار اسم الشارع الحالي",
                        icon: "signpost.right",
                        isOn: $settings.showStreetName
                    )

                    NMKToggleCard(
                        "حالة المرور",
                        subtitle: "إظهار ألوان ازدحام المرور",
                        icon: "car.2",
                        isOn: $settings.showTraffic
                    )

                    NMKToggleCard(
                        "المسار المتوقَّع",
                        subtitle: "عرض المسار الذي يعتزمه النظام",
                        icon: "arrow.up.arrow.down.square",
                        isOn: $settings.showPredictedPath
                    )
                }

                // MARK: الوضع الليلي
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("الوضع الليلي", subtitle: "راحة العين في الإضاءة المنخفضة")

                    NMKToggleCard(
                        "الوضع الليلي التلقائي",
                        subtitle: "تعتيم تلقائي عند الغروب",
                        icon: "moon",
                        iconColor: .nmkSecondary,
                        isOn: $settings.nightModeAuto
                    )

                    NMKToggleCard(
                        "وضع عدم الإزعاج",
                        subtitle: "إخفاء الخريطة أثناء القيادة لتركيز الانتباه",
                        icon: "eye.slash",
                        iconColor: .nmkWarning,
                        isOn: $settings.distractionFreeMode
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color.nmkBackground)
        .navigationTitle("إعدادات الخريطة")
        .navigationBarTitleDisplayMode(.inline)
    }
}
