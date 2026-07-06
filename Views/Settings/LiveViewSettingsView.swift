import SwiftUI

// MARK: - شاشة إعدادات العرض المباشر
/// تشمل: بث الكاميرا، جودة، إطارات، تأخير، معلومات فوق الفيديو، التسجيل

struct LiveViewSettingsView: View {
    @Binding var settings: LiveViewSettings

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                // MARK: البث
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("البث المباشر", subtitle: "إعدادات بث كاميرا الجهاز")

                    NMKToggleCard(
                        "العرض المباشر",
                        subtitle: "تفعيل بث كاميرا الجهاز للهاتف",
                        icon: "video",
                        iconColor: .nmkPrimary,
                        isOn: $settings.liveViewEnabled
                    )

                    NMKSelectionList(
                        title: "جودة البث",
                        subtitle: "كلما زادت الجودة = استهلاك بيانات أكبر",
                        icon: "wand.and.stars",
                        options: StreamQuality.allCases,
                        selection: $settings.streamQuality,
                        optionLabel: { $0.displayName },
                        optionDetail: { $0.resolution }
                    )
                    .padding(.horizontal, 4)

                    NMKSelectionList(
                        title: "معدّل الإطارات",
                        subtitle: "عدد الإطارات في الثانية",
                        icon: "speedometer",
                        options: FrameRate.allCases,
                        selection: $settings.frameRate,
                        optionLabel: { $0.displayName }
                    )
                    .padding(.horizontal, 4)

                    NMKSelectionList(
                        title: "زمن الاستجابة",
                        subtitle: "كلما قلّ = تأخير أقل بين الجهاز وهاتفك",
                        icon: "clock",
                        options: LatencyMode.allCases,
                        selection: $settings.latencyMode,
                        optionLabel: { $0.displayName },
                        optionDetail: { "\($0.targetLatencyMs) مللي ثانية" }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: المعلومات المعروضة (Overlay)
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("المعلومات فوق الفيديو", subtitle: "ما يظهر فوق البث المباشر")

                    NMKToggleCard(
                        "عرض المعلومات",
                        subtitle: "إظهار بيانات القيادة فوق الفيديو",
                        icon: "rectangle.stack.badge.plus",
                        iconColor: .nmkPrimary,
                        isOn: $settings.showDrivingOverlay
                    )

                    if settings.showDrivingOverlay {
                        VStack(spacing: NMKMetrics.itemSpacing) {
                            NMKToggleCard(
                                "السرعة الحالية",
                                icon: "speedometer",
                                isOn: $settings.showCurrentSpeed
                            )
                            NMKToggleCard(
                                "حد السرعة",
                                icon: "speedometer",
                                isOn: $settings.showSpeedLimit
                            )
                            NMKToggleCard(
                                "حالة المسار",
                                subtitle: "هل السيارة في منتصف المسار؟",
                                icon: "arrow.up.and.down",
                                isOn: $settings.showLaneStatus
                            )
                            NMKToggleCard(
                                "المسافة الأمامية",
                                icon: "arrow.down",
                                isOn: $settings.showFollowingDistance
                            )
                        }
                        .padding(.leading, 16)
                        .transition(.opacity)
                    }
                }

                // MARK: التسجيل
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("التسجيل", subtitle: "تسجيل رحلاتك تلقائياً")

                    NMKToggleCard(
                        "تسجيل تلقائي",
                        subtitle: "تسجيل كل رحلة تبدأ بها",
                        icon: "record.circle",
                        iconColor: .nmkDanger,
                        isOn: $settings.autoRecordDrives
                    )

                    if settings.autoRecordDrives {
                        NMKSelectionList(
                            title: "جودة التسجيل",
                            icon: "video.badge.checkmark",
                            options: RecordQuality.allCases,
                            selection: $settings.recordQuality,
                            optionLabel: { $0.displayName }
                        )
                        .padding(.horizontal, 4)
                        .transition(.opacity)

                        NMKSliderCard(
                            title: "مدة الاحتفاظ",
                            subtitle: "عدد الأيام قبل حذف التسجيلات تلقائياً",
                            icon: "calendar",
                            range: 1...90,
                            step: 1,
                            unit: "يوم",
                            value: Binding(
                                get: { Double(settings.retentionDays) },
                                set: { settings.retentionDays = Int($0) }
                            )
                        )
                        .transition(.opacity)

                        NMKToggleCard(
                            "تسجيل بالصوت",
                            subtitle: "تسجيل الصوت داخل المقصورة",
                            icon: "mic",
                            iconColor: .nmkSecondary,
                            isOn: $settings.recordAudio
                        )
                        .transition(.opacity)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color.nmkBackground)
        .navigationTitle("العرض المباشر")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.25), value: settings.showDrivingOverlay)
        .animation(.easeInOut(duration: 0.25), value: settings.autoRecordDrives)
    }
}
