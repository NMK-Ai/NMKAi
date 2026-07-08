//
//  VoiceAssistantService.swift
//  NMKAi — القائد الآلي
//
//  خدمة المساعد الصوتي — Speech Recognition + Command Processing
//  تستخدم iOS SFSpeechRecognizer للتعرف على الكلام العربي والإنجليزي
//  وترسل الأوامر لجهاز القائد الآلي عبر REST API
//
//  Author: NMK-Ai
//

import Foundation
import Speech
import AVFoundation
import Combine

@Observable
final class VoiceAssistantService: NSObject {
    
    // MARK: - الحالة
    
    /// هل يستمع الآن
    var isListening: Bool = false
    
    /// هل المساعد نشط (تفعيل من المستخدم)
    var isEnabled: Bool = false
    
    /// النص المحول (STT)
    var transcribedText: String = ""
    
    /// آخر رد من النظام
    var lastResponse: String = ""
    
    /// هل يتعالج أمر الآن
    var isProcessing: Bool = false
    
    /// سجل الأوامر
    var commandHistory: [VoiceCommandEntry] = []
    
    /// حالة المركبة الحالية
    var vehicleState: VehicleState?
    
    /// كلمة التنشيط مفعّلة
    var wakeWordEnabled: Bool = true
    
    /// اللغة
    var language: String = "ar-SA"
    
    // MARK: - Private
    
    private let speechRecognizer: SFSpeechRecognizer
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    /// جهاز القائد الآلي
    weak var deviceService: DeviceConnectionService?
    
    // MARK: - Init
    
    override init() {
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA")) ?? SFSpeechRecognizer()!
        super.init()
        speechRecognizer.delegate = self
    }
    
    // MARK: - الصلاحيات
    
    func requestPermissions(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { speechStatus in
            AVAudioApplication.requestRecordPermission { micStatus in
                DispatchQueue.main.async {
                    let granted = (speechStatus == .authorized) && micStatus
                    self.isEnabled = granted
                    completion(granted)
                }
            }
        }
    }
    
    // MARK: - بدء/إيقاف الاستماع
    
    func startListening() {
        guard !isListening else { return }
        guard speechRecognizer.isAvailable else {
            lastResponse = "التعرف على الكلام غير متاح"
            return
        }
        
        // إلغاء أي مهمة سابقة
        cancelRecognition()
        
        // إعداد جلسة الصوت
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            lastResponse = "خطأ في الميكروفون: \(error.localizedDescription)"
            return
        }
        
