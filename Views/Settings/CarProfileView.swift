import SwiftUI

// MARK: - شاشة إعدادات السيارة
/// تشمل: اسم السيارة، العلامة، الموديل، السنة، نوع الوقود، ناقل الحركة، اللوحة

struct CarProfileView: View {
    @Binding var car: CarProfile
    @State private var showingSaveToast = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                // MARK: معاينة السيارة
                carPreviewCard

                // MARK: الاسم
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("الاسم", subtitle: "الاسم الذي يظهر في التطبيق")

                    VStack(alignment: .leading, spacing: 8) {
                        Text("اسم السيارة")
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)

                        TextField("مثال: سوناتا البيت", text: $car.displayName)
                            .font(NMKFont.body())
                            .padding()
                            .background(Color.nmkCard)
                            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))
                            .foregroundStyle(.nmkTextPrimary)
                    }
                    .padding(NMKMetrics.cardPadding)
                    .background(Color.nmkCard)
                    .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
                }

                // MARK: بيانات المركبة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("بيانات المركبة", subtitle: "المعلومات الأساسية")

                    VStack(spacing: 0) {
                        carFieldRow(title: "العلامة التجارية") {
                            TextField("مثال: هيونداي", text: $car.brand)
                                .multilineTextAlignment(.trailing)
                        }
                        Divider().background(Color.nmkBorder).padding(.horizontal)

                        carFieldRow(title: "الموديل") {
                            TextField("مثال: سوناتا", text: $car.model)
                                .multilineTextAlignment(.trailing)
                        }
                        Divider().background(Color.nmkBorder).padding(.horizontal)

                        carFieldRow(title: "سنة الصنع") {
                            Stepper(value: $car.year, in: 1990...2027) {
                                Text("\(String(car.year))")
                                    .foregroundStyle(.nmkTextPrimary)
                            }
                        }
                        Divider().background(Color.nmkBorder).padding(.horizontal)

                        carFieldRow(title: "رقم اللوحة") {
                            TextField("اختياري", text: $car.plateNumber)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .background(Color.nmkCard)
                    .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
                }

                // MARK: نوع الوقود
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("نوع الوقود", subtitle: "لضبط حسابات الاستهلاك والمدى")

                    NMKSelectionList(
                        title: "الوقود",
                        icon: "fuelpump",
                        options: FuelType.allCases,
                        selection: $car.fuelType,
                        optionLabel: { $0.displayName },
                        optionIcon: { $0.icon }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: ناقل الحركة
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("ناقل الحركة", subtitle: "نوع الغيار")

                    NMKSelectionList(
                        title: "النوع",
                        icon: "gear",
                        options: TransmissionType.allCases,
                        selection: $car.transmission,
                        optionLabel: { $0.displayName }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: حالة الدعم
                VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                    NMKSectionHeader("الدعم", subtitle: "مستوى دعم نظام القيادة المساعدة لهذه السيارة")

                    NMKSelectionList(
                        title: "المستوى",
                        icon: "checkmark.shield",
                        options: SupportLevel.allCases,
                        selection: $car.supportLevel,
                        optionLabel: { $0.displayName }
                    )
                    .padding(.horizontal, 4)
                }

                // MARK: زر الحفظ
                NMKButton("حفظ بيانات السيارة", icon: "checkmark.circle.fill") {
                    showingSaveToast = true
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .background(Color.nmkBackground)
        .navigationTitle("إعدادات السيارة")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .top) {
            if showingSaveToast {
                NMKToastView(message: "تم حفظ بيانات السيارة ✓", color: .nmkSuccess)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { showingSaveToast = false }
                        }
                    }
            }
        }
    }

    // MARK: - معاينة السيارة

    private var carPreviewCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "car.fill")
                .font(.system(size: 48))
                .foregroundStyle(.nmkPrimary)
                .frame(width: 80, height: 80)
                .background(Color.nmkPrimary.opacity(0.12))
                .clipShape(Circle())

            Text(car.displayName.isEmpty ? "بدون اسم" : car.displayName)
                .font(NMKFont.title())
                .foregroundStyle(.nmkTextPrimary)

            if !car.brand.isEmpty || !car.model.isEmpty {
                Text([car.brand, car.model].filter { !$0.isEmpty }.joined(separator: " • "))
                    .font(NMKFont.subheadline())
                    .foregroundStyle(.nmkTextSecondary)
            }

            HStack(spacing: 8) {
                NMKStatusBadge(text: car.fuelType.displayName, color: .nmkPrimary)
                NMKStatusBadge(text: car.supportLevel.displayName, color: car.supportLevelColor)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(NMKMetrics.cardPadding + 8)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    // MARK: - صف حقل

    private func carFieldRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
                .font(NMKFont.body())
                .foregroundStyle(.nmkTextSecondary)

            Spacer()

            content()
                .font(NMKFont.body())
                .foregroundStyle(.nmkTextPrimary)
        }
        .padding(NMKMetrics.cardPadding)
    }
}

private extension CarProfile {
    var supportLevelColor: Color {
        switch supportLevel {
        case .full:    return .nmkSuccess
        case .partial: return .nmkWarning
        case .limited: return .nmkDanger
        }
    }
}

// MARK: - Toast صغير

struct NMKToastView: View {
    let message: String
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
            Text(message)
        }
        .font(NMKFont.subheadline())
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(color)
        .clipShape(Capsule())
        .shadow(color: color.opacity(0.4), radius: 8, y: 4)
        .padding(.top, 8)
    }
}
