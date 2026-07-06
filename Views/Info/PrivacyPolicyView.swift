import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $selectedTab) {
                Text("سياسة الخصوصية").tag(0)
                Text("شروط الاستخدام").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if selectedTab == 0 {
                        PrivacyContent(colorScheme: colorScheme)
                    } else {
                        TermsContent(colorScheme: colorScheme)
                    }
                }
                .padding()
            }
            .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle(selectedTab == 0 ? "سياسة الخصوصية" : "شروط الاستخدام")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyContent: View {
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HeaderSection(
                icon: "lock.shield.fill",
                title: "سياسة الخصوصية",
                subtitle: "آخر تحديث: ديسمبر 2024",
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "1. المعلومات التي نجمعها",
                content: """
                نحن في القائد الآلي نلتزم بحماية خصوصيتك. نقوم بجمع المعلومات التالية:
                
                • معلومات الاتصال: عنوان IP الخاص بجهاز القائد الآلي للاتصال المحلي
                • معلومات الاستخدام: سجلات الاتصال والتفاعل مع التطبيق
                • معلومات الجهاز: نوع الجهاز ونظام التشغيل
                
                جميع المعلومات المتعلقة بالاتصال بجهاز القائد الآلي تبقى محلية على شبكتك ولا يتم إرسالها إلى خوادمنا.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "2. كيفية استخدام المعلومات",
                content: """
                نستخدم المعلومات التي نجمعها للأغراض التالية:
                
                • تسهيل الاتصال بين التطبيق وجهاز القائد الآلي
                • تحسين تجربة المستخدم وأداء التطبيق
                • تقديم الدعم الفني والمساعدة
                • إرسال التحديثات والإشعارات المهمة
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "3. مشاركة المعلومات",
                content: """
                نحن لا نبيع أو نشارك معلوماتك الشخصية مع أطراف ثالثة باستثناء:
                
                • عندما يتطلب القانون ذلك
                • لحماية حقوقنا وممتلكاتنا
                • بموافقتك الصريحة
                
                جميع الاتصالات مع جهاز القائد الآلي تتم محلياً على شبكتك الخاصة.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "4. أمان المعلومات",
                content: """
                نتخذ إجراءات أمنية مناسبة لحماية معلوماتك:
                
                • تشفير البيانات أثناء النقل
                • حماية الوصول إلى المعلومات
                • مراجعة دورية للإجراءات الأمنية
                • عدم تخزين معلومات حساسة على الخوادم
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "5. حقوقك",
                content: """
                لديك الحق في:
                
                • الوصول إلى معلوماتك الشخصية
                • تصحيح أو تحديث معلوماتك
                • حذف معلوماتك
                • الاعتراض على معالجة معلوماتك
                
                للاستفسارات حول خصوصيتك، يرجى التواصل معنا عبر: support@nmk.sa
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "6. ملفات تعريف الارتباط",
                content: """
                التطبيق لا يستخدم ملفات تعريف الارتباط (Cookies) لتتبع نشاطك. جميع البيانات المخزنة محلياً على جهازك لتحسين تجربة الاستخدام فقط.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "7. تحديثات السياسة",
                content: """
                قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم إخطارك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.
                """,
                colorScheme: colorScheme
            )
            
            ContactSection(colorScheme: colorScheme)
        }
    }
}