        // إعداد طلب التعرف
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }
        recognitionRequest.shouldReportPartialResults = true
        
        // إعداد محرك الصوت
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            lastResponse = "خطأ في محرك الصوت"
            return
        }
        
        // بدء مهمة التعرف
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let text = result.bestTranscription.formattedString
                DispatchQueue.main.async {
                    self.transcribedText = text
                    
                    // إذا كان النتيجة نهائية، عالج الأمر
                    if result.isFinal {
                        self.processCommand(text)
                    }
                }
            }
            
            if error != nil || (result?.isFinal ?? false) {
                DispatchQueue.main.async {
                    self.stopListening()
                }
            }
        }
        
        isListening = true
        transcribedText = ""
    }
    
    func stopListening() {
        guard isListening else { return }
        
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        isListening = false
        
        // معالجة آخر نص تم التعرف عليه
        if !transcribedText.isEmpty {
            processCommand(transcribedText)
        }
    }
    
    func toggleListening() {
        if isListening {
            stopListening()
        } else {
            startListening()
        }
    }
    
    // MARK: - معالجة الأوامر
    
    /// معالجة نص وتحويله لأمر
    func processCommand(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        isProcessing = true
        
        // تحليل الأمر
        let parsed = parseCommand(trimmed)
        
        guard !parsed.intent.isEmpty else {
            lastResponse = "ما فهمت الأمر، ممكن تعيد؟"
            isProcessing = false
            return
        }
        
        // إرسال للجهاز
        sendCommandToVehicle(parsed) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isProcessing = false
                
                if result.success {
                    self.lastResponse = result.feedback
                } else {
                    self.lastResponse = "تعذر تنفيذ الأمر: \(result.reason)"
                }
                
                self.commandHistory.insert(
                    VoiceCommandEntry(
                        command: trimmed,
                        intent: parsed.intent,
                        success: result.success,
                        feedback: result.feedback,
                        timestamp: Date()
                    ),
                    at: 0
                )
                
                // الاحتفاظ بآخر 20 أمر فقط
                if self.commandHistory.count > 20 {
                    self.commandHistory.removeLast()
                }
            }
        }
    }
    
    // MARK: - تحليل الأوامر (NLU)
    
    private func parseCommand(_ text: String) -> ParsedCommand {
        let lower = text.lowercased()
        
        // ═══ HVAC — التكييف ═══
        
        if let temp = extractNumber(from: text) {
            if matches(any: ["حرارة", "درجة", "temp", "temperature"], in: lower) {
                return ParsedCommand(intent: "SET_TEMPERATURE", params: ["value": temp], confidence: 0.95)
            }
        }
        
        if matches(any: ["شغل المكيف", "شغل التكييف", "turn on ac", "enable ac", "cool"], in: lower) {
            return ParsedCommand(intent: "AC_ON", params: [:], confidence: 0.95)
        }
        
        if matches(any: ["طفي المكيف", "اطفي المكيف", "turn off ac", "disable ac"], in: lower) {
            return ParsedCommand(intent: "AC_OFF", params: [:], confidence: 0.95)
        }
        
        if matches(any: ["زيد المروحة", "زد سرعة المروحة", "زود المروحة", "increase fan", "fan up"], in: lower) {
            return ParsedCommand(intent: "FAN_UP", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["قلل المروحة", "قلل سرعة المروحة", "نقص المروحة", "decrease fan", "fan down"], in: lower) {
            return ParsedCommand(intent: "FAN_DOWN", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["تدفية المقعد", "تدفئة المقعد", "seat heat", "seat warmer"], in: lower) {
            return ParsedCommand(intent: "SEAT_HEAT_ON", params: ["level": 1], confidence: 0.90)
        }
        
        if matches(any: ["طفي تدفية", "اطفي تدفية", "turn off seat"], in: lower) {
            return ParsedCommand(intent: "SEAT_HEAT_OFF", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["ازالة الضباب", "إزالة الضباب", "defrost", "degog"], in: lower) {
            return ParsedCommand(intent: "DEFROST_ON", params: [:], confidence: 0.90)
        }
        
        // ═══ النوافذ ═══
        
        if matches(any: ["افتح النوافذ", "افتح الشباك", "open window", "roll down"], in: lower) {
            return ParsedCommand(intent: "WINDOW_OPEN", params: ["window": "ALL"], confidence: 0.95)
        }
        
        if matches(any: ["اغلق النوافذ", "أغلق النوافذ", "اقفل الشباك", "close window", "roll up"], in: lower) {
            return ParsedCommand(intent: "WINDOW_CLOSE", params: ["window": "ALL"], confidence: 0.95)
        }
        
        // ═══ الأبواب ═══
        
        if matches(any: ["اقفل الابواب", "أقفل الأبواب", "اقفل السيارة", "lock door", "lock car"], in: lower) {
            return ParsedCommand(intent: "DOORS_LOCK", params: [:], confidence: 0.95)
        }
        
        if matches(any: ["افتح الابواب", "افتح الأبواب", "unlock door"], in: lower) {
            return ParsedCommand(intent: "DOORS_UNLOCK", params: [:], confidence: 0.95)
        }
        
        if matches(any: ["افتح الصندوق", "افتح الخلف", "open trunk"], in: lower) {
            return ParsedCommand(intent: "TRUNK_OPEN", params: [:], confidence: 0.90)
        }
        
        // ═══ الإضاءة ═══
        
        if matches(any: ["شغل الانوار", "شغل الأنوار", "شغل الاضواء", "شغل الأضواء", "turn on light", "headlight"], in: lower) {
            return ParsedCommand(intent: "HEADLIGHTS_ON", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["طفي الانوار", "طفي الأضواء", "turn off light"], in: lower) {
            return ParsedCommand(intent: "HEADLIGHTS_OFF", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["الانوار الداخلية", "الأنوار الداخلية", "interior light"], in: lower) {
            return matches(any: ["شغل"], in: lower)
                ? ParsedCommand(intent: "INTERIOR_LIGHT_ON", params: [:], confidence: 0.85)
                : ParsedCommand(intent: "INTERIOR_LIGHT_OFF", params: [:], confidence: 0.85)
        }
        
        // ═══ المرايا ═══
        
        if matches(any: ["اطوي المرايا", "طوي المرايا", "fold mirror"], in: lower) {
            return ParsedCommand(intent: "MIRROR_FOLD", params: [:], confidence: 0.90)
        }
        
        // ═══ القيادة الذاتية ═══
        
        if matches(any: ["فعل القيادة", "فعّل القيادة", "شغل القيادة الذاتية", "enable autopilot", "activate openpilot"], in: lower) {
            return ParsedCommand(intent: "OPENPILOT_ENABLE", params: [:], confidence: 0.90)
        }
        
        if matches(any: ["وقف القيادة", "أوقف القيادة", "طفي القيادة الذاتية", "disable autopilot"], in: lower) {
            return ParsedCommand(intent: "OPENPILOT_DISABLE", params: [:], confidence: 0.90)
        }
        
        // ═══ استعلامات ═══
        
        if matches(any: ["كم الحرارة", "كم درجة الحرارة", "temperature outside"], in: lower) {
            return ParsedCommand(intent: "QUERY_OUTSIDE_TEMP", params: [:], confidence: 0.85)
        }
        
        if matches(any: ["كم البنزين", "كم الوقود", "how much fuel", "gas level"], in: lower) {
            return ParsedCommand(intent: "QUERY_FUEL_LEVEL", params: [:], confidence: 0.85)
        }
        
        if matches(any: ["كم السرعة", "كم سرعتي", "what speed"], in: lower) {
            return ParsedCommand(intent: "QUERY_SPEED", params: [:], confidence: 0.85)
        }
        
        return ParsedCommand(intent: "", params: [:], confidence: 0)
    }
    
    // MARK: - إرسال للجهاز
    
    private func sendCommandToVehicle(_ command: ParsedCommand, completion: @escaping (CommandResult) -> Void) {
        guard let deviceService = deviceService, deviceService.isConnected else {
            // وضع تجريبي — نرد مباشرة
            let feedback = feedbackMessage(for: command.intent)
            completion(CommandResult(success: true, feedback: feedback, reason: ""))
            return
        }
        
        guard let url = URL(string: "\(deviceService.baseURL)/api/voice/command") else {
            completion(CommandResult(success: false, feedback: "", reason: "invalid_url"))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 5
        
        let body: [String: Any] = [
            "intent": command.intent,
            "params": command.params,
            "language": language.hasPrefix("ar") ? "ar" : "en",
            "source": "nmkai_ios"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(CommandResult(success: false, feedback: "", reason: error.localizedDescription))
                return
            }
            
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let success = json["success"] as? Bool ?? false
                let feedback = json["feedback"] as? String ?? (success ? "تم" : "فشل")
                let reason = json["reason"] as? String ?? ""
                completion(CommandResult(success: success, feedback: feedback, reason: reason))
            } else {
                completion(CommandResult(success: false, feedback: "", reason: "no_response"))
            }
        }.resume()
    }
    
    // MARK: - Helpers
    
    private func cancelRecognition() {
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest = nil
        
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    private func matches(any keywords: [String], in text: String) -> Bool {
        keywords.contains { text.contains($0) }
    }
    
    private func extractNumber(from text: String) -> Int? {
        let pattern = "\\d+"
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
           let range = Range(match.range, in: text) {
            return Int(text[range])
        }
        // Arabic numbers
        let arabicDigits: [Character: Int] = ["٠":0,"١":1,"٢":2,"٣":3,"٤":4,"٥":5,"٦":6,"٧":7,"٨":8,"٩":9]
        var numStr = ""
        for ch in text {
            if let d = arabicDigits[ch] { numStr.append(String(d)) }
        }
        return numStr.isEmpty ? nil : Int(numStr)
    }
    
    private func feedbackMessage(for intent: String) -> String {
        let messages: [String: String] = [
            "SET_TEMPERATURE": "تم ضبط الحرارة",
            "AC_ON": "تم تشغيل المكيف",
            "AC_OFF": "تم إيقاف المكيف",
            "FAN_UP": "تمت زيادة سرعة المروحة",
            "FAN_DOWN": "تم تقليل سرعة المروحة",
            "SEAT_HEAT_ON": "تم تشغيل تدفئة المقعد",
            "SEAT_HEAT_OFF": "تم إيقاف تدفئة المقعد",
            "DEFROST_ON": "تم تشغيل إزالة الضباب",
            "WINDOW_OPEN": "تم فتح النوافذ",
            "WINDOW_CLOSE": "تم إغلاق النوافذ",
            "DOORS_LOCK": "تم قفل الأبواب",
            "DOORS_UNLOCK": "تم فتح الأبواب",
            "TRUNK_OPEN": "تم فتح الصندوق",
            "HEADLIGHTS_ON": "تم تشغيل الأضواء",
            "HEADLIGHTS_OFF": "تم إيقاف الأضواء",
            "INTERIOR_LIGHT_ON": "تم تشغيل الأنوار الداخلية",
            "INTERIOR_LIGHT_OFF": "تم إيقاف الأنوار الداخلية",
            "MIRROR_FOLD": "تم طي المرايا",
            "OPENPILOT_ENABLE": "تم تفعيل القيادة الذاتية",
            "OPENPILOT_DISABLE": "تم إيقاف القيادة الذاتية",
            "QUERY_OUTSIDE_TEMP": "الحرارة الخارجية 35°",
            "QUERY_FUEL_LEVEL": "نسبة الوقود 75%",
            "QUERY_SPEED": "السرعة الحالية 0 كم/س",
        ]
        return messages[intent] ?? "تم"
    }
}

// MARK: - SFSpeechRecognizerDelegate

extension VoiceAssistantService: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if !available {
            DispatchQueue.main.async {
                self.stopListening()
                self.lastResponse = "التعرف على الكلام غير متاح حالياً"
            }
        }
    }
}

// MARK: - Data Models

struct ParsedCommand {
    let intent: String
    let params: [String: Any]
    let confidence: Double
}

struct CommandResult {
    let success: Bool
    let feedback: String
    let reason: String
}

struct VoiceCommandEntry: Identifiable {
    let id = UUID()
    let command: String
    let intent: String
    let success: Bool
    let feedback: String
    let timestamp: Date
}

struct VehicleState: Codable {
    var speedKmh: Double = 0
    var engineRunning: Bool = false
    var doorsLocked: Bool = true
    var windowsClosed: Bool = true
    var acOn: Bool = false
    var interiorTemp: Double = 22
    var outsideTemp: Double = 35
    var fuelPercent: Double = 75
}
