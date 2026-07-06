import SwiftUI
import AVKit

// MARK: - Features View
struct FeaturesView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // العنوان الرئيسي
                VStack(spacing: 8) {
                    Text("مزايا القائد الآلي")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 102/255, green: 126/255, blue: 234/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("يوفّر القائد الآلي مجموعة واسعة من الخصائص القابلة للتخصيص، سواء كنت تفضّل التجربة الأساسية أو تحب الإضافات المتقدمة.")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // الفيديو
                VideoPlayerView(videoURL: URL(string: "https://nmk2030.sirv.com/112.mp4")!)
                    .aspectRatio(16/9, contentMode: .fit)
                    .frame(maxWidth: 600)
                    .cornerRadius(16)
                    .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                
                // أقسام المزايا
                VStack(spacing: 16) {
                    // تخصيصات متقدمة
                    FeatureSection(
                        icon: "⚡",
                        title: "تخصيصات متقدمة",
                        features: [
                            "التحكم بمستوى صوت كل تنبيه",
                            "تخصيص مسافة التتبّع والتسارع لكل نمط قيادة",
                            "ضبط دقيق لنسبة التوجيه (Steer Ratio)",
                            "زيادة المسافة عند التوقف خلف مركبة",
                            "زيادة السرعة القصوى بخطوات مخصصة",
                            "الاختيار بين نماذج القيادة السابقة أو الحالية أو المستقبلية"
                        ],
                        gradientColors: [Color.orange, Color.yellow]
                    )
                    
                    // الوضع التجريبي الشرطي
                    FeatureSection(
                        icon: "🚀",
                        title: "الوضع التجريبي الشرطي",
                        subtitle: "يتم تفعيل الوضع التجريبي تلقائيًا في حالات مثل:",
                        features: [
                            "الاقتراب من التقاطعات والمنعطفات",
                            "الاقتراب من مركبات أبطأ",
                            "اكتشاف الإشارات والمنحنيات",
                            "القيادة تحت سرعة محددة",
                            "استخدام الإشارة للمساعدة في الالتفاف"
                        ],
                        gradientColors: [Color.red, Color.orange]
                    )
                    
                    // واجهة المطور
                    FeatureSection(
                        icon: "📊",
                        title: "واجهة المطور",
                        features: [
                            "عرض منطق القيادة (المسافة، السرعة، التتبّع)",
                            "قياس المسارات الجانبية",
                            "مراقبة CPU / GPU",
                            "مراقبة الذاكرة والتخزين"
                        ],
                        gradientColors: [Color.blue, Color.cyan]
                    )
                    
                    // إدارة الجهاز
                    FeatureSection(
                        icon: "🛠",
                        title: "إدارة الجهاز",
                        features: [
                            "التحكم في سطوع الشاشة",
                            "مؤقتات إيقاف الشاشة",
                            "نسخ احتياطي واستعادة الإصدارات",
                            "حماية بطارية السيارة",
                            "حذف بيانات القيادة",
                            "العمل دون اتصال بالإنترنت",
                            "تعطيل التسجيل أو الرفع",
                            "تحديث Panda من داخل النظام",
                            "وضع الاستعداد الذكي",
                            "إيقاف تلقائي بعد التوقف"
                        ],
                        gradientColors: [Color.gray, Color.black]
                    )
                    
                    // التحكم الجانبي
                    FeatureSection(
                        icon: "🚖",
                        title: "التحكم الجانبي (Lateral)",
                        features: [
                            "تفعيل التوجيه بزر مثبت السرعة",
                            "منع فصل التوجيه عند الفرامل أو البنزين",
                            "تغيير مسار ذكي بدون دفعة",
                            "إيقاف التوجيه حسب السرعة أو الإشارة",
                            "منعطفات دقيقة",
                            "دعم NNFF لتوجيه أنعم"
                        ],
                        gradientColors: [Color.green, Color.teal]
                    )
                    
                    // التحكم الطولي
                    FeatureSection(
                        icon: "🚘",
                        title: "التحكم الطولي (Longitudinal)",
                        features: [
                            "تسارع أقوى عند الانطلاق",
                            "التحكم بسرعة المنعطفات باستخدام الخرائط",
                            "كبح أنعم خلف المركبات",
                            "التحكم بالسرعة حسب اللوحات",
                            "أوضاع Sport / Eco / Traffic",
                            "تحسين اكتشاف المركبات",
                            "تحكم مرئي بالمنعطفات"
                        ],
                        gradientColors: [Color.purple, Color.pink]
                    )
                    
                    // الملاحة
                    FeatureSection(
                        icon: "🗺️",
                        title: "الملاحة",
                        features: [
                            "مباني ثلاثية الأبعاد",
                            "خرائط مخصصة",
                            "وضع الشاشة الكاملة",
                            "اختصارات iOS",
                            "بدون اشتراك NMK Prime",
                            "خرائط دون اتصال",
                            "دمج OpenStreetMaps"
                        ],
                        gradientColors: [Color.indigo, Color.blue]
                    )
                    
                    // واجهة القيادة
                    FeatureSection(
                        icon: "🎮",
                        title: "واجهة القيادة",
                        features: [
                            "بوصلة ديناميكية",
                            "عداد FPS",
                            "إخفاء عناصر الواجهة",
                            "عرض دواسات الوقود والفرامل",
                            "تخصيص المسارات والألوان",
                            "واجهة طريق ممتدة",
                            "حفظ موضع الشريط الجانبي",
                            "دوران الدركسون مع الحقيقي"
                        ],
                        gradientColors: [Color.mint, Color.green]
                    )
                    
                    // إضافات خاصة بالمركبات
                    FeatureSection(
                        icon: "🚙",
                        title: "إضافات خاصة بالمركبات",
                        features: [
                            "اختيار بصمة المركبة يدويًا",
                            "ضبط خاص لمركبات GM وToyota/Lexus",
                            "دعم Volt و Clarity",
                            "عزم إضافي لـ Subaru Crosstrek",
                            "قفل الأبواب تلقائي",
                            "دعم مركبات بدون ACC",
                            "Pedal Interceptor",
                            "Stop & Go لـ Toyota",
                            "دعم ZSS لـ Prius و Sienna"
                        ],
                        gradientColors: [Color(red: 102/255, green: 126/255, blue: 234/255), Color(red: 118/255, green: 75/255, blue: 162/255)]
                    )
                    
                    // تحسينات الاستخدام اليومي
                    FeatureSection(
                        icon: "🚦",
                        title: "تحسينات الاستخدام اليومي",
                        features: [
                            "تحديثات تلقائية",
                            "تنبيهات ذكية",
                            "عرض كاميرا السائق عند الرجوع",
                            "إحصائيات القيادة",
                            "برنامج التحكم بالقائد الآلي على آيفون وآيباد",
                            "مسجل شاشة",
                            "طرق متعددة لتفعيل الوضع التجريبي"
                        ],
                        gradientColors: [Color.red, Color.yellow]
                    )
                }
                .padding(.horizontal)
                
                // رابط الشراء
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
        .navigationBarTitle("المزايا", displayMode: .inline)
    }
}

// MARK: - Video Player View
struct VideoPlayerView: UIViewControllerRepresentable {
    let videoURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspectFill
        
        // تشغيل تلقائي
        player.play()
        
        // إعادة التشغيل عند الانتهاء
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

// MARK: - Feature Section Component
struct FeatureSection: View {
    @Environment(\.colorScheme) var colorScheme
    let icon: String
    let title: String
    var subtitle: String? = nil
    let features: [String]
    let gradientColors: [Color]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // العنوان مع الأيقونة
            HStack(spacing: 10) {
                Text(icon)
                    .font(.system(size: 24))
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? .white : .primary)
                Spacer()
            }
            
            // العنوان الفرعي إن وجد
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            // قائمة المزايا
            VStack(alignment: .leading, spacing: 8) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: gradientColors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 8, height: 8)
                        
                        Text(feature)
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
    }
}

// MARK: - Preview
#Preview {
Group {
            NavigationStack {
                FeaturesView()
            }
            .preferredColorScheme(.light)
            
            NavigationStack {
                FeaturesView()
            }
            .preferredColorScheme(.dark)
        }
}
