import SwiftUI

// MARK: - الشاشة الرئيسية المدمجة (NMK Ai + القائد الآلي)
/// 7 تبويبات تجمع كل مزايا المشروعين

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var settings = SettingsStore()

    init() {
        // ✅ دعم تمرير argument من سطر الأوامر للتجربة التلقائية
        // مثال: simctl launch booted sa.nmk.NMKAi --tab 1 --demo
        let args = CommandLine.arguments
        if let tabIdx = args.firstIndex(of: "--tab"), tabIdx + 1 < args.count, let n = Int(args[tabIdx + 1]) {
            _selectedTab = State(initialValue: n)
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // 1. الرئيسية
            HomeView()
                .tabItem { Label("الرئيسية", systemImage: "house.fill") }
                .tag(0)

            // 2. التحكم بالقائد الآلي (الاتصال + الإعدادات)
            ControlView()
                .tabItem { Label("التحكم", systemImage: "slider.horizontal.3") }
                .tag(1)

            // 3. المساعد الصوتي
            VoiceControlView()
                .tabItem { Label("المساعد", systemImage: "mic.fill") }
                .tag(2)

            // 4. السيارات المدعومة
            CarsView()
                .tabItem { Label("السيارات", systemImage: "car.fill") }
                .tag(3)

            // 5. المزايا
            FeaturesView()
                .tabItem { Label("المزايا", systemImage: "sparkles") }
                .tag(4)

            // 6. التركيب
            InstallationView()
                .tabItem { Label("التركيب", systemImage: "wrench.and.screwdriver.fill") }
                .tag(5)

            // 7. التعليمات
            UserManualView()
                .tabItem { Label("التعليمات", systemImage: "book.fill") }
                .tag(6)

            // 8. التواصل
            ContactView()
                .tabItem { Label("التواصل", systemImage: "message.fill") }
                .tag(7)
        }
        .tint(.nmkPrimary)
        .environment(\.layoutDirection, .rightToLeft)
        // ✅ تمرير نسخة واحدة من SettingsStore لكل التبويبات (تجنّب النسخ المتعددة)
        .environment(settings)
    }
}

// MARK: - الشاشة الرئيسية (مدمجة من HomeView الأصلي + بطاقات NMK Ai)

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: NMKMetrics.sectionSpacing) {
                    // بطاقة الترحيب
                    welcomeCard

                    // أزرار سريعة
                    quickActionsGrid

                    // المزايا
                    featuresListCard

                    // المتجر
                    storeCard
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 24)
            }
            .background(Color.nmkBackground)
            .navigationTitle("NMK Ai")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private var welcomeCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("مرحباً بك 👋")
                .font(NMKFont.subheadline())
                .foregroundStyle(.nmkTextSecondary)

            Text("القائد الآلي")
                .font(NMKFont.largeTitle())
                .foregroundStyle(.nmkTextPrimary)

            Text("نظام مساعد في القيادة بالذكاء الاصطناعي")
                .font(NMKFont.subheadline())
                .foregroundStyle(.nmkTextSecondary)

            HStack(spacing: 8) {
                NMKStatusBadge(text: "NMK Ai", color: .nmkPrimary)
                NMKStatusBadge(text: "الإصدار 2.0", color: .nmkSecondary)
            }
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(NMKMetrics.cardPadding + 4)
        .background(
            LinearGradient(colors: [Color.nmkPrimary.opacity(0.15), Color.nmkSecondary.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    private var quickActionsGrid: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("اختصارات")

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: NMKMetrics.itemSpacing) {
                quickAction(icon: "slider.horizontal.3", title: "التحكم", color: .nmkPrimary)
                quickAction(icon: "car.fill", title: "السيارات", color: .nmkSuccess)
                quickAction(icon: "sparkles", title: "المزايا", color: .nmkSecondary)
                quickAction(icon: "wrench.and.screwdriver.fill", title: "التركيب", color: .nmkWarning)
            }
        }
    }

    private func quickAction(icon: String, title: String, color: Color) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(color)
                .frame(width: 48, height: 48)
                .background(color.opacity(0.12))
                .clipShape(Circle())
            Text(title)
                .font(NMKFont.subheadline())
                .foregroundStyle(.nmkTextPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    private var featuresListCard: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("لماذا القائد الآلي؟")

            VStack(alignment: .leading, spacing: 12) {
                featureRow("تقنية متطورة للقيادة الذكية")
                featureRow("دعم للعديد من موديلات السيارات")
                featureRow("سهولة في التركيب والاستخدام")
                featureRow("دعم فني متواصل")
            }
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }

    private func featureRow(_ text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.nmkSuccess)
            Text(text)
                .font(NMKFont.body())
                .foregroundStyle(.nmkTextPrimary)
            Spacer()
        }
    }

    private var storeCard: some View {
        VStack(alignment: .leading, spacing: NMKMetrics.itemSpacing) {
            NMKSectionHeader("المتجر الإلكتروني", subtitle: "اكتشف منتجاتنا من أجهزة القائد الآلي")

            Button {
                if let url = URL(string: "https://www.nmk.sa") { UIApplication.shared.open(url) }
            } label: {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("زيارة المتجر")
                }
                .font(NMKFont.headline())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.nmkPrimary)
                .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
            }
            .buttonStyle(.plain)
        }
        .padding(NMKMetrics.cardPadding)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }
}