struct TermsContent: View {
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HeaderSection(
                icon: "doc.text.fill",
                title: "شروط الاستخدام",
                subtitle: "آخر تحديث: ديسمبر 2024",
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "1. قبول الشروط",
                content: """
                باستخدامك لتطبيق القائد الآلي، فإنك توافق على هذه الشروط والأحكام. إذا كنت لا توافق على أي من هذه الشروط، يرجى عدم استخدام التطبيق.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "2. الاستخدام المسموح",
                content: """
                يسمح لك باستخدام التطبيق لـ:
                
                • الاتصال والتحكم في جهاز القائد الآلي الخاص بك
                • الوصول إلى ميزات التحكم والإعدادات
                • الحصول على الدعم الفني
                • تصفح المعلومات والمحتوى المتاح
                
                يجب استخدام التطبيق فقط للأغراض المشروعة والقانونية.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "3. الاستخدام المحظور",
                content: """
                يحظر عليك:
                
                • استخدام التطبيق لأي غرض غير قانوني
                • محاولة اختراق أو إتلاف النظام
                • نسخ أو توزيع محتوى التطبيق دون إذن
                • التلاعب بالبيانات أو المعلومات
                • استخدام التطبيق بطريقة تضر بالآخرين
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "4. المسؤولية",
                content: """
                • التطبيق يقدم "كما هو" دون ضمانات صريحة أو ضمنية
                • نحن غير مسؤولين عن أي أضرار ناتجة عن استخدام التطبيق
                • المستخدم مسؤول عن الاستخدام الآمن للجهاز والتطبيق
                • نحن غير مسؤولين عن انقطاع الخدمة أو الأخطاء التقنية
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "5. الملكية الفكرية",
                content: """
                جميع حقوق الملكية الفكرية للتطبيق ومحتواه محفوظة لشركة NMK. يشمل ذلك:
                
                • التصميم والواجهة
                • الشعارات والعلامات التجارية
                • المحتوى النصي والمرئي
                • الكود البرمجي والتقنيات المستخدمة
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "6. التحديثات والصيانة",
                content: """
                • قد نقوم بتحديث التطبيق دون إشعار مسبق
                • قد تتطلب بعض التحديثات إعادة تشغيل التطبيق
                • نحتفظ بالحق في إجراء صيانة دورية
                • قد تؤثر التحديثات على توافق بعض الأجهزة القديمة
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "7. إنهاء الاستخدام",
                content: """
                نحتفظ بالحق في:
                
                • تعليق أو إنهاء وصولك للتطبيق في حالة انتهاك الشروط
                • تعديل أو إيقاف أي ميزة في التطبيق
                • حذف الحسابات غير النشطة
                
                يمكنك التوقف عن استخدام التطبيق في أي وقت.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "8. القانون الساري",
                content: """
                تخضع هذه الشروط والأحكام لأنظمة المملكة العربية السعودية. أي نزاع ناشئ عن هذه الشروط سيتم حله وفقاً للقوانين المعمول بها في المملكة.
                """,
                colorScheme: colorScheme
            )
            
            PolicySection(
                title: "9. الدعم الفني",
                content: """
                نوفر الدعم الفني عبر:
                
                • الواتساب: +966 55 005 7797
                • البريد الإلكتروني: support@nmk.sa
                • ساعات العمل: من السبت إلى الخميس، 9:00 ص - 6:00 م
                """,
                colorScheme: colorScheme
            )
            
            ContactSection(colorScheme: colorScheme)
        }
    }
}

struct HeaderSection: View {
    let icon: String
    let title: String
    let subtitle: String
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}

struct PolicySection: View {
    let title: String
    let content: String
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            Text(content)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
        .cornerRadius(12)
    }
}

struct ContactSection: View {
    let colorScheme: ColorScheme
    
    var body: some View {
        VStack(spacing: 15) {
            Divider()
            
            VStack(spacing: 12) {
                Image(systemName: "envelope.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("للاستفسارات والدعم")
                    .font(.headline)
                
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("support@nmk.sa")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.green)
                        Text("+966 55 005 7797")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.blue)
                        Text("www.nmk.sa")
                            .foregroundColor(.secondary)
                    }
                }
                .font(.subheadline)
            }
            .padding()
            .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.blue.opacity(0.05))
            .cornerRadius(12)
        }
        .padding(.top, 20)
    }
}

#Preview {
Group {
            NavigationStack {
                PrivacyPolicyView()
            }
            .preferredColorScheme(.light)
            
            NavigationStack {
                PrivacyPolicyView()
            }
            .preferredColorScheme(.dark)
        }
}
