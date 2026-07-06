import SwiftUI
import AVKit

// MARK: - Installation View
struct InstallationView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // العنوان الرئيسي
                VStack(spacing: 8) {
                    Text("تركيب القائد الآلي")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 102/255, green: 126/255, blue: 234/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("لتركيب جهاز القائد الآلي في سيارتك، اتبع الخطوات التالية لضمان التثبيت السليم والتشغيل الأمثل.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // فيديو التركيب
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Text("🎬")
                            .font(.system(size: 24))
                        Text("فيديو التركيب")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        Spacer()
                    }
                    
                    // زر مشاهدة الفيديو على TikTok
                    Link(destination: URL(string: "https://vt.tiktok.com/ZSPwVpVHe/")!) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 24))
                            Text("شاهد فيديو التركيب على TikTok")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black,
                                    Color(red: 37/255, green: 244/255, blue: 238/255)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                }
                .padding()
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .padding(.horizontal)
                
                // الأدوات والمعدات المطلوبة
                InstallationSection(
                    icon: "🔧",
                    title: "الأدوات والمعدات المطلوبة",
                    items: [
                        "جهاز القائد الآلي",
                        "ضفائر التوصيل المناسبة لسيارتك (تويوتا أو هوندا)",
                        "كابل USB-C",
                        "حامل التثبيت",
                        "أدوات يدوية بسيطة (مفكات، كماشة)"
                    ],
                    gradientColors: [Color.blue, Color.cyan],
                    colorScheme: colorScheme
                )
                
                // الخطوات
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 10) {
                        Text("📋")
                            .font(.system(size: 24))
                        Text("خطوات التركيب")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        Spacer()
                    }
                    
                    InstallationStep(
                        number: 1,
                        title: "التأكد من توافق الجهاز مع سيارتك",
                        description: "قبل البدء في التركيب، تحقق من أن جهاز القائد الآلي والضفائر متوافقة مع طراز سيارتك.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 2,
                        title: "إيقاف تشغيل السيارة",
                        description: "تأكد من أن السيارة مطفأة تمامًا قبل بدء عملية التثبيت.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 3,
                        title: "تركيب حامل التثبيت",
                        description: "قم بتثبيت الحامل على الزجاج الأمامي للسيارة باستخدام اللاصق المرفق أو أي وسيلة تثبيت أخرى تتناسب مع الحامل.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 4,
                        title: "توصيل الضفائر",
                        description: "قم بتوصيل ضفائر التوصيل بالأسلاك الخاصة بسيارتك. اتبع التعليمات الخاصة بالضفيرة للتأكد من التوصيل الصحيح. يجب أن تتأكد من تثبيت جميع الأسلاك بإحكام لتجنب أي مشاكل في الاتصال.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 5,
                        title: "تثبيت جهاز القائد الآلي",
                        description: "قم بتثبيت جهاز القائد الآلي على الحامل المثبت على الزجاج الأمامي.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 6,
                        title: "توصيل الجهاز",
                        description: "استخدم كابل USB-C لتوصيل جهاز القائد الآلي بمصدر الطاقة المناسب في سيارتك. عادة ما يتم توصيله بمنفذ USB في السيارة.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 7,
                        title: "ضبط إعدادات الجهاز",
                        description: "قم بتشغيل السيارة وجهاز القائد الآلي. اتبع التعليمات على الشاشة لضبط إعدادات الجهاز وربطه بنظام السيارة.",
                        colorScheme: colorScheme
                    )
                    
                    InstallationStep(
                        number: 8,
                        title: "التجربة والتأكد من التشغيل السليم",
                        description: "بعد الانتهاء من التثبيت، قم بتجربة القيادة للتأكد من أن الجهاز يعمل بشكل صحيح. تحقق من أن جميع الوظائف تعمل كما هو متوقع.",
                        colorScheme: colorScheme
                    )
                }
                .padding()
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .padding(.horizontal)
                
                // نصائح إضافية
                InstallationSection(
                    icon: "💡",
                    title: "نصائح إضافية",
                    items: [
                        "تأكد من قراءة دليل المستخدم المرفق مع جهاز القائد الآلي بعناية قبل البدء في عملية التثبيت.",
                        "إذا كنت غير متأكد من أي خطوة، استشر فني محترف لضمان التركيب السليم.",
                        "إذا كان لديك أي استفسارات إضافية أو تحتاج إلى مساعدة في خطوات معينة، فلا تتردد في التواصل معنا."
                    ],
                    gradientColors: [Color.orange, Color.yellow],
                    colorScheme: colorScheme
                )
                
                // زر الشراء
                Link(destination: URL(string: "https://nmk.sa/redirect/products/1586232927")!) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("اشتري القائد الآلي الجيل الثالث")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 102/255, green: 126/255, blue: 234/255),
                                Color(red: 118/255, green: 75/255, blue: 162/255)
                            ]),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
        .navigationBarTitle("التركيب", displayMode: .inline)
    }
}

// MARK: - Installation Section Component
struct InstallationSection: View {
    let icon: String
    let title: String
    let items: [String]
    let gradientColors: [Color]
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Text(icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: gradientColors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 8, height: 8)
                            .padding(.top, 6)
                        
                        Text(item)
                            .font(.system(size: 13))
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.9) : .primary.opacity(0.8))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
        .cornerRadius(16)
        .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors.map { $0.opacity(0.3) }),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
    }
}

// MARK: - Installation Step Component
struct InstallationStep: View {
    let number: Int
    let title: String
    let description: String
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // رقم الخطوة
            Text("\(number)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 102/255, green: 126/255, blue: 234/255),
                            Color(red: 118/255, green: 75/255, blue: 162/255)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(14)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Preview
#Preview {
Group {
            NavigationStack {
                InstallationView()
            }
            .preferredColorScheme(.light)
            
            NavigationStack {
                InstallationView()
            }
            .preferredColorScheme(.dark)
        }
}
