import SwiftUI

struct SocialView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let socialLinks = [
        SocialLink(
            name: "إنستقرام",
            icon: "camera.fill",
            color: Color(red: 193/255, green: 53/255, blue: 132/255),
            username: "@nmk_ksa",
            url: "https://instagram.com/nmk_ksa"
        ),
        SocialLink(
            name: "سناب شات",
            icon: "camera.viewfinder",
            color: Color(red: 255/255, green: 252/255, blue: 0/255),
            username: "@nmk_ksa",
            url: "https://snapchat.com/add/nmk_ksa1"
        ),
        SocialLink(
            name: "تيك توك",
            icon: "music.note",
            color: Color.black,
            username: "@nmk_ksa",
            url: "https://tiktok.com/@nmk_ksa"
        ),
        SocialLink(
            name: "يوتيوب",
            icon: "play.rectangle.fill",
            color: Color(red: 255/255, green: 0/255, blue: 0/255),
            username: "NMK_KSA",
            url: "https://youtube.com/@nmk_ksa"
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 10) {
                        Image(systemName: "square.grid.2x2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                            .padding(.top, 20)
                        
                        Text("تابعنا على وسائل التواصل")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("كن على اطلاع دائم بآخر الأخبار والتحديثات")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    Divider()
                        .padding(.horizontal, 40)
                    
                    VStack(spacing: 15) {
                        ForEach(socialLinks) { link in
                            SocialMediaCard(link: link, colorScheme: colorScheme)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("ماذا ستجد على حساباتنا؟")
                            .font(.headline)
                        
                        ContentRow(icon: "video.fill", text: "فيديوهات تعليمية وشروحات")
                        ContentRow(icon: "photo.fill", text: "صور وتجارب العملاء")
                        ContentRow(icon: "star.fill", text: "عروض وتخفيضات حصرية")
                        ContentRow(icon: "bell.fill", text: "إعلانات المنتجات الجديدة")
                        ContentRow(icon: "questionmark.circle.fill", text: "نصائح وإرشادات مفيدة")
                    }
                    .padding()
                    .background(colorScheme == .dark ? Color.blue.opacity(0.2) : Color.blue.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                }
                .padding(.vertical)
            }
            .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
            .navigationTitle("وسائل التواصل الاجتماعي")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SocialLink: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let username: String
    let url: String
}

struct SocialMediaCard: View {
    let link: SocialLink
    let colorScheme: ColorScheme
    
    var body: some View {
        Button(action: {
            if let url = URL(string: link.url) {
                UIApplication.shared.open(url)
            }
        }) {
            HStack(spacing: 15) {
                ZStack {
                    Circle()
                        .fill(link.color)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: link.icon)
                        .font(.system(size: 24))
                        .foregroundColor(link.name == "تيك توك" && colorScheme == .dark ? .white : .white)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(link.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(link.username)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.up.forward.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
            }
            .padding()
            .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
            .cornerRadius(12)
            .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ContentRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 18))
                .frame(width: 30)
            
            Text(text)
                .font(.body)
            
            Spacer()
        }
    }
}

#Preview {
Group {
            SocialView()
                .preferredColorScheme(.light)
            
            SocialView()
                .preferredColorScheme(.dark)
        }
}
