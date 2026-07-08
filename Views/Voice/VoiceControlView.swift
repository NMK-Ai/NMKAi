//
//  VoiceControlView.swift
//  NMKAi — القائد الآلي
//
//  واجهة التحكم الصوتي بالمركبة
//  Voice Control View for Vehicle Functions
//
//  Author: NMK-Ai (نويكل 🧬)
//  Version: 0.1.0
//

import SwiftUI

// MARK: - Voice Control View

struct VoiceControlView: View {
    @EnvironmentObject var connection: DeviceConnectionService
    
    @State private var isListening = false
    @State private var transcribedText = ""
    @State private var lastResponse = ""
    @State private var commandHistory: [VoiceCommandEntry] = []
    @State private var showCommandList = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // MARK: - Voice Button
                    voiceButtonSection
                    
                    // MARK: - Last Response
                    if !lastResponse.isEmpty {
                        responseCard
                    }
                    
                    // MARK: - Quick Actions
                    quickActionsSection
                    
                    // MARK: - Vehicle State
                    vehicleStateSection
                    
                    // MARK: - Command History
                    if !commandHistory.isEmpty {
                        historySection
                    }
                }
                .padding()
            }
            .background(NMKTheme.background)
            .navigationTitle("التحكم الصوتي")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showCommandList = true }) {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundStyle(NMKTheme.primary)
                    }
                }
            }
            .sheet(isPresented: $showCommandList) {
                VoiceCommandsListView()
            }
            .task {
                await fetchVehicleState()
            }
        }
    }
    
    // MARK: - Voice Button Section
    
    private var voiceButtonSection: some View {
        VStack(spacing: 16) {
            Button(action: toggleListening) {
                ZStack {
                    Circle()
                        .fill(isListening ? NMKTheme.danger : NMKTheme.primary)
                        .frame(width: 120, height: 120)
                        .shadow(color: isListening ? NMKTheme.danger.opacity(0.4) : NMKTheme.primary.opacity(0.3), radius: 12)
                    
                    if isListening {
                        // Animated rings
                        ForEach(0..<3) { i in
                            Circle()
                                .stroke(NMKTheme.primary.opacity(0.3), lineWidth: 2)
                                .frame(width: 120 + CGFloat(i * 30), height: 120 + CGFloat(i * 30))
                                .scaleEffect(isListening ? 1.2 : 1.0)
                                .opacity(isListening ? 0 : 0.5)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                        .repeatForever(autoreverses: false)
                                        .delay(Double(i) * 0.3),
                                    value: isListening
                                )
                        }
                    }
                    
                    Image(systemName: isListening ? "stop.fill" : "mic.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                }
            }
            .disabled(!connection.isConnected)
            .opacity(connection.isConnected ? 1.0 : 0.5)
            
            Text(isListening ? "يستمع..." : "اضغط للتحدث")
                .font(NMKTheme.title3)
                .foregroundStyle(NMKTheme.textPrimary)
            
            if !transcribedText.isEmpty {
                Text("\"\(transcribedText)\"")
                    .font(NMKTheme.body)
                    .foregroundStyle(NMKTheme.textSecondary)
                    .italic()
            }
            
            if !connection.isConnected {
                Text("يجب الاتصال بجهاز القائد الآلي أولاً")
                    .font(NMKTheme.caption)
                    .foregroundStyle(NMKTheme.danger)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
    
    // MARK: - Response Card
    
    private var responseCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(NMKTheme.success)
                Text("النتيجة")
                    .font(NMKTheme.title3)
                    .foregroundStyle(NMKTheme.textPrimary)
            }
            
            Text(lastResponse)
                .font(NMKTheme.body)
                .foregroundStyle(NMKTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(NMKTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    // MARK: - Quick Actions
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("أوامر سريعة")
                .font(NMKTheme.title3)
                .foregroundStyle(NMKTheme.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: 12) {
                quickActionButton(icon: "thermometer", title: "حرارة 22°", color: .orange) {
                    sendCommand("SET_TEMPERATURE", params: ["value": 22])
                }
                quickActionButton(icon: "snowflake", title: "تشغيل المكيف", color: .cyan) {
                    sendCommand("AC_ON")
                }
                quickActionButton(icon: "window.casement", title: "فتح النوافذ", color: .blue) {
                    sendCommand("WINDOW_OPEN")
                }
                quickActionButton(icon: "lock.fill", title: "قفل الأبواب", color: .gray) {
                    sendCommand("DOORS_LOCK")
                }
                quickActionButton(icon: "flame", title: "تدفئة المقعد", color: .red) {
                    sendCommand("SEAT_HEAT_ON")
                }
                quickActionButton(icon: "car.window.right", title: "إزالة الضباب", color: .teal) {
                    sendCommand("DEFROST_ON")
                }
            }
        }
    }
    
    private func quickActionButton(icon: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                Text(title)
                    .font(NMKTheme.caption)
                    .foregroundStyle(NMKTheme.textPrimary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(NMKTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(!connection.isConnected || isLoading)
    }
    
    // MARK: - Vehicle State
    
    @State private var vehicleState: VehicleState?
    
    private var vehicleStateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("حالة المركبة")
                .font(NMKTheme.title3)
                .foregroundStyle(NMKTheme.textPrimary)
            
            if let state = vehicleState {
                VStack(spacing: 8) {
                    stateRow(label: "السرعة", value: "\(Int(state.speedKmh)) كم/س", icon: "speedometer")
                    stateRow(label: "الحرارة الخارجية", value: "\(Int(state.outsideTemp))°", icon: "thermometer.sun")
                    stateRow(label: "نسبة الوقود", value: "\(Int(state.fuelPercent))%", icon: "fuelpump")
                    stateRow(label: "الأبواب", value: state.doorsLocked ? "مقفولة" : "مفتوحة", icon: "lock")
                    stateRow(label: "النوافذ", value: state.windowsClosed ? "مغلقة" : "مفتوحة", icon: "window.casement")
                }
            } else {
                Text("جاري التحميل...")
                    .font(NMKTheme.body)
                    .foregroundStyle(NMKTheme.textSecondary)
            }
        }
        .padding(16)
        .background(NMKTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func stateRow(label: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(NMKTheme.primary)
                .frame(width: 24)
            Text(label)
                .font(NMKTheme.body)
                .foregroundStyle(NMKTheme.textSecondary)
            Spacer()
            Text(value)
                .font(NMKTheme.bodyBold)
                .foregroundStyle(NMKTheme.textPrimary)
        }
    }
    
    // MARK: - History
    
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("آخر الأوامر")
                .font(NMKTheme.title3)
                .foregroundStyle(NMKTheme.textPrimary)
            
            ForEach(commandHistory.prefix(5)) { entry in
                HStack {
                    Image(systemName: entry.success ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(entry.success ? NMKTheme.success : NMKTheme.danger)
                    Text(entry.command)
                        .font(NMKTheme.body)
                        .foregroundStyle(NMKTheme.textPrimary)
                    Spacer()
                    Text(entry.timestamp, style: .relative)
                        .font(NMKTheme.caption)
                        .foregroundStyle(NMKTheme.textSecondary)
                }
                .padding(.vertical, 4)
            }
        }
        .padding(16)
        .background(NMKTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    // MARK: - Actions
    
    private func toggleListening() {
        if isListening {
            isListening = false
            if !transcribedText.isEmpty {
                sendCommand("TEXT", params: ["text": transcribedText])
            }
        } else {
            isListening = true
            transcribedText = ""
            // In production: start Speech Recognition here
            // For now: simulate
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if isListening {
                    isListening = false
                    transcribedText = "اعتدل الحرارة لـ 22"
                }
            }
        }
    }
    
    private func sendCommand(_ intent: String, params: [String: Any] = [:]) {
        guard connection.isConnected else { return }
        
        isLoading = true
        
        // Build URL
        let urlString = "\(connection.baseURL)/api/voice/command"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "intent": intent,
            "params": params,
            "language": "ar",
            "source": "nmkai_ios"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                isLoading = false
                
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let success = json["success"] as? Bool ?? false
                    let feedback = json["feedback"] as? String ?? (success ? "تم" : "فشل")
                    
                    lastResponse = feedback
                    commandHistory.insert(VoiceCommandEntry(
                        command: intent,
                        success: success,
                        timestamp: Date()
                    ), at: 0)
                } else {
                    lastResponse = "تعذر الاتصال بالجهاز"
                }
            }
        }.resume()
    }
    
    private func fetchVehicleState() async {
        guard connection.isConnected else { return }
        
        let urlString = "\(connection.baseURL)/api/vehicle/state"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                DispatchQueue.main.async {
                    vehicleState = VehicleState(
                        speedKmh: json["speed_kmh"] as? Double ?? 0,
                        outsideTemp: json["outside_temp"] as? Double ?? 0,
                        fuelPercent: json["fuel_percent"] as? Double ?? 0,
                        doorsLocked: json["doors_locked"] as? Bool ?? true,
                        windowsClosed: json["windows_closed"] as? Bool ?? true
                    )
                }
            }
        }.resume()
    }
}

