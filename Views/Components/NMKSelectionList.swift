import SwiftUI

// MARK: - قائمة اختيار تفاعلية (Segmented + Cards)
/// تتيح للمستخدم اختيار قيمة من قائمة خيارات بطريقة بصرياً واضحة

struct NMKSelectionList<Option: Identifiable & Hashable>: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let options: [Option]
    let optionLabel: (Option) -> String
    let optionDetail: ((Option) -> String)?
    let optionIcon: ((Option) -> String)?
    @Binding var selection: Option

    init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        options: [Option],
        selection: Binding<Option>,
        optionLabel: @escaping (Option) -> String,
        optionDetail: ((Option) -> String)? = nil,
        optionIcon: ((Option) -> String)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.options = options
        self.optionLabel = optionLabel
        self.optionDetail = optionDetail
        self.optionIcon = optionIcon
        self._selection = selection
    }

    var body: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            // العنوان
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(.nmkPrimary)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(NMKFont.headline())
                        .foregroundStyle(.nmkTextPrimary)
                    if let subtitle {
                        Text(subtitle)
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)
                    }
                }
            }
            .padding(.horizontal, 4)

            // الخيارات
            VStack(spacing: 8) {
                ForEach(options) { option in
                    NMKOptionRow(
                        label: optionLabel(option),
                        detail: optionDetail?(option),
                        icon: optionIcon?(option),
                        isSelected: selection == option
                    ) {
                        selection = option
                    }
                }
            }
        }
    }
}

private struct NMKOptionRow: View {
    let label: String
    let detail: String?
    let icon: String?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(isSelected ? .nmkPrimary : .nmkTextSecondary)
                        .frame(width: 28)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .font(NMKFont.body())
                        .foregroundStyle(.nmkTextPrimary)
                    if let detail {
                        Text(detail)
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)
                            .lineLimit(2)
                    }
                }

                Spacer()

                // مؤشر الاختيار
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(isSelected ? .nmkSuccess : .nmkTextTertiary)
            }
            .padding(NMKMetrics.cardPadding)
            .background(isSelected ? Color.nmkPrimary.opacity(0.08) : Color.nmkCard)
            .overlay(
                RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius)
                    .stroke(isSelected ? Color.nmkPrimary.opacity(0.4) : .clear, lineWidth: 1.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - بطاقة Slider
/// شريط تمرير لاختيار قيمة رقمية

struct NMKSliderCard: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let range: ClosedRange<Double>
    let step: Double
    let unit: String
    let displayValue: ((Double) -> String)?
    @Binding var value: Double

    init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        range: ClosedRange<Double>,
        step: Double = 1,
        unit: String = "",
        displayValue: ((Double) -> String)? = nil,
        value: Binding<Double>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.range = range
        self.step = step
        self.unit = unit
        self.displayValue = displayValue
        self._value = value
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundStyle(.nmkPrimary)
                        .frame(width: 24)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(NMKFont.headline())
                        .foregroundStyle(.nmkTextPrimary)
                    if let subtitle {
                        Text(subtitle)
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)
                    }
                }

                Spacer()

                Text(displayValue?(value) ?? "\(Int(value)) \(unit)")
                    .font(NMKFont.headline())
                    .foregroundStyle(.nmkPrimary)
                    .monospacedDigit()
            }

            Slider(value: $value, in: range, step: step) {
                Text(title)
            } minimumValueLabel: {
                Text("\(Int(range.lowerBound))")
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextTertiary)
            } maximumValueLabel: {
                Text("\(Int(range.upperBound))")
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextTertiary)
            }
            .tint(.nmkPrimary)
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }
}

// MARK: - شارة الحالة

struct NMKStatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 6, height: 6)

            Text(text)
                .font(NMKFont.caption())
                .foregroundStyle(.nmkTextSecondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.12))
        .clipShape(Capsule())
    }
}
