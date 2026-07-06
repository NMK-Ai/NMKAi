import SwiftUI

// MARK: - شاشة إعدادات القيادة
/// تشمل: تغيير المسار، تثبيت المسار، التحكم بالسرعة، المسافة الأمامية، أوضاع القيادة، الوضع التجريبي

struct DrivingSettingsView: View {
    @Binding var settings: DrivingSettings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                // MARK: تغيير المسار
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تغيير المسار", subtitle: "تحكّم بكيفية تغيير المسار أثناء القيادة")

                    NMKSelectionList(
                        title: "وضع تغيير المسار",
                        subtitle: settings.laneChangeMode.description,
                        icon: "arrow.left.arrow.right",
                        options: LaneChangeMode.allCases,
                        selection: $settings.laneChangeMode,
                        optionLabel: { $0.displayName },
                        optionDetail: { $0.description },
                        optionIcon: { $0.icon }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: تثبيت المسار
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تثبيت المسار", subtitle: "إبقاء السيارة في منتصف المسار")

                    NMKToggleCard(
                        "تثبيت منتصف المسار",
                        subtitle: "تثبيت تلقائي للسيارة في وسط المسار",
                        icon: "arrow.up.and.down",
                        iconColor: .nmkPrimary,
                        isOn: $settings.laneCenteringEnabled
                    )

                    if settings.laneCenteringEnabled {
                        NMKSelectionList(
                            title: "قوة التثبيت",
                            subtitle: "كلما زادت القوة = تثبيت أسرع وأقوى",
                            icon: "gauge.with.dots.needle.67percent",
                            options: LaneCenteringStrength.allCases,
                            selection: $settings.laneCenteringStrength,
                            optionLabel: { $0.displayName }
                        )
                        .padding(.horizontal, 4)
                        .transition(.opacity)
                    }
                }

                // MARK: التحكم بالسرعة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("التحكم بالسرعة", subtitle: "مثبت السرعة التكيفي والحدود")

                    NMKToggleCard(
                        "مثبت السرعة التكيفي",
                        subtitle: "الحفاظ على سرعة ثابتة مع مسافة آمنة",
                        icon: "speedometer",
                        iconColor: .nmkSuccess,
                        isOn: $settings.adaptiveCruiseControlEnabled
                    )

                    NMKSliderCard(
                        title: "الحد الأقصى للسرعة",
                        subtitle: "أعلى سرعة مسموح بها للنظام",
                        icon: "gauge",
                        range: 30...160,
                        step: 5,
                        unit: "كم/س",
                        value: Binding(
                            get: { Double(settings.maxSpeedLimit) },
                            set: { settings.maxSpeedLimit = Int($0) }
                        )
                    )

                    NMKSliderCard(
                        title: "تباطؤ المنعطفات",
                        subtitle: "نسبة التباطؤ عند الاقتراب من المنعطفات",
                        icon: "arrow.triangle.turn.up.right.diamond",
                        range: 0...50,
                        step: 5,
                        unit: "%",
                        value: Binding(
                            get: { Double(settings.curveSlowdownPercentage) },
                            set: { settings.curveSlowdownPercentage = Int($0) }
                        )
                    )
                }

                // MARK: المسافة الأمامية
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("المسافة الأمامية", subtitle: "المسافة من السيارة الأمامية")

                    NMKSelectionList(
                        title: "المسافة الافتراضية",
                        subtitle: "البُعد الذي يحافظ عليه النظام",
                        icon: "arrow.down",
                        options: FollowingDistance.allCases,
                        selection: $settings.followingDistance,
                        optionLabel: { $0.displayName },
                        optionDetail: { "\(Int($0.metersAt100kmh)) متر عند 100 كم/س" },
                        optionIcon: { $0.icon }
                    )
                    .padding(.horizontal, 4)

                    NMKToggleCard(
                        "تباطؤ طوارئ",
                        subtitle: "إبطاء تلقائي عند اقتراب السيارة الأمامية فجأة",
                        icon: "exclamationmark.triangle",
                        iconColor: .nmkWarning,
                        isOn: $settings.dynamicSlowDownEnabled
                    )
                }

                // MARK: مراقبة السائق
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("مراقبة السائق", subtitle: "التأكد من انتباهك أثناء القيادة")

                    NMKToggleCard(
                        "كشف الانتباه",
                        subtitle: "تنبيه إذا غبت عن الانتباه",
                        icon: "eye",
                        iconColor: .nmkPrimary,
                        isOn: $settings.driverMonitoringEnabled
                    )

                    if settings.driverMonitoringEnabled {
                        NMKSelectionList(
                            title: "الحساسية",
                            subtitle: "مستوى صرامة كشف الانتباه",
                            icon: "sensor",
                            options: SensitivityLevel.allCases,
                            selection: $settings.driverMonitoringSensitivity,
                            optionLabel: { $0.displayName }
                        )
                        .padding(.horizontal, 4)
                        .transition(.opacity)
                    }
                }

                // MARK: وضع القيادة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("وضع القيادة", subtitle: "اختر أسلوب القيادة المناسب")

                    NMKSelectionList(
                        title: "الوضع",
                        icon: "car",
                        options: DrivingMode.allCases,
                        selection: $settings.drivingMode,
                        optionLabel: { $0.displayName },
                        optionDetail: { $0.description },
                        optionIcon: { $0.icon }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: الوضع التجريبي
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("مزايا متقدمة", subtitle: "وظائف قيد التطوير")

                    NMKToggleCard(
                        "الوضع التجريبي",
                        subtitle: "تفعيل مزايا قيادة متقدمة (قد تكون أقل استقراراً)",
                        icon: "flask",
                        iconColor: .nmkSecondary,
                        isOn: $settings.experimentalModeEnabled
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color.nmkBackground)
        .navigationTitle("إعدادات القيادة")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.25), value: settings.laneCenteringEnabled)
        .animation(.easeInOut(duration: 0.25), value: settings.driverMonitoringEnabled)
    }
}
