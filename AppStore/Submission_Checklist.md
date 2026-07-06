# ✅ قائمة فحص النشر على App Store

استخدم هذه القائمة للتأكد أن كل شيء جاهز قبل رفع التطبيق.

---

## 🔧 Phase 1: الإعداد التقني (تم ✓)

- [x] بناء Release نظيف (**BUILD SUCCEEDED** بدون أخطاء/تحذيرات)
- [x] أيقونة التطبيق 1024×1024 (`Resources/Assets.xcassets/AppIcon.appiconset/`)
- [x] `Info.plist` كامل (Bundle ID, ATS exception, الأذونات, اللغة العربية)
- [x] إصدار `2.0.0` (build `1`) مضبوط في `project.pbxproj`
- [x] iOS 17.0 كحد أدنى للنشر
- [x] `Bundle ID`: `sa.nmk.NMKAi`
- [x] استثناء App Transport Security للشبكة المحلية
- [x] وصف أذونات: Local Network, Camera, Microphone, Location

---

## 🔐 Phase 2: التوقيع والشهادات (يجب فعلها في Xcode)

- [ ] **Apple Developer Account** فعّال ($99/سنة)
- [ ] إنشاء **App ID** في [developer.apple.com](https://developer.apple.com) بالـ Bundle ID `sa.nmk.NMKAi`
- [ ] في Xcode → **Signing & Capabilities**:
  - [ ] اختر **Team** (حساب Apple Developer الخاص بك)
  - [ ] فعّل **Automatically manage signing**
  - [ ] تأكّد من ظهور "Signing Certificate" بـ حالة ✓
- [ ] إمكانية **Access WiFi Information** (مطلوبة لاكتشاف الشبكة)
- [ ] إمكانية **Local Network** (للاتصال بالجهاز)

---

## 📦 Phase 3: الأرشفة (Archive)

في Xcode:
1. اختر **Generic iOS Device** كـ destination (أي جهاز، ليس محاكي)
2. **Product → Archive**
3. انتظر انتهاء الأرشفة وفتح **Organizer**
4. اختر الأرشفة → **Distribute App → App Store Connect**
5. اتبع الخطوات حتى رفع الـ build

---

## 📱 Phase 4: App Store Connect

### إنشاء التطبيق
- [ ] ادخل [App Store Connect](https://appstoreconnect.apple.com)
- [ ] **My Apps → + → New App**
- [ ] **Platforms:** iOS
- [ ] **Name:** `NMK Ai — القائد الآلي`
- [ ] **Primary Language:** Arabic
- [ ] **Bundle ID:** `sa.nmk.NMKAi` (اختر من القائمة)
- [ ] **SKU:** `NMKAi2024`
- [ ] **Full Access** (أو حسب حالتك)

### تعبئة البيانات (من `AppStore_Metadata.md`)
- [ ] **App Information:** الاسم، الاسم الفرعي، الفئة
- [ ] **Description:** الصق من ملف الـ Metadata
- [ ] **Keywords:** الصق الكلمات المفتاحية
- [ ] **Promotional Text:** النص الترويجي
- [ ] **What's New:** ملاحظات الإصدار
- [ ] **Support URL:** `https://www.nmk.sa/support`
- [ ] **Marketing URL:** `https://www.nmk.sa`
- [ ] **Privacy Policy URL:** `https://www.nmk.sa/privacy` (هام جداً)

### اللقطات والصور
- [ ] **App Preview / Screenshots:** ارفع اللقطات من `docs/screenshots/appstore/`
  - [ ] 6.7" (iPhone 15/16 Pro Max): 1290×2796 — 3 لقطات جاهزة
  - [ ] 6.9" (iPhone 16 Pro Max): 1320×2868 — 3 لقطات جاهزة
- [ ] **App Icon:** ستُؤخذ تلقائياً من الـ build

### تصنيف المحتوى
- [ ] **Age Rating:** اختر "None" لكل الفئات → التصنيف **4+**
- [ ] **Content Rights:** لا يوجد محتوى يحتاج حقوق

### نموذج الخصوصية (مهم جداً ⚠️)
- [ ] **App Privacy → Data Types:** اختر **"Data Not Collected"**
- [ ] هذا يضمن ظهور التطبيق بشعار "خصوصية محمية"

### معلومات الإصدار
- [ ] انتظر ظهور الـ build في قسم **Build** (يأخذ 5-30 دقيقة بعد المعالجة)
- [ ] اختر الـ build المعالج
- [ ] **Copyright:** `© 2026 NMK`

---

## 🚀 Phase 5: المراجعة والنشر

- [ ] **Add for Review** — أرسل للمراجعة
- [ ] ملء استبيان الإصدار (Export Compliance, Content Rights)
- [ ] انتظر المراجعة (**1-3 أيام** عادة)
- [ ] بعد الموافقة، اضغط **Release**

---

## ⚠️ ملاحظات مهمة

1. **ATS Exception**: Apple قد تسأل عن سبب استثناء ATS — الجواب: "الاتصال بجهاز القائد الآلي على الشبكة المحلية يتطلب HTTP".

2. **Local Network Permission**: iOS 14+ يطلب إذن المستخدم للوصول للشبكة المحلية — النص الموجود في `Info.plist` (`NSLocalNetworkUsageDescription`) يشرح السبب.

3. **External Display**: لا توجد.

4. **IPv6**: التطبيق متوافق مع IPv6 (مطلوب من Apple).

5. **Demo Mode**: الـ arguments (`--demo`, `--screen`) لا تؤثر على المستخدم النهائي لأنه لا يمكنه تمريرها عبر متجر التطبيقات.

---

## 📞 الدعم

في حال رفض Apple للتطبيق، أسباب الرفض الشائعة:
- **Guideline 2.1** (معلومات ناقصة) → تأكّد من كل البيانات
- **Guideline 4.2** (وظائف محدودة) → أضف لقطات توضّح الفائدة
- **Guideline 5.1.1** (خصوصية) → تأكّد من نموذج الخصوصية
- **Guideline 2.5.5** (ATS) → وضّح سبب استثناء HTTP

تواصل مع Apple عبر **Resolution Center** لكل اعتراض.
