import SwiftUI
import UIKit
import WebKit

// MARK: - شاشة التحكم بالقائد الآلي (مُعاد بناؤها بنظام NMK Ai)
/// تجمع: البحث عن الجهاز + الاتصال + لوحة التحكم + إعدادات القائد الآلي الحقيقية
/// + روابط لشاشات الإعدادات الخمس (القيادة/السيارة/الخريطة/العرض المباشر/التنبيهات)

struct ControlView: View {
    @State private var connection = DeviceConnectionService()
    // ✅ استقبال SettingsStore من البيئة (نسخة موحّدة من MainTabView)
    @Environment(SettingsStore.self) private var settingsStore
    @State private var searchMode: SearchMode = .auto
    @State private var showInstructions = false
    @State private var selectedCategory: OpenpilotCategory = .main
    @State private var toggles: [OpenpilotToggle] = OpenpilotToggle.defaultToggles
    @State private var alertItem: AlertItem?
    @State private var confirmation: ConfirmationItem?
    /// ✅ وضع المعاينة الشاملة: يعرض كل الأقسام مفتوحة دفعة واحدة (للتجربة)
    @State private var showAllSections: Bool = false
    /// ✅ مسار التنقّل (يدعم فتح شاشة معيّنة عبر argument)
    @State private var navPath: [String] = []

    enum SearchMode { case auto, manual }

    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                    // ✅ بطاقة الوضع التجريبي (في الأعلى)
                    demoModeCard

                    // حالة الاتصال
                    connectionStatusCard

                    // إرشادات (قابلة للطي)
                    instructionsCard

                    // اختيار طريقة البحث
                    searchModeSelector

                    // البحث + قائمة الأجهزة أو الإدخال اليدوي
                    if searchMode == .auto {
                        autoSearchSection
                    } else {
                        manualSearchSection
                    }

                    // زر الاتصال
                    NMKButton(
                        connection.isConnected ? "قطع الاتصال" : "الاتصال بالجهاز",
                        icon: connection.isConnected ? "wifi.slash" : "wifi",
                        style: connection.isConnected ? .danger : .primary
                    ) {
                        handleConnectButton()
                    }
                    .disabled(searchMode == .manual && connection.deviceIP.isEmpty)

