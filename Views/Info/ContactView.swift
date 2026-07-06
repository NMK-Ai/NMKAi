import SwiftUI

struct ContactView: View {
    let whatsappNumber = "966550057797"
    @State private var selectedTopic = "استفسار عام"
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.colorScheme) var colorScheme
    
    let topics = [
        "استفسار عام",
        "الدعم الفني",
        "الشكاوى والاقتراحات",
        "استفسار عن المنتجات",
        "مشكلة في التركيب",
        "طلب خدمة ما بعد البيع"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    Image(systemName: "message.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                        .padding(.top, 20)
                    
                    Text("تواصل معنا")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("نحن هنا لمساعدتك")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Divider()
                        .padding(.horizontal, 40)
                    
                    VStack(spacing: 15) {
                        ContactInfoRow(
                            icon: "phone.fill",
                            title: "رقم الواتساب",
                            value: formatPhoneNumber(whatsappNumber),
                            color: .green,
                            colorScheme: colorScheme
                        )
                        
                        ContactInfoRow(
                            icon: "clock.fill",
                            title: "أوقات العمل",
                            value: "من السبت إلى الخميس\n9:00 ص - 6:00 م",
                            color: .blue,
                            colorScheme: colorScheme
                        )
                        
                        ContactInfoRow(
                            icon: "envelope.fill",
                            title: "البريد الإلكتروني",
                            value: "support@nmk.sa",
                            color: .orange,
                            colorScheme: colorScheme
                        )
                    }
                    .padding()
                    .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                    .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("موضوع الاستفسار")
                            .font(.headline)
                        
                        Menu {
                            ForEach(topics, id: \.self) { topic in
                                Button(action: {
                                    selectedTopic = topic
                                }) {
                                    HStack {
                                        Text(topic)
                                        if selectedTopic == topic {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedTopic)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(colorScheme == .dark ? Color(UIColor.tertiarySystemGroupedBackground) : Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: openWhatsApp) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("التواصل عبر الواتساب")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("💡 نصائح للحصول على دعم أسرع")
                            .font(.headline)
                        
                        TipRow(text: "حدد موضوع استفسارك بوضوح")
                        TipRow(text: "اذكر موديل سيارتك إن أمكن")
                        TipRow(text: "أرفق صور أو فيديو للمشكلة إن وجدت")
                        TipRow(text: "اذكر رقم الطلب عند السؤال عن طلب معين")
                    }
                    .padding()
                    .background(colorScheme == .dark ? Color.blue.opacity(0.2) : Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                }
                .padding()
            }
            .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
            .navigationTitle("التواصل والاستفسار")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("تنبيه"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("حسناً"))
                )
            }
        }
    }
    
    func openWhatsApp() {
        let message = "مرحباً، لديّ \(selectedTopic)"
        let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let whatsappURL = "whatsapp://send?phone=\(whatsappNumber)&text=\(encodedMessage)"
        
        if let url = URL(string: whatsappURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                let webURL = "https://wa.me/\(whatsappNumber)?text=\(encodedMessage)"
                if let webUrl = URL(string: webURL) {
                    UIApplication.shared.open(webUrl)
                }
            }
        }
    }
    
    func formatPhoneNumber(_ number: String) -> String {
        if number.hasPrefix("966") {
            let withPlus = "+" + number
            let formatted = String(withPlus.prefix(4)) + " " +
                          String(withPlus.dropFirst(4).prefix(2)) + " " +
                          String(withPlus.dropFirst(6).prefix(3)) + " " +
                          String(withPlus.dropFirst(9))
            return formatted
        }
        return number
    }
}

struct ContactInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.blue)
                .font(.system(size: 16))
            
            Text(text)
                .font(.subheadline)
            
            Spacer()
        }
    }
}

#Preview {
Group {
            ContactView()
                .preferredColorScheme(.light)
            
            ContactView()
                .preferredColorScheme(.dark)
        }
}
