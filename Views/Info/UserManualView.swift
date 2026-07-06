import SwiftUI

// MARK: - User Manual View
struct UserManualView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // العنوان الرئيسي
                VStack(spacing: 8) {
                    Text("📘 كتيّب تعليمات الاستخدام")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 102/255, green: 126/255, blue: 234/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("جهاز القائد الآلي")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("إرشادات التشغيل – السلامة – الضمان")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                // تحذير مهم
                WarningBanner(
                    text: "يرجى قراءة هذا الكتيّب بعناية قبل استخدام الجهاز. عدم الالتزام بهذه التعليمات قد يؤدي إلى تعطل الجهاز أو إلغاء الضمان.",
                    colorScheme: colorScheme
                )
                
                // 1️⃣ آلية التعامل مع الجهاز
                ManualSection(
                    icon: "1️⃣",
                    title: "آلية التعامل مع الجهاز",
                    items: [
                        "يُعامل جهاز القائد الآلي معاملة الأجهزة الإلكترونية الذكية (مثل الهواتف الذكية).",
                        "الجهاز مخصص للاستخدام أثناء تشغيل المركبة فقط.",
                        "لا يُترك الجهاز معرّضًا للشمس أو الحرارة المرتفعة لفترات طويلة."
                    ],
                    gradientColors: [Color.blue, Color.cyan],
                    colorScheme: colorScheme
                )
                
                // 2️⃣ متطلبات الطاقة والتشغيل
                ManualSection(
                    icon: "2️⃣",
                    title: "متطلبات الطاقة والتشغيل",
                    items: [
                        "يجب تشغيل الجهاز وهو موصول مباشرة بكهرباء المركبة.",
                        "يمنع تشغيل الجهاز دون مصدر طاقة ثابت.",
                        "يمنع استخدام بطاريات متنقلة.",
                        "يمنع الاشتراك الكهربائي الخارجي.",
                        "يمنع نقل الطاقة من مركبة أخرى.",
                        "أي تلف ناتج عن توصيل كهربائي غير معتمد غير مشمول بالضمان."
                    ],
                    gradientColors: [Color.orange, Color.yellow],
                    colorScheme: colorScheme
                )
                
                // 3️⃣ حالة المركبة أثناء التوقف
                ManualSection(
                    icon: "3️⃣",
                    title: "حالة المركبة أثناء التوقف",
                    items: [
                        "يمنع ترك الجهاز مشتغل والمركبة مطفأة.",
                        "يمنع ترك الجهاز معلّق على الزجاج والمركبة مطفأة.",
                        "في حال إيقاف المركبة لفترة طويلة، يجب فصل الجهاز أو إنزاله."
                    ],
                    gradientColors: [Color.red, Color.orange],
                    colorScheme: colorScheme
                )
                
                // 4️⃣ الزجاج الأمامي والعزل الحراري
                ManualSection(
                    icon: "4️⃣",
                    title: "الزجاج الأمامي والعزل الحراري",
                    items: [
                        "يوصى بتركيب عازل حراري أصلي ومعتمد من 3M على الزجاج الأمامي.",
                        "العازل الحراري يساهم في خفض الحرارة داخل المقصورة.",
                        "العازل الحراري يحمي الجهاز من التلف الحراري.",
                        "استخدام عازل غير أصلي قد يؤدي إلى ضعف أداء الجهاز.",
                        "استخدام عازل غير مناسب قد يؤدي إلى خروج الجهاز من نطاق الضمان."
                    ],
                    gradientColors: [Color.purple, Color.pink],
                    colorScheme: colorScheme
                )
                
                // 5️⃣ كهرباء المركبة
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Text("5️⃣")
                            .font(.system(size: 24))
                        Text("كهرباء المركبة")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        Spacer()
                        Text("نقطة ضمان أساسية")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    
                    Text("يعتمد عمل جهاز القائد الآلي بشكل مباشر على سلامة النظام الكهربائي للمركبة.")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    Text("أي خلل في كهرباء السيارة قد يسبب خللًا أو تلفًا في الجهاز:")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(["ضعف أو تذبذب الجهد الكهربائي", "مشاكل في البطارية أو الدينمو", "أعطال في الفيوزات أو التوصيلات", "تعديلات كهربائية غير أصلية"], id: \.self) { item in
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.system(size: 12))
                                Text(item)
                                    .font(.system(size: 13))
                                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.9) : .primary.opacity(0.8))
                                Spacer()
                            }
                        }
                    }
                    
                    Text("⚠️ يجب إصلاح أي عطل كهربائي في المركبة قبل استخدام القائد الآلي.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.orange)
                        .padding(.top, 4)
                    
                    Text("أي عطل أو تلف في الجهاز ناتج عن مشاكل كهرباء المركبة لا يشمله الضمان نهائيًا.")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                }
                .padding()
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.red.opacity(0.3), lineWidth: 2)
                )
                .padding(.horizontal)
                
                // 6️⃣ تعليمات السلامة أثناء القيادة
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Text("6️⃣")
                            .font(.system(size: 24))
                        Text("تعليمات السلامة أثناء القيادة")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "exclamationmark.shield.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                        Text("القائد الآلي نظام مساعدة على القيادة وليس بديلاً عن السائق.")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    
                    Text("يجب على السائق:")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(["متابعة الطريق باستمرار", "إبقاء اليدين بالقرب من المقود", "التدخل الفوري عند الحاجة"], id: \.self) { item in
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 12))
                                Text(item)
                                    .font(.system(size: 13))
                                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.9) : .primary.opacity(0.8))
                                Spacer()
                            }
                        }
                    }
                    
                    Text("⚠️ إساءة الاستخدام أو تجاهل التنبيهات يعرض السائق والمركبة للخطر.")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.orange)
                        .padding(.top, 4)
                }
                .padding()
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.green.opacity(0.3)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .padding(.horizontal)
                
                // 7️⃣ ما لا يشمله الضمان
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Text("7️⃣")
                            .font(.system(size: 24))
                        Text("ما لا يشمله الضمان")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                        Spacer()
                    }
                    
                    Text("لا يشمل الضمان الأعطال الناتجة عن:")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach([
                            "الرطوبة أو دخول السوائل",
                            "التعرض المباشر أو الطويل للحرارة أو الشمس",
                            "التماس الكهربائي أو التوصيل غير الصحيح",
                            "السقوط أو الكسر أو سوء الاستخدام",
                            "العبث بالسوفتوير أو تثبيت أنظمة غير معتمدة",
                            "استخدام الجهاز في مركبة تحتوي على أعطال كهربائية",
                            "الاستخدام خارج تعليمات التشغيل الموصى بها"
                        ], id: \.self) { item in
                            HStack(spacing: 8) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                                Text(item)
                                    .font(.system(size: 13))
                                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.9) : .primary.opacity(0.8))
                                Spacer()
                            }
                        }
                    }
                    
                    // رابط تفاصيل الضمان
                    Link(destination: URL(string: "https://nmk.sa/سياسة-الاستبدال-والاسترجاع/page-555658556")!) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                            Text("📌 تفاصيل الضمان الكاملة")
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                            Image(systemName: "arrow.up.right.square")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .padding(.top, 8)
                }
                .padding()
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.15), radius: 5, x: 0, y: 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.red.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
                
                // 8️⃣ توصيات الشركة
                ManualSection(
                    icon: "8️⃣",
                    title: "توصيات الشركة",
                    items: [
                        "استخدم الجهاز وفق الإرشادات فقط.",
                        "لا تحاول صيانة أو فك الجهاز ذاتيًا.",
                        "حافظ على نظافة العدسات والزجاج الأمامي.",
                        "عند ظهور أي خلل، تواصل مع الدعم الفني المعتمد."
                    ],
                    gradientColors: [Color.green, Color.teal],
                    colorScheme: colorScheme
                )
                
                // تنبيه مهم أخير
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 24))
                        Text("تنبيه مهم")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                        Spacer()
                    }
                    
                    Text("عدم الالتزام بهذه التعليمات قد يؤدي إلى:")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(colorScheme == .dark ? .white : .primary)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach([
                            "توقف الجهاز عن العمل",
                            "تلف دائم في المكونات",
                            "إلغاء الضمان دون أي التزام إصلاح أو استبدال"
                        ], id: \.self) { item in
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.octagon.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12))
                                Text(item)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.red, lineWidth: 2)
                )
                .padding(.horizontal)
                
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
        .navigationBarTitle("تعليمات الاستخدام", displayMode: .inline)
    }
}

// MARK: - Warning Banner Component
struct WarningBanner: View {
    let text: String
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "info.circle.fill")
                .foregroundColor(.blue)
                .font(.system(size: 20))
            
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(colorScheme == .dark ? .white.opacity(0.9) : .primary.opacity(0.8))
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

// MARK: - Manual Section Component
struct ManualSection: View {
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

// MARK: - Preview
#Preview {
Group {
            NavigationStack {
                UserManualView()
            }
            .preferredColorScheme(.light)
            
            NavigationStack {
                UserManualView()
            }
            .preferredColorScheme(.dark)
        }
}