                    // ===== لوحة التحكم بعد الاتصال =====
                    if connection.isConnected {
                        connectedSection
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(Color.nmkBackground)
            .navigationTitle("التحكم بالقائد الآلي")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink { PrivacyPolicyView() } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.nmkTextSecondary)
                    }
                }
                // ✅ شارة الوضع التجريبي في الشريط العلوي
                if connection.isDemoMode {
                    ToolbarItem(placement: .topBarLeading) {
                        demoBadge
                    }
                }
                if connection.isConnected {
                    ToolbarItem(placement: .topBarLeading) {
                        Button { connection.fetchDeviceInfo() } label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundStyle(.nmkPrimary)
                        }
                    }
                }
            }
            .alert(item: $alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("حسناً")))
            }
            .alert(item: $confirmation) { item in
                Alert(
                    title: Text("تأكيد"),
                    message: Text(item.message),
                    primaryButton: .destructive(Text("تأكيد")) { item.action() },
                    secondaryButton: .cancel(Text("إلغاء"))
                )
            }
            .onAppear { checkDemoArgument() }
            // ✅ مسار التنقّل: فتح شاشة معيّنة عبر --screen
            .navigationDestination(for: String.self) { destination in
                // @Bindable محلي يتيح bindings من SettingsStore البيئي
                @Bindable var store = settingsStore
                switch destination {
                case "driving":
                    DrivingSettingsView(settings: $store.settings.driving)
                case "car":
                    CarProfileView(car: $store.settings.car)
                case "map":
                    MapSettingsView(settings: $store.settings.map)
                case "live":
                    LiveViewSettingsView(settings: $store.settings.liveView)
                case "alerts":
                    AlertSettingsView(settings: $store.settings.alerts)
                default:
                    EmptyView()
                }
            }
            // ✅ وضع المعاينة الشاملة: اعرض الـ toggles لكل الفئات دفعة واحدة
        }
    }

    // MARK: - بطاقة الوضع التجريبي (Demo Mode)

    private var demoModeCard: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                connection.toggleDemoMode()
            }
        } label: {
            HStack(spacing: NMKMetrics.itemSpacing) {
                Image(systemName: connection.isDemoMode ? "sparkles" : "wand.and.stars")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(connection.isDemoMode ? Color.nmkSecondary : Color.nmkSecondary.opacity(0.6))
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 3) {
                    Text(connection.isDemoMode ? "الوضع التجريبي مُفعّل" : "تفعيل الوضع التجريبي")
                        .font(NMKFont.headline())
                        .foregroundStyle(.white)
                    Text(connection.isDemoMode ? "جهاز وهمي متصل — جرّب كل الخيارات" : "جرّب كل خيارات التحكم بجهاز وهمي")
                        .font(NMKFont.caption())
                        .foregroundStyle(.white.opacity(0.85))
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: connection.isDemoMode ? "checkmark.circle.fill" : "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .padding(NMKMetrics.cardPadding)
            .background(
                LinearGradient(
                    colors: connection.isDemoMode
                        ? [Color.nmkSecondary, Color.nmkPrimary]
                        : [Color.nmkSecondary.opacity(0.7), Color.nmkPrimary.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - شارة الوضع التجريبي (تظهر في الـ Toolbar)

    private var demoBadge: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(Color.nmkSuccess)
                .frame(width: 6, height: 6)
            Text("تجريبي")
                .font(NMKFont.caption())
                .foregroundStyle(.nmkSuccess)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.nmkSuccess.opacity(0.15))
        .clipShape(Capsule())
    }

    // MARK: - حالة الاتصال

    private var connectionStatusCard: some View {
        HStack(spacing: NMKMetrics.itemSpacing) {
            Image(systemName: connection.isConnected ? "checkmark.seal.fill" : "xmark.octagon.fill")
                .font(.system(size: 38))
                .foregroundStyle(connection.isConnected ? .nmkSuccess : .nmkDanger)

            VStack(alignment: .leading, spacing: 4) {
                Text("حالة الاتصال")
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextSecondary)
                Text(connection.searchProgress)
                    .font(NMKFont.headline())
                    .foregroundStyle(connection.isConnected ? .nmkSuccess : .nmkTextPrimary)
            }
            Spacer()
        }
        .padding(NMKMetrics.cardPadding)
        .background((connection.isConnected ? Color.nmkSuccess : Color.nmkDanger).opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    // MARK: - الإرشادات

    private var instructionsCard: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            Button { withAnimation { showInstructions.toggle() } } label: {
                HStack {
                    Image(systemName: "lightbulb.fill")
                        .foregroundStyle(.nmkWarning)
                    Text("إرشادات الاتصال")
                        .font(NMKFont.headline())
                        .foregroundStyle(.nmkPrimary)
                    Spacer()
                    Image(systemName: showInstructions ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.nmkTextSecondary)
                }
            }
            .buttonStyle(.plain)

            if showInstructions {
                VStack(alignment: .leading, spacing: 8) {
                    instructionStep("1", "تأكد من توصيل الجوال وجهاز القائد الآلي على نفس الشبكة")
                    instructionStep("2", "يفضل استخدام شبكة Wi-Fi بتردد 2.4 جيجاهرتز")
                    instructionStep("3", "اختر البحث التلقائي أو أدخل عنوان IP يدوياً")
                    instructionStep("4", "اضغط على زر «الاتصال بالجهاز»")
                }
                .transition(.opacity)
            }
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkWarning.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    private func instructionStep(_ n: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Text(n)
                .font(NMKFont.caption())
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
                .background(Color.nmkPrimary)
                .clipShape(Circle())
            Text(text).font(NMKFont.subheadline()).foregroundStyle(.nmkTextPrimary)
        }
    }

    // MARK: - محدد طريقة البحث

    private var searchModeSelector: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("طريقة البحث")
            HStack(spacing: NMKMetrics.itemSpacing) {
                searchModeButton(.auto, title: "تلقائي", icon: "magnifyingglass")
                searchModeButton(.manual, title: "يدوي", icon: "keyboard")
            }
        }
    }

    private func searchModeButton(_ mode: SearchMode, title: String, icon: String) -> some View {
        Button {
            withAnimation { searchMode = mode }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 22))
                Text(title).font(NMKFont.subheadline())
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(searchMode == mode ? Color.nmkPrimary : Color.nmkCard)
            .foregroundStyle(searchMode == mode ? .white : .nmkTextPrimary)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))
        }
        .buttonStyle(.plain)
    }

    // MARK: - البحث التلقائي

    private var autoSearchSection: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            HStack {
                NMKSectionHeader("البحث التلقائي")
                Spacer()
                Button {
                    if !connection.isSearching { connection.startAutoScan() }
                } label: {
                    HStack(spacing: 4) {
                        if connection.isSearching {
                            ProgressView().tint(.nmkPrimary)
                        } else {
                            Image(systemName: "arrow.clockwise")
                        }
                        Text(connection.isSearching ? "جاري..." : "بدء البحث")
                    }
                    .font(NMKFont.subheadline())
                    .foregroundStyle(.nmkPrimary)
                }
                .disabled(connection.isSearching)
            }

            if connection.isSearching && !connection.searchProgress.isEmpty {
                Text(connection.searchProgress)
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextSecondary)
            }

            if connection.discoveredDevices.isEmpty && !connection.isSearching {
                VStack(spacing: 10) {
                    Image(systemName: "antenna.radiowaves.left.and.right.slash")
                        .font(.system(size: 36))
                        .foregroundStyle(.nmkTextTertiary)
                    Text("لم يتم العثور على أجهزة").font(NMKFont.subheadline()).foregroundStyle(.nmkTextSecondary)
                    Text("اضغط «بدء البحث» للبحث عن الأجهزة المتاحة")
                        .font(NMKFont.caption()).foregroundStyle(.nmkTextTertiary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity).padding(.vertical, 24)
            } else {
                ForEach(connection.discoveredDevices) { device in
                    discoveredDeviceCard(device)
                }
            }
        }
    }

    private func discoveredDeviceCard(_ device: DiscoveredDevice) -> some View {
        Button {
            connection.deviceIP = device.ip
        } label: {
            HStack(spacing: NMKMetrics.itemSpacing) {
                Image(systemName: "car.circle.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.nmkPrimary)
                VStack(alignment: .leading, spacing: 2) {
                    Text(device.name).font(NMKFont.headline()).foregroundStyle(.nmkTextPrimary)
                    Text(device.ip).font(NMKFont.caption()).foregroundStyle(.nmkTextSecondary)
                }
                Spacer()
                Image(systemName: connection.deviceIP == device.ip ? "checkmark.circle.fill" : "chevron.left")
                    .foregroundStyle(connection.deviceIP == device.ip ? .nmkSuccess : .nmkTextTertiary)
            }
            .padding(NMKMetrics.cardPadding)
            .background(Color.nmkCard)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius)
                    .stroke(connection.deviceIP == device.ip ? Color.nmkSuccess.opacity(0.5) : .clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - البحث اليدوي

    private var manualSearchSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("عنوان IP للقائد الآلي").font(NMKFont.headline()).foregroundStyle(.nmkTextPrimary)
            TextField("192.168.1.100", text: $connection.deviceIP)
                .font(NMKFont.body())
                .keyboardType(.numbersAndPunctuation)
                .autocorrectionDisabled()
                .multilineTextAlignment(.leading)
                .environment(\.layoutDirection, .leftToRight)
                .padding()
                .background(Color.nmkCard)
                .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))
                .foregroundStyle(.nmkTextPrimary)
            Text("مثال: 192.168.1.100")
                .font(NMKFont.caption())
                .foregroundStyle(.nmkTextSecondary)
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    // MARK: - لوحة التحكم (بعد الاتصال)

    private var connectedSection: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
            // لوحة سريعة
            VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
                NMKSectionHeader("لوحة التحكم", subtitle: connection.baseURL)

                NMKNavigationCard(
                    "فتح واجهة التحكم الكاملة",
                    subtitle: "فتح واجهة الويب في المتصفح",
                    icon: "globe",
                    iconColor: .nmkSuccess,
                    badge: nil
                ) {
                    WebViewScreen(url: connection.webInterfaceURL(), title: "واجهة التحكم")
                }
            }

            // معلومات الجهاز
            deviceInfoCard

            // أوامر الجهاز
            deviceActionsSection

            // ===== شاشات الإعدادات الخمس (من NMK Ai) =====
            settingsHubSection

            // ===== إعدادات القائد الآلي الحقيقية (toggles) =====
            openpilotTogglesSection
        }
    }

    // MARK: - معلومات الجهاز

    private var deviceInfoCard: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("معلومات الجهاز")
            VStack(spacing: 0) {
                deviceInfoRow(icon: "number", title: "معرّف الجهاز", value: connection.deviceInfo.dongleId)
                divider
                deviceInfoRow(icon: "barcode", title: "الرقم التسلسلي", value: connection.deviceInfo.serialNumber)
                divider
                deviceInfoRow(icon: "gearshape", title: "إصدار البرنامج", value: connection.deviceInfo.softwareVersion)
                divider
                deviceInfoRow(icon: "cpu", title: "نوع الجهاز", value: connection.deviceInfo.hardwareType)
            }
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    private var divider: some View {
        Divider().background(Color.nmkBorder).padding(.horizontal, 4)
    }

    private func deviceInfoRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon).foregroundStyle(.nmkTextSecondary).frame(width: 22)
            Text(title).font(NMKFont.caption()).foregroundStyle(.nmkTextSecondary)
            Spacer()
            Text(value).font(NMKFont.caption()).foregroundStyle(.nmkTextPrimary).lineLimit(1)
        }
        .padding(.vertical, 8)
    }

    // MARK: - أوامر الجهاز

    private var deviceActionsSection: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("أوامر الجهاز")

            actionRow("كاميرا السائق", desc: "عرض بث كاميرا مراقبة السائق", icon: "person.fill.viewfinder", color: .nmkPrimary) {
                openURL(connection.driverCameraURL())
            }
            actionRow("إعادة ضبط المعايرة", desc: "إعادة معايرة الكاميرا والمستشعرات", icon: "scope", color: .nmkWarning) {
                confirm("هل أنت متأكد من إعادة ضبط المعايرة؟ سيتم إعادة معايرة الكاميرا.") { Task { await runCommand("reset_calibration", successMsg: "تم إعادة ضبط المعايرة بنجاح. يرجى القيادة لبضع دقائق لإعادة المعايرة.", errorMsg: "فشل في إعادة ضبط المعايرة") } }
            }
            actionRow("دليل التدريب", desc: "مراجعة دليل استخدام القائد الآلي", icon: "book.fill", color: .nmkSuccess) {
                openURL(connection.trainingGuideURL())
            }
            actionRow("تغيير اللغة", desc: "تبديل لغة واجهة الجهاز", icon: "globe", color: .cyan) {
                confirm("هل تريد تغيير اللغة؟ سيتم إعادة تشغيل الواجهة.") { Task { await runCommand("change_language", successMsg: "تم تغيير اللغة. سيتم إعادة تشغيل الواجهة.", errorMsg: "فشل في تغيير اللغة") } }
            }
            actionRow("إعادة التشغيل", desc: "إعادة تشغيل جهاز القائد الآلي", icon: "arrow.counterclockwise.circle.fill", color: .nmkWarning) {
                confirm("هل أنت متأكد من إعادة تشغيل الجهاز؟") { Task { await runCommand("reboot", successMsg: "جاري إعادة تشغيل الجهاز...", errorMsg: "فشل في إعادة تشغيل الجهاز", disconnectsAfter: true) } }
            }
            actionRow("إيقاف التشغيل", desc: "إيقاف تشغيل الجهاز بشكل آمن", icon: "power.circle.fill", color: .nmkDanger) {
                confirm("هل أنت متأكد من إيقاف تشغيل الجهاز؟") { Task { await runCommand("shutdown", successMsg: "جاري إيقاف تشغيل الجهاز...", errorMsg: "فشل في إيقاف تشغيل الجهاز", disconnectsAfter: true) } }
            }
        }
    }

    private func actionRow(_ title: String, desc: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: NMKMetrics.itemSpacing) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(color)
                    .frame(width: 36, height: 36)
                    .background(color.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(NMKFont.headline()).foregroundStyle(.nmkTextPrimary)
                    Text(desc).font(NMKFont.caption()).foregroundStyle(.nmkTextSecondary).lineLimit(1)
                }
                Spacer()
                Image(systemName: "chevron.left").foregroundStyle(.nmkTextTertiary)
            }
            .padding(NMKMetrics.cardPadding)
            .background(Color.nmkCard)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - شاشات الإعدادات الخمس

    @ViewBuilder
    private var settingsHubSection: some View {
        // ✅ @Bindable يتيح تمرير $bindings من SettingsStore المُستقبَل من البيئة
        @Bindable var settings = settingsStore

        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("إعدادات NMK Ai", subtitle: "القيادة، السيارة، الخريطة، العرض، التنبيهات")

            NMKNavigationCard("إعدادات القيادة", subtitle: "تغيير المسار، تثبيت المسار، السرعة", icon: "car", iconColor: .nmkPrimary, badge: settings.settings.driving.laneChangeMode.displayName) {
                DrivingSettingsView(settings: $settings.settings.driving)
            }
            NMKNavigationCard("إعدادات السيارة", subtitle: "الاسم، الموديل، الوقود", icon: "car.side", iconColor: .nmkSuccess, badge: settings.settings.car.displayName) {
                CarProfileView(car: $settings.settings.car)
            }
            NMKNavigationCard("إعدادات الخريطة", subtitle: "تثبيت، نوع، تدوير", icon: "map", iconColor: .nmkSecondary, badge: settings.settings.map.mapType.displayName) {
                MapSettingsView(settings: $settings.settings.map)
            }
            NMKNavigationCard("العرض المباشر", subtitle: "البث، الجودة، التسجيل", icon: "video", iconColor: .nmkWarning, badge: settings.settings.liveView.streamQuality.displayName) {
                LiveViewSettingsView(settings: $settings.settings.liveView)
            }
            NMKNavigationCard("التنبيهات", subtitle: "الصوت، المسار، السرعة، التصادم", icon: "bell", iconColor: .nmkDanger) {
                AlertSettingsView(settings: $settings.settings.alerts)
            }
        }
    }

    // MARK: - إعدادات القائد الآلي الحقيقية (Toggles)

    private var openpilotTogglesSection: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            HStack {
                NMKSectionHeader("إعدادات القائد الآلي", subtitle: "Toggles حقيقية تُرسل للجهاز")
            }

            // فئات التبويبات
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(OpenpilotCategory.allCases) { category in
                        categoryPill(category)
                    }
                }
                .padding(.horizontal, 4)
            }

            // الـ toggles في الفئة المحددة (أو كل الفئات في وضع المعاينة الشاملة)
            VStack(spacing: NMKMetrics.itemSpacing) {
                ForEach($toggles) { $toggle in
                    if showAllSections || toggle.category == selectedCategory {
                        // إظهار عنوان الفئة في وضع المعاينة الشاملة
                        openpilotToggleRow($toggle)
                            .id(toggle.id)
                    }
                }
            }
        }
    }

    private func categoryPill(_ category: OpenpilotCategory) -> some View {
        Button {
            withAnimation { selectedCategory = category }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: category.icon).font(.system(size: 11))
                Text(category.rawValue).font(NMKFont.caption())
            }
            .foregroundStyle(selectedCategory == category ? .white : .nmkTextPrimary)
            .padding(.horizontal, 12).padding(.vertical, 8)
            .background(selectedCategory == category ? Color.nmkPrimary : Color.nmkCard)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private func openpilotToggleRow(_ toggle: Binding<OpenpilotToggle>) -> some View {
        HStack(spacing: NMKMetrics.itemSpacing) {
            Image(systemName: toggle.wrappedValue.icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(toggle.wrappedValue.iconColor)
                .frame(width: 36, height: 36)
                .background(toggle.wrappedValue.iconColor.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadiusSmall))

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 6) {
                    Text(toggle.wrappedValue.title)
                        .font(NMKFont.headline())
                        .foregroundStyle(.nmkTextPrimary)

                    if toggle.wrappedValue.isAlpha {
                        Text("ألفا").font(.system(size: 9, weight: .bold))
                            .padding(.horizontal, 5).padding(.vertical, 2)
                            .background(Color.nmkWarning).foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    if toggle.wrappedValue.requiresReboot {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .font(.system(size: 11)).foregroundStyle(.nmkWarning)
                    }
                }
                Text(toggle.wrappedValue.description)
                    .font(NMKFont.caption()).foregroundStyle(.nmkTextSecondary).lineLimit(2)
            }
            Spacer()

            Toggle("", isOn: toggle.isEnabled)
                .labelsHidden().tint(.nmkSuccess)
                .onChange(of: toggle.wrappedValue.isEnabled) { _, newValue in
                    handleToggleChange(toggle.wrappedValue, newValue: newValue)
                }
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    // MARK: - تفعيل تلقائي للوضع التجريبي عبر argument

    private func checkDemoArgument() {
        let args = CommandLine.arguments
        // عند تمرير --demo من سطر الأوامر، يُفعّل الوضع التجريبي تلقائياً
        if args.contains("--demo") && !connection.isDemoMode {
            connection.toggleDemoMode()
        }
        // ✅ وضع المعاينة الشاملة: يعرض كل الأقسام مفتوحة دفعة واحدة
        if args.contains("--showall") {
            showAllSections = true
            showInstructions = true
        }
        // ✅ فتح شاشة معيّنة مباشرة: --screen driving (أو map/car/live/alerts)
        if let screenIdx = args.firstIndex(of: "--screen"), screenIdx + 1 < args.count {
            let target = args[screenIdx + 1]
            // اترك وقتاً للعرض ثم افتح
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                navPath = [target]
            }
        }
    }

    // MARK: - منطق الأزرار

    private func handleConnectButton() {
        if connection.isConnected {
            connection.disconnect()
            alertItem = AlertItem(title: "إشعار", message: "تم قطع الاتصال بالجهاز")
        } else {
            if connection.connect() {
                alertItem = AlertItem(title: "إشعار", message: "تم الاتصال بالجهاز على العنوان: \(connection.deviceIP)")
            } else {
                alertItem = AlertItem(title: "خطأ", message: "يرجى إدخال عنوان IP صحيح")
            }
        }
    }

    private func handleToggleChange(_ toggle: OpenpilotToggle, newValue: Bool) {
        Task {
            await connection.updateParam(key: toggle.id, value: newValue)
        }
        if toggle.requiresReboot {
            alertItem = AlertItem(title: "تنبيه", message: "تم تحديث الإعداد. يتطلب إعادة تشغيل الجهاز لتفعيل التغيير.")
        }
    }

    private func runCommand(_ endpoint: String, successMsg: String, errorMsg: String, disconnectsAfter: Bool = false) async {
        let success = await connection.sendCommand(endpoint: endpoint)
        await MainActor.run {
            if success {
                alertItem = AlertItem(title: "تم", message: successMsg)
                if disconnectsAfter { connection.disconnect() }
            } else {
                alertItem = AlertItem(title: "خطأ", message: errorMsg)
            }
        }
    }

    private func confirm(_ message: String, action: @escaping () -> Void) {
        confirmation = ConfirmationItem(message: message, action: action)
    }

    private func openURL(_ url: URL?) {
        guard let url else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - نماذج مساعدة للتنبيهات

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

struct ConfirmationItem: Identifiable {
    let id = UUID()
    let message: String
    let action: () -> Void
}

// MARK: - شاشة WebView بسيطة لفتح الروابط داخل التطبيق

struct WebViewScreen: UIViewControllerRepresentable {
    let url: URL?
    let title: String

    func makeUIViewController(context: Context) -> WebViewController {
        WebViewController()
    }
    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        uiViewController.loadURL(url, title: title)
    }
}