// MARK: - Data Models

struct VehicleState {
    let speedKmh: Double
    let outsideTemp: Double
    let fuelPercent: Double
    let doorsLocked: Bool
    let windowsClosed: Bool
}

struct VoiceCommandEntry: Identifiable {
    let id = UUID()
    let command: String
    let success: Bool
    let timestamp: Date
}

// MARK: - Commands List View

struct VoiceCommandsListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("التكييف") {
                    commandRow(ar: "اعتدل الحرارة لـ 22", en: "set temperature to 22")
                    commandRow(ar: "شغل المكيف", en: "turn on AC")
                    commandRow(ar: "طفي المكيف", en: "turn off AC")
                    commandRow(ar: "زد سرعة المروحة", en: "increase fan")
                    commandRow(ar: "شغل تدفية المقعد", en: "turn on seat heater")
                    commandRow(ar: "إزالة الضباب", en: "defrost")
                }
                
                Section("النوافذ والأبواب") {
                    commandRow(ar: "افتح النوافذ", en: "open windows")
                    commandRow(ar: "أغلق النوافذ", en: "close windows")
                    commandRow(ar: "أقفل الأبواب", en: "lock doors")
                    commandRow(ar: "افتح الأبواب", en: "unlock doors")
                }
                
                Section("الإضاءة والمرايا") {
                    commandRow(ar: "شغل الأنوار الداخلية", en: "turn on interior lights")
                    commandRow(ar: "شغل الأضواء", en: "turn on headlights")
                    commandRow(ar: "اطوي المرايا", en: "fold mirrors")
                }
                
                Section("القيادة الذاتية") {
                    commandRow(ar: "فعّل القيادة الذاتية", en: "enable autopilot")
                    commandRow(ar: "أوقف القيادة الذاتية", en: "disable autopilot")
                    commandRow(ar: "اضبط السرعة على 120", en: "set speed to 120")
                }
                
                Section("استعلامات") {
                    commandRow(ar: "كم الحرارة خارج", en: "what's the temperature")
                    commandRow(ar: "كم البنزين الباقي", en: "how much fuel left")
                    commandRow(ar: "كم سرعتي", en: "what's my speed")
                    commandRow(ar: "كم ضغط الإطارات", en: "tire pressure")
                }
            }
            .navigationTitle("قائمة الأوامر")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func commandRow(ar: String, en: String) -> some View {
        VStack(alignment: .leading) {
            Text(ar)
                .font(.body)
                .foregroundStyle(.primary)
            Text(en)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Preview

#Preview {
    VoiceControlView()
        .environmentObject(DeviceConnectionService())
}
