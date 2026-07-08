//
//  VehiclePlatform.swift
//  NMKAi — القائد الآلي
//
//  نموذج منصات المركبات المدعومة للتحكم الصوتي
//  Vehicle platform support model for voice control
//
//  Author: NMK-Ai (نويكل 🧬)
//

import Foundation

// MARK: - Supported Vehicle Platform

struct VehiclePlatform: Identifiable, Codable, Equatable {
    let id: String           // e.g. "hyundai_canfd"
    let name: String         // Display name
    let platformKey: String  // Internal key
    let canType: String      // "CAN FD" or "CAN 2.0"
    let signalCount: Int     // Number of CAN signals mapped
    let brandExamples: [String]
    let isFullySupported: Bool

    var icon: String {
        switch platformKey {
        case "hyundai_canfd", "hyundai_can20":
            return "car.fill"
        case "toyota_tnga":
            return "car.2.fill"
        case "honda":
            return "car.circle.fill"
        case "tesla":
            return "bolt.car.fill"
        case "ford":
            return "car.rear.fill"
        case "mazda":
            return "sportscarcircle.fill"
        default:
            return "car.fill"
        }
    }

    var supportBadgeColor: String {
        if isFullySupported { return "green" }
        return "orange"
    }
}

// MARK: - Voice Command Info

struct VoiceCommandInfo: Identifiable, Codable, Equatable {
    let id: String
    let intent: String
    let categoryAr: String
    let categoryEn: String
    let riskLevel: String
    let arExample: String
    let enExample: String
    let icon: String

    static let allCommands: [VoiceCommandInfo] = [
        // HVAC
        .init(id: "1", intent: "SET_TEMPERATURE", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "اعتدل الحرارة لـ 22", enExample: "set temperature to 22", icon: "thermometer"),
        .init(id: "2", intent: "AC_ON", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "شغل المكيف", enExample: "turn on AC", icon: "snowflake"),
        .init(id: "3", intent: "AC_OFF", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "طفي المكيف", enExample: "turn off AC", icon: "snowflake.slash"),
        .init(id: "4", intent: "FAN_UP", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "زد سرعة المروحة", enExample: "increase fan speed", icon: "wind"),
        .init(id: "5", intent: "FAN_DOWN", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "قلل سرعة المروحة", enExample: "decrease fan", icon: "wind.slash"),
        .init(id: "6", intent: "DEFROST_ON", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "شغل ازالة الضباب", enExample: "turn on defrost", icon: "cloud.sleet"),
        .init(id: "7", intent: "SEAT_HEAT_ON", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "شغل تدفية المقعد", enExample: "turn on seat heater", icon: "flame"),
        .init(id: "8", intent: "SEAT_HEAT_OFF", categoryAr: "التكييف", categoryEn: "HVAC", riskLevel: "منخفض", arExample: "طفي تدفية المقعد", enExample: "turn off seat heater", icon: "flame.fill"),

        // Windows & Doors
        .init(id: "9", intent: "WINDOW_OPEN", categoryAr: "النوافذ", categoryEn: "Windows", riskLevel: "متوسط", arExample: "افتح النوافذ", enExample: "open windows", icon: "window.casement"),
        .init(id: "10", intent: "WINDOW_CLOSE", categoryAr: "النوافذ", categoryEn: "Windows", riskLevel: "متوسط", arExample: "أغلق النوافذ", enExample: "close windows", icon: "window.casement.closed"),
        .init(id: "11", intent: "DOORS_LOCK", categoryAr: "الأبواب", categoryEn: "Doors", riskLevel: "متوسط", arExample: "أقفل الأبواب", enExample: "lock doors", icon: "lock.fill"),
        .init(id: "12", intent: "DOORS_UNLOCK", categoryAr: "الأبواب", categoryEn: "Doors", riskLevel: "متوسط", arExample: "افتح الأبواب", enExample: "unlock doors", icon: "lock.open.fill"),
        .init(id: "13", intent: "TRUNK_OPEN", categoryAr: "الأبواب", categoryEn: "Doors", riskLevel: "متوسط", arExample: "افتح الصندوق", enExample: "open trunk", icon: "shippingbox"),

        // Lights & Mirrors
        .init(id: "14", intent: "HEADLIGHTS_ON", categoryAr: "الإضاءة", categoryEn: "Lights", riskLevel: "منخفض", arExample: "شغل الأضواء", enExample: "turn on headlights", icon: "light.beacon.max"),
        .init(id: "15", intent: "HEADLIGHTS_OFF", categoryAr: "الإضاءة", categoryEn: "Lights", riskLevel: "منخفض", arExample: "طفي الأضواء", enExample: "turn off headlights", icon: "light.beacon"),
        .init(id: "16", intent: "INTERIOR_LIGHT_ON", categoryAr: "الإضاءة", categoryEn: "Lights", riskLevel: "منخفض", arExample: "شغل الأنوار الداخلية", enExample: "interior lights on", icon: "house.fill"),
        .init(id: "17", intent: "MIRROR_FOLD", categoryAr: "المرايا", categoryEn: "Mirrors", riskLevel: "منخفض", arExample: "اطوي المرايا", enExample: "fold mirrors", icon: "rectangle.split.2x1"),

        // ADAS
        .init(id: "18", intent: "OPENPILOT_ENABLE", categoryAr: "القيادة الذاتية", categoryEn: "ADAS", riskLevel: "عالي", arExample: "فعّل القيادة الذاتية", enExample: "enable autopilot", icon: "car.lane.rear.right"),
        .init(id: "19", intent: "OPENPILOT_DISABLE", categoryAr: "القيادة الذاتية", categoryEn: "ADAS", riskLevel: "عالي", arExample: "أوقف القيادة الذاتية", enExample: "disable autopilot", icon: "hand.raised"),

        // Navigation
        .init(id: "20", intent: "NAVIGATE_TO", categoryAr: "التنقل", categoryEn: "Navigation", riskLevel: "منخفض", arExample: "روح الى الرياض", enExample: "navigate to Riyadh", icon: "location.navigated"),

        // Info
        .init(id: "21", intent: "QUERY_OUTSIDE_TEMP", categoryAr: "استعلامات", categoryEn: "Info", riskLevel: "عام", arExample: "كم الحرارة خارج", enExample: "what's the temperature", icon: "thermometer.sun"),
        .init(id: "22", intent: "QUERY_FUEL_LEVEL", categoryAr: "استعلامات", categoryEn: "Info", riskLevel: "عام", arExample: "كم البنزين الباقي", enExample: "how much fuel left", icon: "fuelpump"),
        .init(id: "23", intent: "QUERY_SPEED", categoryAr: "استعلامات", categoryEn: "Info", riskLevel: "عام", arExample: "كم سرعتي", enExample: "what's my speed", icon: "speedometer"),
    ]
}