final class WebViewController: UIViewController {
    private let webView = WKWebViewWrapper()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(Color.nmkBackground)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func loadURL(_ url: URL?, title: String) {
        webView.loadURL(url)
        self.title = title
    }
}

// واجهة WKWebView ملفوفة بشكل آمن
private final class WKWebViewWrapper: UIView {
    // ✅ استخدام WKWebView? مباشرة بدل AnyObject? (أكثر أماناً ووضوحاً)
    private var webView: WKWebView?

    func loadURL(_ url: URL?) {
        if let existing = webView {
            // إعادة استخدام الويب فيو الموجود
            existing.stopLoading()
            if let url { existing.load(URLRequest(url: url)) }
        } else {
            // إنشاء WKWebView عند أول استخدام
            let wv = WKWebView()
            addSubview(wv)
            wv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                wv.topAnchor.constraint(equalTo: topAnchor),
                wv.bottomAnchor.constraint(equalTo: bottomAnchor),
                wv.leadingAnchor.constraint(equalTo: leadingAnchor),
                wv.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            if let url { wv.load(URLRequest(url: url)) }
            webView = wv
        }
    }

    // ✅ تنظيف الموارد عند إزالة الواجهة (منع تسرب الذاكرة)
    override func removeFromSuperview() {
        webView?.stopLoading()
        webView?.navigationDelegate = nil
        webView?.removeFromSuperview()
        webView = nil
        super.removeFromSuperview()
    }
}
