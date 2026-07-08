//
//  SupportedVehiclesView.swift
//  NMKAi — القائد الآلي
//
//  واجهة المركبات المدعومة بالتحكم الصوتي
//  Shows all 7 vehicle platforms + 23 voice commands
//
//  Author: NMK-Ai (نويكل 🧬)
//

import SwiftUI

struct SupportedVehiclesView: View {
    @State private var selectedPlatform: VehiclePlatform?
    @State private var showCommandsForPlatform = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header stats
                headerStats

                // Platforms grid
                platformsSection

                // Voice commands reference
                voiceCommandsSection
            }
            .padding()
        }
        .background(NMKTheme.background)
        .navigationTitle("المركبات المدعومة")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Header Stats

    private var headerStats: some View {
        HStack {
            statCard(title: "ماركة", value: "\(VehiclePlatformStore.totalBrands)+", icon: "car.2.fill", color: .blue)
            statCard(title: "مركبة", value: "\(VehiclePlatformStore.totalSupportedVehicles)+", icon: "car.fill", color: .green)
            statCard(title: "منصة", value: "7", icon: "cpu.fill", color: .purple)
        }
    }

    private func statCard(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(value)
                .font(.title.bold())
                .foregroundStyle(NMKTheme.textPrimary)
            Text(title)
                .font(NMKTheme.caption)
                .foregroundStyle(NMKTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(NMKTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Platforms

    private var platformsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("المنصات المدعومة")
                .font(NMKTheme.title2)
                .foregroundStyle(NMKTheme.textPrimary)

            ForEach(VehiclePlatformStore.supported) { platform in
                platformCard(platform)
            }
        }
    }

    private func platformCard(_ platform: VehiclePlatform) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: platform.icon)
                    .font(.title2)
                    .foregroundStyle(NMKTheme.primary)
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 4) {
                    Text(platform.name)
                        .font(NMKTheme.bodyBold)
                        .foregroundStyle(NMKTheme.textPrimary)

                    HStack(spacing: 8) {
                        Label(platform.canType, systemImage: "antenna.radiowaves.left.and.right")
                            .font(NMKTheme.caption)
                            .foregroundStyle(.secondary)

                        Text("⋅")
                            .foregroundStyle(.secondary)

                        Text("\(platform.signalCount) إشارة CAN")
                            .font(NMKTheme.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                // Support badge
                Text(platform.isFullySupported ? "كامل" : "جزئي")
                    .font(NMKTheme.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(platform.isFullySupported ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
                    .foregroundStyle(platform.isFullySupported ? .green : .orange)
                    .clipShape(Capsule())
            }

            // Brand examples
            if !platform.brandExamples.isEmpty {
                FlowLayout(spacing: 6) {
                    ForEach(platform.brandExamples, id: \.self) { brand in
                        Text(brand)
                            .font(NMKTheme.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(NMKTheme.primary.opacity(0.08))
                            .foregroundStyle(NMKTheme.primary)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding(16)
        .background(NMKTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Voice Commands Reference

    private var voiceCommandsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("الأوامر الصوتية")
                    .font(NMKTheme.title2)
                    .foregroundStyle(NMKTheme.textPrimary)
                Spacer()
                Text("\(VoiceCommandInfo.allCommands.count) أمر")
                    .font(NMKTheme.caption)
                    .foregroundStyle(NMKTheme.textSecondary)
            }

            // Group by category
            let categories = Dictionary(grouping: VoiceCommandInfo.allCommands) { $0.categoryAr }

            ForEach(categories.keys.sorted(), id: \.self) { category in
                VStack(alignment: .leading, spacing: 8) {
                    Text(category)
                        .font(NMKTheme.bodyBold)
                        .foregroundStyle(NMKTheme.primary)

                    ForEach(categories[category] ?? []) { cmd in
                        commandRow(cmd)
                    }
                }
            }
        }
    }

    private func commandRow(_ cmd: VoiceCommandInfo) -> some View {
        HStack(spacing: 12) {
            Image(systemName: cmd.icon)
                .font(.body)
                .foregroundStyle(NMKTheme.primary)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(cmd.arExample)
                    .font(NMKTheme.body)
                    .foregroundStyle(NMKTheme.textPrimary)
                Text(cmd.enExample)
                    .font(NMKTheme.caption)
                    .foregroundStyle(NMKTheme.textSecondary)
            }

            Spacer()

            // Risk badge
            Text(cmd.riskLevel)
                .font(NMKTheme.caption)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(riskColor(cmd.riskLevel).opacity(0.12))
                .foregroundStyle(riskColor(cmd.riskLevel))
                .clipShape(Capsule())
        }
        .padding(.vertical, 4)
    }

    private func riskColor(_ risk: String) -> Color {
        switch risk {
        case "عام":     return .blue
        case "منخفض":   return .green
        case "متوسط":   return .orange
        case "عالي":    return .red
        default:        return .gray
        }
    }
}

// MARK: - Flow Layout (simple)

struct FlowLayout: Layout {
    var spacing: CGFloat = 6

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var height: CGFloat = 0
        var x: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth {
                height += rowHeight + spacing
                x = 0
                rowHeight = 0
            }
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        height += rowHeight
        return CGSize(width: maxWidth, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxWidth = bounds.width
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.minX + maxWidth {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SupportedVehiclesView()
    }
}
