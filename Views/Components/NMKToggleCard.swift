import SwiftUI

// MARK: - بطاقة Toggle رئيسية
/// بطاقة بإطار، عنوان، أيقونة، وصف، ومفتاح تفعيل/تعطيل

struct NMKToggleCard: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let iconColor: Color?
    @Binding var isOn: Bool

    init(
        _ title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        iconColor: Color? = nil,
        isOn: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
        self._isOn = isOn
    }

    var body: some View {
        HStack(spacing: NMKMetrics.itemSpacing) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(iconColor ?? .nmkPrimary)
                    .frame(width: 36, height: 36)
                    .background((iconColor ?? .nmkPrimary).opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(NMKFont.headline())
                    .foregroundStyle(.nmkTextPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(NMKFont.caption())
                        .foregroundStyle(.nmkTextSecondary)
                        .lineLimit(2)
                }
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.nmkSuccess)
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
        .contentShape(Rectangle())
    }
}

// MARK: - بطاقة تقود إلى شاشة أخرى (NavigationLink card)

struct NMKNavigationCard<Destination: View>: View {
    let title: String
    let subtitle: String?
    let icon: String
    let iconColor: Color
    let badge: String?
    @ViewBuilder let destination: () -> Destination

    init(
        _ title: String,
        subtitle: String? = nil,
        icon: String,
        iconColor: Color = .nmkPrimary,
        badge: String? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
        self.badge = badge
        self.destination = destination
    }

    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: NMKMetrics.itemSpacing) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(iconColor)
                    .frame(width: 36, height: 36)
                    .background(iconColor.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(NMKFont.headline())
                        .foregroundStyle(.nmkTextPrimary)

                    if let subtitle {
                        Text(subtitle)
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                if let badge {
                    Text(badge)
                        .font(NMKFont.caption())
                        .foregroundStyle(.nmkTextSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.nmkCardHighlighted)
                        .clipShape(Capsule())
                }

                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.nmkTextTertiary)
            }
            .padding(NMKMetrics.cardPadding)
            .background(Color.nmkCard)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - عنوان قسم

struct NMKSectionHeader: View {
    let title: String
    let subtitle: String?

    init(_ title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(NMKFont.headline())
                .foregroundStyle(.nmkTextPrimary)

            if let subtitle {
                Text(subtitle)
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextTertiary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 4)
        .padding(.bottom, 4)
    }
}

// MARK: - زر مخصص

struct NMKButton: View {
    let title: String
    let icon: String?
    let style: NMKButtonStyle
    let action: () -> Void

    enum NMKButtonStyle {
        case primary, secondary, danger
    }

    init(_ title: String, icon: String? = nil, style: NMKButtonStyle = .primary, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.style = style
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
            }
            .font(NMKFont.headline())
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
        }
        .buttonStyle(.plain)
    }

    private var foregroundColor: Color {
        switch style {
        case .primary, .danger: return .white
        case .secondary: return .nmkTextPrimary
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return .nmkPrimary
        case .secondary: return .nmkCardHighlighted
        case .danger: return .nmkDanger
        }
    }
}