// MARK: - Supported Platforms List

struct VehiclePlatformStore {
    static let supported: [VehiclePlatform] = [
        VehiclePlatform(id: "1", name: "Hyundai/Kia/Genesis (CAN FD)", platformKey: "hyundai_canfd",
                        canType: "CAN FD", signalCount: 9,
                        brandExamples: ["Hyundai Elantra CN7", "Sonata DN8", "Santa Fe TM5", "Kia K5", "Genesis GV70"],
                        isFullySupported: true),

        VehiclePlatform(id: "2", name: "Hyundai/Kia (CAN 2.0)", platformKey: "hyundai_can20",
                        canType: "CAN 2.0", signalCount: 2,
                        brandExamples: ["Hyundai Elantra (pre-2020)", "Kia Cerato", "Hyundai Tucson"],
                        isFullySupported: false),

        VehiclePlatform(id: "3", name: "Toyota/Lexus (TNGA)", platformKey: "toyota_tnga",
                        canType: "CAN 2.0", signalCount: 5,
                        brandExamples: ["Toyota Camry", "Corolla", "RAV4", "Highlander", "Lexus ES"],
                        isFullySupported: true),

        VehiclePlatform(id: "4", name: "Honda/Acura", platformKey: "honda",
                        canType: "CAN 2.0", signalCount: 3,
                        brandExamples: ["Honda Civic", "Accord", "CR-V", "Fit", "Acura RDX"],
                        isFullySupported: false),

        VehiclePlatform(id: "5", name: "Ford/Lincoln", platformKey: "ford",
                        canType: "CAN 2.0", signalCount: 2,
                        brandExamples: ["Ford Focus", "Fusion", "Escape", "F-150", "Lincoln MKZ"],
                        isFullySupported: false),

        VehiclePlatform(id: "6", name: "Mazda", platformKey: "mazda",
                        canType: "CAN 2.0", signalCount: 2,
                        brandExamples: ["Mazda 3", "Mazda 6", "CX-5", "CX-9"],
                        isFullySupported: false),

        VehiclePlatform(id: "7", name: "Tesla", platformKey: "tesla",
                        canType: "CAN 2.0", signalCount: 2,
                        brandExamples: ["Tesla Model S", "Model 3", "Model X", "Model Y"],
                        isFullySupported: false),
    ]

    /// Detect platform from car fingerprint string
    static func detect(fingerprint: String) -> VehiclePlatform? {
        let fp = fingerprint.uppercased()

        if fp.contains("HYUNDAI") || fp.contains("KIA") || fp.contains("GENESIS") {
            if fp.contains("CANFD") || fp.contains("CN7") || fp.contains("DN8") || fp.contains("TM5") {
                return supported[0] // hyundai_canfd
            }
            return supported[1] // hyundai_can20
        }
        if fp.contains("TOYOTA") || fp.contains("LEXUS") {
            return supported[2] // toyota_tnga
        }
        if fp.contains("HONDA") || fp.contains("ACURA") {
            return supported[3] // honda
        }
        if fp.contains("FORD") || fp.contains("LINCOLN") {
            return supported[4] // ford
        }
        if fp.contains("MAZDA") {
            return supported[5] // mazda
        }
        if fp.contains("TESLA") {
            return supported[6] // tesla
        }

        // Default to Hyundai CAN FD (most common in Gulf)
        return supported[0]
    }

    /// Total supported vehicle count (from openpilot fingerprints)
    static let totalSupportedVehicles = 332

    /// Total brands
    static let totalBrands = 15
}
