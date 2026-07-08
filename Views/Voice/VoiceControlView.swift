//
//  VoiceControlView.swift
//  NMKAi — القائد الآلي
//
//  واجهة المساعد الصوتي للتحكم بالمركبة
//  Voice Assistant View — Vehicle Control
//
//  Author: NMK-Ai
//

import SwiftUI

struct VoiceControlView: View {
    @EnvironmentObject var connection: DeviceConnectionService
    @State private var voiceService = VoiceAssistantService()
    @State private var showCommandsList = false
    @State private var hasPermission = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // زر الميكروفون
                    micSection
                    
                    // آخر رد
                    if !voiceService.lastResponse.isEmpty {
                        responseCard
                    }
                    
                    // الأوامر السريعة
                    quickActionsSection
                    
                    // حالة المركبة
                    vehicleStateSection
                    
                    // سجل الأوامر
                    if !voiceService.commandHistory.isEmpty {
                        historySection
                    }
                }
                .padding()
            }
            .background(Color.nmkBackground)
            .navigationTitle("المساعد الصوتي")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showCommandsList = true }) {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundStyle(.nmkPrimary)
                    }
                }
            }
            .sheet(isPresented: $showCommandsList) {
                VoiceCommandsListView()
            }
        }
        .onAppear {
            voiceService.deviceService = connection
            voiceService.requestPermissions { granted in
                hasPermission = granted
            }
        }
    }
    
    // MARK: - الميكروفون
    
    private var micSection: some View {
        VStack(spacing: 16) {
            Button(action: { voiceService.toggleListening() }) {
                ZStack {
                    // حلقات متحركة عند الاستماع
                    if voiceService.isListening {
                        ForEach(0..<3, id: \.self) { i in
                            Circle()
                                .stroke(Color.nmkPrimary.opacity(0.3), lineWidth: 2)
                                .frame(width: 120 + CGFloat(i * 30), height: 120 + CGFloat(i * 30))
                                .scaleEffect(voiceService.isListening ? 1.3 : 1.0)
                                .opacity(voiceService.isListening ? 0 : 0.5)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                        .repeatForever(autoreverses: false)
                                        .delay(Double(i) * 0.3),
                                    value: voiceService.isListening
                                )
                        }
                    }
                    
                    Circle()
                        .fill(voiceService.isListening ? Color.nmkDanger : Color.nmkPrimary)
                        .frame(width: 120, height: 120)
                        .shadow(
                            color: voiceService.isListening
                                ? Color.nmkDanger.opacity(0.4)
                                : Color.nmkPrimary.opacity(0.3),
                            radius: 12
                        )
                    
                    if voiceService.isProcessing {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                    } else {
                        Image(systemName: voiceService.isListening ? "stop.fill" : "mic.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(.white)
                    }
                }
            }
            .disabled(!hasPermission && !connection.isDemoMode)
            .opacity((hasPermission || connection.isDemoMode) ? 1.0 : 0.5)
            
            // الحالة
            Text(statusText)
                .font(NMKFont.headline())
                .foregroundStyle(.nmkTextPrimary)
            
            // النص المحول
            if !voiceService.transcribedText.isEmpty {
                Text("\"\(voiceService.transcribedText)\"")
                    .font(NMKFont.subheadline())
                    .foregroundStyle(.nmkTextSecondary)
                    .italic()
                    .padding(.horizontal)
            }
            
            // تنبيه الصلاحيات
            if !hasPermission && !connection.isDemoMode {
                VStack(spacing: 8) {
                    Image(systemName: "mic.slash.fill")
                        .font(.title2)
                        .foregroundStyle(.nmkWarning)
                    Text("يحتاج التطبيق لإذن الميكروفون والتعرف على الكلام")
                        .font(NMKFont.caption())
                        .foregroundStyle(.nmkTextSecondary)
                        .multilineTextAlignment(.center)
                    Button("منح الصلاحيات") {
                        voiceService.requestPermissions { granted in
                            hasPermission = granted
                        }
                    }
                    .foregroundStyle(.nmkPrimary)
                    .font(NMKFont.subheadline())
                }
                .padding()
            }
            
            if !connection.isConnected && !connection.isDemoMode {
                Text("يجب الاتصال بجهاز القائد الآلي أولاً")
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkDanger)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
    
    private var statusText: String {
        if voiceService.isProcessing { return "يعالج الأمر..." }
        if voiceService.isListening { return "يستمع..." }
        if !hasPermission && !connection.isDemoMode { return "اضغط لمنح الصلاحيات" }
        return "اضغط للتحدث"
    }
    
    // MARK: - الرد
    
    private var responseCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: voiceService.commandHistory.first?.success == true
                      ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(voiceService.commandHistory.first?.success == true
                                     ? .nmkSuccess : .nmkDanger)
                Text("النتيجة")
                    .font(NMKFont.headline())
                    .foregroundStyle(.nmkTextPrimary)
            }
            
            Text(voiceService.lastResponse)
                .font(NMKFont.body())
                .foregroundStyle(.nmkTextSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }
    
    // MARK: - الأوامر السريعة
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            NMKSectionHeader("أوامر سريعة")
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                voiceQuickButton(icon: "snowflake", title: "تشغيل المكيف", color: .cyan) {
                    voiceService.processCommand("شغل المكيف")
                }
                voiceQuickButton(icon: "thermometer", title: "حرارة 22°", color: .orange) {
                    voiceService.processCommand("اعتدل الحرارة لـ 22")
                }
                voiceQuickButton(icon: "window.casement", title: "فتح النوافذ", color: .blue) {
                    voiceService.processCommand("افتح النوافذ")
                }
                voiceQuickButton(icon: "window.casement.closed", title: "إغلاق النوافذ", color: .indigo) {
                    voiceService.processCommand("أغلق النوافذ")
                }
                voiceQuickButton(icon: "lock.fill", title: "قفل الأبواب", color: .gray) {
                    voiceService.processCommand("أقفل الأبواب")
                }
                voiceQuickButton(icon: "lock.open.fill", title: "فتح الأبواب", color: .teal) {
                    voiceService.processCommand("افتح الأبواب")
                }
                voiceQuickButton(icon: "flame", title: "تدفئة المقعد", color: .red) {
                    voiceService.processCommand("شغل تدفية المقعد")
                }
                voiceQuickButton(icon: "cloud.sleet", title: "إزالة الضباب", color: .mint) {
                    voiceService.processCommand("شغل ازالة الضباب")
                }
                voiceQuickButton(icon: "light.beacon.max", title: "الأضواء", color: .yellow) {
                    voiceService.processCommand("شغل الأضواء")
                }
                voiceQuickButton(icon: "car.lane.rear.right", title: "القيادة الذاتية", color: .nmkPrimary) {
                    voiceService.processCommand("فعّل القيادة الذاتية")
                }
            }
        }
    }
    
    private func voiceQuickButton(icon: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                Text(title)
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.nmkCard)
            .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
        }
        .buttonStyle(.plain)
        .disabled(voiceService.isProcessing)
        .opacity(voiceService.isProcessing ? 0.5 : 1.0)
    }
    
    // MARK: - حالة المركبة
    
    private var vehicleStateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            NMKSectionHeader("حالة المركبة")
            
            VStack(spacing: 8) {
                stateRow(label: "الحرارة الخارجية", value: "35°", icon: "thermometer.sun")
                stateRow(label: "نسبة الوقود", value: "75%", icon: "fuelpump")
                stateRow(label: "الأبواب", value: "مقفولة", icon: "lock.fill")
                stateRow(label: "النوافذ", value: "مغلقة", icon: "window.casement.closed")
                stateRow(label: "المكيف", value: "مطفأ", icon: "snowflake.slash")
            }
        }
        .padding(16)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }
    
    private func stateRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.nmkPrimary)
                .frame(width: 24)
            Text(label)
                .font(NMKFont.body())
                .foregroundStyle(.nmkTextSecondary)
            Spacer()
            Text(value)
                .font(NMKFont.headline())
                .foregroundStyle(.nmkTextPrimary)
        }
    }
    
    // MARK: - السجل
    
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            NMKSectionHeader("آخر الأوامر")
            
            ForEach(voiceService.commandHistory.prefix(5)) { entry in
                HStack(spacing: 10) {
                    Image(systemName: entry.success ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(entry.success ? .nmkSuccess : .nmkDanger)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(entry.command)
                            .font(NMKFont.body())
                            .foregroundStyle(.nmkTextPrimary)
                        Text(entry.feedback)
                            .font(NMKFont.caption())
                            .foregroundStyle(.nmkTextSecondary)
                    }
                    
                    Spacer()
                    
                    Text(entry.timestamp, style: .relative)
                        .font(NMKFont.caption())
                        .foregroundStyle(.nmkTextTertiary)
                }
                .padding(.vertical, 6)
            }
        }
        .padding(16)
        .background(Color.nmkCard)
        .clipShape(RoundedRectangle(cornerRadius: NMKMetrics.cornerRadius))
    }
}

