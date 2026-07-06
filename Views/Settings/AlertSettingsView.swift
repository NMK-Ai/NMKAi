import SwiftUI

// MARK: - شاشة إعدادات التنبيهات
/// تشمل: التنبيهات الصوتية، المسار، السرعة، المسافة، السائق، إضافية

struct AlertSettingsView: View {
    @Binding var settings: AlertSettings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                // MARK: التنبيهات الصوتية
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("التنبيهات الصوتية", subtitle: "كيف تسمع التنبيهات")

                    NMKToggleCard(
                        "التنبيهات الصوتية",
                        subtitle: "تفعيل أو كتم كل التنبيهات الصوتية",
                        icon: "speaker.wave.2",
                        iconColor: .nmkPrimary,
                        isOn: $settings.soundAlertsEnabled
                    )

                    if settings.soundAlertsEnabled {
                        NMKSelectionList(
                            title: "نوع الصوت",
                            subtitle: settings.alertSoundType.description,
                            icon: settings.alertSoundType.icon,
                            options: AlertSoundType.allCases,
                            selection: $settings.alertSoundType,
                            optionLabel: { $0.displayName },
                            optionDetail: { $0.description },
                            optionIcon: { $0.icon }
                        )
                        .padding(.horizontal, 4)

                        NMKSliderCard(
                            title: "مستوى الصوت",
                            subtitle: "شدة صوت التنبيهات",
                            icon: "speaker.wave.1",
                            range: 0.1...1.0,
                            step: 0.1,
                            displayValue: { "\(Int($0 * 100))%" },
                            value: $settings.alertVolume
                        )
                        .transition(.opacity)
                    }
                }

                // MARK: تنبيهات المسار
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تنبيهات المسار", subtitle: "البقاء في المسار الصحيح")

                    NMKToggleCard(
                        "الخروج عن المسار",
                        subtitle: "تنبيه عند مغادرة المسار بدون إشارة",
                        icon: "arrow.left",
                        iconColor: .nmkWarning,
                        isOn: $settings.laneDepartureAlert
                    )

                    NMKToggleCard(
                        "حافة المسار",
                        subtitle: "تنبيه عند الاقتراب من حافة المسار",
                        icon: "arrow.left.and.right",
                        iconColor: .nmkWarning,
                        isOn: $settings.laneEdgeWarning
                    )
                }

                // MARK: تنبيهات السرعة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تنبيهات السرعة", subtitle: "الالتزام بحدود السرعة")

                    NMKToggleCard(
                        "تجاوز السرعة",
                        subtitle: "تنبيه عند تجاوز حد السرعة",
                        icon: "speedometer",
                        iconColor: .nmkWarning,
                        isOn: $settings.speedingAlert
                    )

                    if settings.speedingAlert {
                        NMKSliderCard(
                            title: "تفاوت السرعة المسموح",
                            subtitle: "النسبة المسموح تجاوزها فوق الحد",
                            icon: "plus.circle",
                            range: 0...20,
                            step: 1,
                            unit: "كم/س",
                            value: Binding(
                                get: { Double(settings.speedTolerance) },
                                set: { settings.speedTolerance = Int($0) }
                            )
                        )
                        .transition(.opacity)
                    }

                    NMKToggleCard(
                        "كاميرات السرعة",
                        subtitle: "تنبيه عند الاقتراب من كاميرا مراقبة السرعة",
                        icon: "camera.viewfinder",
                        iconColor: .nmkPrimary,
                        isOn: $settings.speedCameraAlert
                    )
                }

                // MARK: تنبيهات المسافة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تنبيهات المسافة", subtitle: "الحفاظ على مسافة آمنة")

                    NMKToggleCard(
                        "تحذير التصادم",
                        subtitle: "تنبيه عند الاقتراب الشديد من السيارة الأمامية",
                        icon: "exclamationmark.triangle.fill",
                        iconColor: .nmkDanger,
                        isOn: $settings.forwardCollisionAlert
                    )

                    if settings.forwardCollisionAlert {
                        NMKSelectionList(
                            title: "حساسية التصادم",
                            subtitle: "متى يجب التنبيه",
                            icon: "sensor",
                            options: SensitivityLevel.allCases,
                            selection: $settings.collisionAlertSensitivity,
                            optionLabel: { $0.displayName }
                        )
                        .padding(.horizontal, 4)
                        .transition(.opacity)
                    }
                }

                // MARK: تنبيهات السائق
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تنبيهات السائق", subtitle: "سلامة السائق وانتباهه")

                    NMKToggleCard(
                        "تنبيه النعاس",
                        subtitle: "كشف علامات النعاس وتنبيهك",
                        icon: "bed.double",
                        iconColor: .nmkSecondary,
                        isOn: $settings.drowsinessAlert
                    )

                    NMKToggleCard(
                        "تشتت الانتباه",
                        subtitle: "تنبيه عند استخدام الهاتف أو التشتت",
                        icon: "iphone.slash",
                        iconColor: .nmkWarning,
                        isOn: $settings.distractionAlert
                    )

                    NMKToggleCard(
                        "تذكير المقود",
                        subtitle: "تذكير دوري للمس المقود",
                        icon: "hand.raised",
                        iconColor: .nmkPrimary,
                        isOn: $settings.steeringReminder
                    )
                }

                // MARK: تنبيهات إضافية
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("تنبيهات إضافية", subtitle: "وظائف مساندة")

                    NMKToggleCard(
                        "الاقتراب من الوجهة",
                        subtitle: "تنبيه عند الاقتراب من نقطة الوصول",
                        icon: "mappin.and.ellipse",
                        iconColor: .nmkPrimary,
                        isOn: $settings.destinationApproachAlert
                    )

                    NMKToggleCard(
                        "وقود/بطارية منخفضة",
                        subtitle: "تنبيه عند انخفاض الوقود أو شحن البطارية",
                        icon: "battery.25",
                        iconColor: .nmkWarning,
                        isOn: $settings.lowFuelAlert
                    )

                    NMKToggleCard(
                        "اهتزاز الهاتف",
                        subtitle: "اهتزاز الهاتف مع التنبيهات الصوتية",
                        icon: "iphone.radiowaves.left.and.right",
                        iconColor: .nmkSecondary,
                        isOn: $settings.hapticFeedback
                    )
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color.nmkBackground)
        .navigationTitle("التنبيهات")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.25), value: settings.soundAlertsEnabled)
        .animation(.easeInOut(duration: 0.25), value: settings.speedingAlert)
        .animation(.easeInOut(duration: 0.25), value: settings.forwardCollisionAlert)
    }
}