// MARK: - قائمة الأوامر

struct VoiceCommandsListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("التكييف — HVAC") {
                    cmdRow(ar: "اعتدل الحرارة لـ 22", en: "set temperature to 22", icon: "thermometer")
                    cmdRow(ar: "شغل المكيف", en: "turn on AC", icon: "snowflake")
                    cmdRow(ar: "طفي المكيف", en: "turn off AC", icon: "snowflake.slash")
                    cmdRow(ar: "زد سرعة المروحة", en: "increase fan speed", icon: "wind")
                    cmdRow(ar: "شغل تدفية المقعد", en: "turn on seat heater", icon: "flame")
                    cmdRow(ar: "شغل ازالة الضباب", en: "turn on defrost", icon: "cloud.sleet")
                }
                
                Section("النوافذ — Windows") {
                    cmdRow(ar: "افتح النوافذ", en: "open windows", icon: "window.casement")
                    cmdRow(ar: "أغلق النوافذ", en: "close windows", icon: "window.casement.closed")
                }
                
                Section("الأبواب — Doors") {
                    cmdRow(ar: "أقفل الأبواب", en: "lock doors", icon: "lock.fill")
                    cmdRow(ar: "افتح الأبواب", en: "unlock doors", icon: "lock.open.fill")
                    cmdRow(ar: "افتح الصندوق", en: "open trunk", icon: "shippingbox")
                }
                
                Section("الإضاءة — Lights") {
                    cmdRow(ar: "شغل الأضواء", en: "turn on headlights", icon: "light.beacon.max")
                    cmdRow(ar: "طفي الأضواء", en: "turn off headlights", icon: "light.beacon")
                    cmdRow(ar: "شغل الأنوار الداخلية", en: "interior lights on", icon: "house.fill")
                }
                
                Section("المرايا — Mirrors") {
                    cmdRow(ar: "اطوي المرايا", en: "fold mirrors", icon: "rectangle.split.2x1")
                }
                
                Section("القيادة الذاتية — ADAS") {
                    cmdRow(ar: "فعّل القيادة الذاتية", en: "enable autopilot", icon: "car.lane.rear.right")
                    cmdRow(ar: "أوقف القيادة الذاتية", en: "disable autopilot", icon: "hand.raised")
                }
                
                Section("استعلامات — Info") {
                    cmdRow(ar: "كم الحرارة خارج", en: "what's the temperature", icon: "thermometer.sun")
                    cmdRow(ar: "كم البنزين الباقي", en: "how much fuel left", icon: "fuelpump")
                    cmdRow(ar: "كم سرعتي", en: "what's my speed", icon: "speedometer")
                }
            }
            .navigationTitle("قائمة الأوامر")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func cmdRow(ar: String, en: String, icon: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.nmkPrimary)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(ar)
                    .font(NMKFont.body())
                    .foregroundStyle(.nmkTextPrimary)
                Text(en)
                    .font(NMKFont.caption())
                    .foregroundStyle(.nmkTextSecondary)
            }
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Preview

#Preview {
    VoiceControlView()
        .environmentObject(DeviceConnectionService())
}
