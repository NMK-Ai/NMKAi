import SwiftUI

// MARK: - Data Models
struct Vehicle: Identifiable {
    let id = UUID()
    let make: String
    let makeAr: String
    let model: String
    let modelAr: String
    let package: String
    let longitudinal: String  // نعم / جزئي / لا
    let lateral: String       // نعم / جزئي / لا
    let minSpeed: String      // السرعة الدنيا للتحكم الجانبي (كم/س)
}

struct Brand: Identifiable {
    let id = UUID()
    let name: String
    let nameAr: String
    let vehicles: [Vehicle]
}

// MARK: - Vehicles Data (Updated from القائد الآلي - December 2025)
// 291 مركبة من 26 شركة
let vehiclesData: [Vehicle] = [
    // Acura - أكورا (6)
    Vehicle(make: "Acura", makeAr: "أكورا", model: "ILX 2016-18", modelAr: "آي إل إكس 2016-18", package: "AcuraWatch Plus", longitudinal: "نعم", lateral: "جزئي", minSpeed: "40"),
    Vehicle(make: "Acura", makeAr: "أكورا", model: "ILX 2019", modelAr: "آي إل إكس 2019", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "40"),
    Vehicle(make: "Acura", makeAr: "أكورا", model: "MDX 2025", modelAr: "إم دي إكس 2025", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Acura", makeAr: "أكورا", model: "RDX 2016-18", modelAr: "آر دي إكس 2016-18", package: "AcuraWatch Plus", longitudinal: "نعم", lateral: "جزئي", minSpeed: "19"),
    Vehicle(make: "Acura", makeAr: "أكورا", model: "RDX 2019-21", modelAr: "آر دي إكس 2019-21", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Acura", makeAr: "أكورا", model: "TLX 2021", modelAr: "تي إل إكس 2021", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Audi - أودي
    Vehicle(make: "Audi", makeAr: "أودي", model: "A3 2014-19", modelAr: "إيه 3 2014-19", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Audi", makeAr: "أودي", model: "A3 Sportback e-tron 2017-18", modelAr: "إيه 3 سبورتباك 2017-18", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Audi", makeAr: "أودي", model: "Q2 2018", modelAr: "كيو 2 2018", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Audi", makeAr: "أودي", model: "Q3 2019-24", modelAr: "كيو 3 2019-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Audi", makeAr: "أودي", model: "RS3 2018", modelAr: "آر إس 3 2018", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Audi", makeAr: "أودي", model: "S3 2015-17", modelAr: "إس 3 2015-17", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Chevrolet - شيفروليه
    Vehicle(make: "Chevrolet", makeAr: "شيفروليه", model: "Bolt EUV 2022-23", modelAr: "بولت EUV 2022-23", package: "Premier/LT", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    Vehicle(make: "Chevrolet", makeAr: "شيفروليه", model: "Bolt EV 2022-23", modelAr: "بولت EV 2022-23", package: "2LT Trim", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    Vehicle(make: "Chevrolet", makeAr: "شيفروليه", model: "Equinox 2019-22", modelAr: "إكوينوكس 2019-22", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    Vehicle(make: "Chevrolet", makeAr: "شيفروليه", model: "Silverado 1500 2020-21", modelAr: "سيلفرادو 1500 2020-21", package: "Safety II", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    Vehicle(make: "Chevrolet", makeAr: "شيفروليه", model: "Trailblazer 2021-22", modelAr: "تريل بليزر 2021-22", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    
    // Chrysler - كرايسلر
    Vehicle(make: "Chrysler", makeAr: "كرايسلر", model: "Pacifica 2017-18", modelAr: "باسيفيكا 2017-18", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "15"),
    Vehicle(make: "Chrysler", makeAr: "كرايسلر", model: "Pacifica 2019-23", modelAr: "باسيفيكا 2019-23", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "63"),
    Vehicle(make: "Chrysler", makeAr: "كرايسلر", model: "Pacifica Hybrid 2017-18", modelAr: "باسيفيكا هايبرد 2017-18", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "15"),
    Vehicle(make: "Chrysler", makeAr: "كرايسلر", model: "Pacifica Hybrid 2019-25", modelAr: "باسيفيكا هايبرد 2019-25", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "63"),
    
    // CUPRA - كوبرا
    Vehicle(make: "CUPRA", makeAr: "كوبرا", model: "Ateca 2018-23", modelAr: "أتيكا 2018-23", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Dodge - دودج
    Vehicle(make: "Dodge", makeAr: "دودج", model: "Durango 2020-21", modelAr: "دورانجو 2020-21", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "63"),
    
    // Ford - فورد (25 مركبة)
    Vehicle(make: "Ford", makeAr: "فورد", model: "Bronco Sport 2021-24", modelAr: "برونكو سبورت 2021-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape 2020-22", modelAr: "إسكيب 2020-22", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape 2023-24", modelAr: "إسكيب 2023-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape Hybrid 2020-22", modelAr: "إسكيب هايبرد 2020-22", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape Hybrid 2023-24", modelAr: "إسكيب هايبرد 2023-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape Plug-in Hybrid 2020-22", modelAr: "إسكيب بلج-إن 2020-22", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Escape Plug-in Hybrid 2023-24", modelAr: "إسكيب بلج-إن 2023-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Expedition 2022-24", modelAr: "إكسبيديشن 2022-24", package: "Co-Pilot360 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Explorer 2020-24", modelAr: "إكسبلورر 2020-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Explorer Hybrid 2020-24", modelAr: "إكسبلورر هايبرد 2020-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "F-150 2021-23", modelAr: "إف-150 2021-23", package: "Co-Pilot360 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "F-150 Hybrid 2021-23", modelAr: "إف-150 هايبرد 2021-23", package: "Co-Pilot360 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Focus 2018", modelAr: "فوكس 2018", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Kuga 2020-23", modelAr: "كوجا 2020-23", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Kuga Hybrid 2020-24", modelAr: "كوجا هايبرد 2020-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Kuga Plug-in Hybrid 2020-24", modelAr: "كوجا بلج-إن 2020-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Maverick 2022", modelAr: "مافريك 2022", package: "LARIAT Luxury", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Maverick 2023-24", modelAr: "مافريك 2023-24", package: "Co-Pilot360", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Maverick Hybrid 2022", modelAr: "مافريك هايبرد 2022", package: "LARIAT Luxury", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Maverick Hybrid 2023-24", modelAr: "مافريك هايبرد 2023-24", package: "Co-Pilot360", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Mustang Mach-E 2021-24", modelAr: "موستانج ماك-إي 2021-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Ford", makeAr: "فورد", model: "Ranger 2024", modelAr: "رينجر 2024", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Genesis - جينيسيس (14 مركبة)
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G70 2018", modelAr: "جي 70 2018", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G70 2019-21", modelAr: "جي 70 2019-21", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G70 2022-23", modelAr: "جي 70 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G80 2017", modelAr: "جي 80 2017", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "60"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G80 2018-19", modelAr: "جي 80 2018-19", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G80 2020-23", modelAr: "جي 80 2020-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G80 2024", modelAr: "جي 80 2024", package: "HDA II", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G90 2017-18", modelAr: "جي 90 2017-18", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "G90 2020", modelAr: "جي 90 2020", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "GV60 2022-23", modelAr: "جي في 60 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "GV70 2022-24", modelAr: "جي في 70 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "GV70 Electrified 2023", modelAr: "جي في 70 كهربائية 2023", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "GV80 2021-22", modelAr: "جي في 80 2021-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Genesis", makeAr: "جينيسيس", model: "GV80 2023", modelAr: "جي في 80 2023", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // GMC - جي إم سي
    Vehicle(make: "GMC", makeAr: "جي إم سي", model: "Sierra 1500 2020-21", modelAr: "سييرا 1500 2020-21", package: "Driver Alert II", longitudinal: "نعم", lateral: "جزئي", minSpeed: "10"),
    
    // Honda - هوندا (34 مركبة)
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Accord 2018-22", modelAr: "أكورد 2018-22", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Accord 2023-25", modelAr: "أكورد 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Accord Hybrid 2018-22", modelAr: "أكورد هايبرد 2018-22", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Accord Hybrid 2023-25", modelAr: "أكورد هايبرد 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic 2016-18", modelAr: "سيفيك 2016-18", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "19"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic 2019-21", modelAr: "سيفيك 2019-21", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "3"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic 2022-24", modelAr: "سيفيك 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic Hatchback 2017-18", modelAr: "سيفيك هاتشباك 2017-18", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "19"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic Hatchback 2019-21", modelAr: "سيفيك هاتشباك 2019-21", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "19"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic Hatchback 2022-24", modelAr: "سيفيك هاتشباك 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic Hatchback Hybrid 2023-26", modelAr: "سيفيك هاتشباك هايبرد 2023-26", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Civic Hybrid 2025-26", modelAr: "سيفيك هايبرد 2025-26", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "City 2023", modelAr: "سيتي 2023", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "23"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "CR-V 2015-16", modelAr: "سي آر-في 2015-16", package: "Touring", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "CR-V 2017-22", modelAr: "سي آر-في 2017-22", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "24"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "CR-V 2023-26", modelAr: "سي آر-في 2023-26", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "CR-V Hybrid 2017-22", modelAr: "سي آر-في هايبرد 2017-22", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "19"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "CR-V Hybrid 2023-25", modelAr: "سي آر-في هايبرد 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "e 2020", modelAr: "إي 2020", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Fit 2018-20", modelAr: "فيت 2018-20", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Freed 2020", modelAr: "فريد 2020", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "HR-V 2019-22", modelAr: "إتش آر-في 2019-22", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "HR-V 2023-25", modelAr: "إتش آر-في 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Insight 2019-22", modelAr: "إنسايت 2019-22", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Inspire 2018", modelAr: "إنسباير 2018", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "5"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "N-Box 2018", modelAr: "إن-بوكس 2018", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "18"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Odyssey 2018-20", modelAr: "أوديسي 2018-20", package: "Honda Sensing", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Odyssey 2021-26", modelAr: "أوديسي 2021-26", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "69"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Passport 2019-25", modelAr: "باسبورت 2019-25", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Passport 2026", modelAr: "باسبورت 2026", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Pilot 2016-22", modelAr: "بايلوت 2016-22", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Pilot 2023-25", modelAr: "بايلوت 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Honda", makeAr: "هوندا", model: "Ridgeline 2017-25", modelAr: "ريدجلاين 2017-25", package: "Honda Sensing", longitudinal: "نعم", lateral: "جزئي", minSpeed: "42"),
    
    // Hyundai - هيونداي (44 مركبة)
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Azera 2022", modelAr: "أزيرا 2022", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Azera Hybrid 2019-20", modelAr: "أزيرا هايبرد 2019-20", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Custin 2023", modelAr: "كوستين 2023", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Elantra 2017-18", modelAr: "إلنترا 2017-18", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Elantra 2019", modelAr: "إلنترا 2019", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Elantra 2021-23", modelAr: "إلنترا 2021-23", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Elantra GT 2017-20", modelAr: "إلنترا GT 2017-20", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Elantra Hybrid 2021-23", modelAr: "إلنترا هايبرد 2021-23", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Genesis 2015-16", modelAr: "جينيسيس 2015-16", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "60"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "i30 2017-19", modelAr: "آي 30 2017-19", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Ioniq 5 2022-24", modelAr: "أيونيك 5 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Ioniq 6 2023-24", modelAr: "أيونيك 6 2023-24", package: "HDA II", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Ioniq Electric 2019-20", modelAr: "أيونيك إلكتريك 2019-20", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Ioniq Hybrid 2017-22", modelAr: "أيونيك هايبرد 2017-22", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Ioniq Plug-in Hybrid 2019-22", modelAr: "أيونيك بلج-إن 2019-22", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Kona 2020", modelAr: "كونا 2020", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "10"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Kona Electric 2018-21", modelAr: "كونا إلكتريك 2018-21", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Kona Electric 2022-23", modelAr: "كونا إلكتريك 2022-23", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Kona Hybrid 2020", modelAr: "كونا هايبرد 2020", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Nexo 2021", modelAr: "نيكسو 2021", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Palisade 2020-22", modelAr: "باليسيد 2020-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Santa Cruz 2022-24", modelAr: "سانتا كروز 2022-24", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Santa Fe 2019-20", modelAr: "سانتا في 2019-20", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Santa Fe 2021-23", modelAr: "سانتا في 2021-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Santa Fe Hybrid 2022-23", modelAr: "سانتا في هايبرد 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Santa Fe Plug-in Hybrid 2022-23", modelAr: "سانتا في بلج-إن 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Sonata 2018-19", modelAr: "سوناتا 2018-19", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Sonata 2020-23", modelAr: "سوناتا 2020-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Sonata Hybrid 2020-23", modelAr: "سوناتا هايبرد 2020-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Staria 2023", modelAr: "ستاريا 2023", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Tucson 2021", modelAr: "توسان 2021", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "31"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Tucson 2022-24", modelAr: "توسان 2022-24", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Tucson Diesel 2019", modelAr: "توسان ديزل 2019", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Tucson Hybrid 2022-24", modelAr: "توسان هايبرد 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Tucson Plug-in Hybrid 2024", modelAr: "توسان بلج-إن 2024", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Hyundai", makeAr: "هيونداي", model: "Veloster 2019-20", modelAr: "فيلوستر 2019-20", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "8"),
    
    // Jeep - جيب
    Vehicle(make: "Jeep", makeAr: "جيب", model: "Grand Cherokee 2016-18", modelAr: "جراند شيروكي 2016-18", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "15"),
    Vehicle(make: "Jeep", makeAr: "جيب", model: "Grand Cherokee 2019-21", modelAr: "جراند شيروكي 2019-21", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "63"),
    
    // Kia - كيا (36 مركبة)
    Vehicle(make: "Kia", makeAr: "كيا", model: "Carnival 2022-24", modelAr: "كارنيفال 2022-24", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Carnival (China) 2023", modelAr: "كارنيفال (الصين) 2023", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Ceed 2019-21", modelAr: "سيد 2019-21", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "EV6 2022-24", modelAr: "إي في 6 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Forte 2019-21", modelAr: "فورتي 2019-21", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "10"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Forte 2022-23", modelAr: "فورتي 2022-23", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "K5 2021-24", modelAr: "كي 5 2021-24", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "K5 Hybrid 2020-22", modelAr: "كي 5 هايبرد 2020-22", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "K8 Hybrid 2023", modelAr: "كي 8 هايبرد 2023", package: "HDA II", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro EV 2019", modelAr: "نيرو EV 2019", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro EV 2020", modelAr: "نيرو EV 2020", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro EV 2021", modelAr: "نيرو EV 2021", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro EV 2022", modelAr: "نيرو EV 2022", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro EV 2023-25", modelAr: "نيرو EV 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro Hybrid 2018", modelAr: "نيرو هايبرد 2018", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro Hybrid 2021-22", modelAr: "نيرو هايبرد 2021-22", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro Hybrid 2023", modelAr: "نيرو هايبرد 2023", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Niro Plug-in Hybrid 2018-22", modelAr: "نيرو بلج-إن 2018-22", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Optima 2017", modelAr: "أوبتيما 2017", package: "SCC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "51"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Optima 2019-20", modelAr: "أوبتيما 2019-20", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Optima Hybrid 2019", modelAr: "أوبتيما هايبرد 2019", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Seltos 2021", modelAr: "سيلتوس 2021", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sorento 2018-19", modelAr: "سورينتو 2018-19", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sorento 2021-23", modelAr: "سورينتو 2021-23", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sorento Hybrid 2021-23", modelAr: "سورينتو هايبرد 2021-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sorento Plug-in Hybrid 2022-23", modelAr: "سورينتو بلج-إن 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sportage 2023-24", modelAr: "سبورتاج 2023-24", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Sportage Hybrid 2023", modelAr: "سبورتاج هايبرد 2023", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Stinger 2018-20", modelAr: "ستينجر 2018-20", package: "SCC", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Stinger 2022-23", modelAr: "ستينجر 2022-23", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Kia", makeAr: "كيا", model: "Telluride 2020-22", modelAr: "تيلورايد 2020-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Lexus - لكزس (22 مركبة)
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "CT Hybrid 2017-18", modelAr: "سي تي هايبرد 2017-18", package: "LSS", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "ES 2017-18", modelAr: "إي إس 2017-18", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "ES 2019-25", modelAr: "إي إس 2019-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "ES Hybrid 2017-18", modelAr: "إي إس هايبرد 2017-18", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "ES Hybrid 2019-25", modelAr: "إي إس هايبرد 2019-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "GS F 2016", modelAr: "جي إس إف 2016", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "IS 2017-19", modelAr: "آي إس 2017-19", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "IS 2022-24", modelAr: "آي إس 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "LC 2024-25", modelAr: "إل سي 2024-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "NX 2018-19", modelAr: "إن إكس 2018-19", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "NX 2020-21", modelAr: "إن إكس 2020-21", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "NX Hybrid 2018-19", modelAr: "إن إكس هايبرد 2018-19", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "NX Hybrid 2020-21", modelAr: "إن إكس هايبرد 2020-21", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RC 2018-20", modelAr: "آر سي 2018-20", package: "All", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RC 2023", modelAr: "آر سي 2023", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX 2016", modelAr: "آر إكس 2016", package: "LSS", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX 2017-19", modelAr: "آر إكس 2017-19", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX 2020-22", modelAr: "آر إكس 2020-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX Hybrid 2016", modelAr: "آر إكس هايبرد 2016", package: "LSS", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX Hybrid 2017-19", modelAr: "آر إكس هايبرد 2017-19", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "RX Hybrid 2020-22", modelAr: "آر إكس هايبرد 2020-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lexus", makeAr: "لكزس", model: "UX Hybrid 2019-24", modelAr: "يو إكس هايبرد 2019-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Lincoln - لينكولن (2 مركبة)
    Vehicle(make: "Lincoln", makeAr: "لينكولن", model: "Aviator 2020-24", modelAr: "أفييتور 2020-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Lincoln", makeAr: "لينكولن", model: "Aviator Plug-in Hybrid 2020-24", modelAr: "أفييتور بلج-إن 2020-24", package: "Co-Pilot360+", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Mazda - مازدا
    Vehicle(make: "Mazda", makeAr: "مازدا", model: "CX-5 2022-25", modelAr: "سي إكس-5 2022-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Mazda", makeAr: "مازدا", model: "CX-50 2023-25", modelAr: "سي إكس-50 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Mazda", makeAr: "مازدا", model: "CX-90 2024-25", modelAr: "سي إكس-90 2024-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Nissan - نيسان
    Vehicle(make: "Nissan", makeAr: "نيسان", model: "Altima 2019-24", modelAr: "ألتيما 2019-24", package: "ProPilot", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Nissan", makeAr: "نيسان", model: "Ariya 2023-24", modelAr: "أريا 2023-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Nissan", makeAr: "نيسان", model: "Leaf 2018-24", modelAr: "ليف 2018-24", package: "ProPilot", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Nissan", makeAr: "نيسان", model: "Rogue 2018-25", modelAr: "روج 2018-25", package: "ProPilot", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // RAM - رام
    Vehicle(make: "RAM", makeAr: "رام", model: "1500 2019-24", modelAr: "1500 2019-24", package: "ACC", longitudinal: "نعم", lateral: "جزئي", minSpeed: "63"),
    
    // Subaru - سوبارو (11 مركبة)
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Ascent 2019-21", modelAr: "أسنت 2019-21", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Crosstrek 2018-19", modelAr: "كروستريك 2018-19", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Crosstrek 2020-23", modelAr: "كروستريك 2020-23", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Crosstrek Hybrid 2020", modelAr: "كروستريك هايبرد 2020", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Forester 2019-21", modelAr: "فورستر 2019-21", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Forester 2022-25", modelAr: "فورستر 2022-25", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Impreza 2017-19", modelAr: "إمبريزا 2017-19", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Impreza 2020-22", modelAr: "إمبريزا 2020-22", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Legacy 2020-24", modelAr: "ليجاسي 2020-24", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "Outback 2020-25", modelAr: "أوتباك 2020-25", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Subaru", makeAr: "سوبارو", model: "WRX 2020-24", modelAr: "دبليو آر إكس 2020-24", package: "EyeSight", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Tesla - تسلا
    Vehicle(make: "Tesla", makeAr: "تسلا", model: "Model 3 2017-24", modelAr: "موديل 3 2017-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Tesla", makeAr: "تسلا", model: "Model S 2012-24", modelAr: "موديل إس 2012-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Tesla", makeAr: "تسلا", model: "Model X 2016-24", modelAr: "موديل إكس 2016-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Tesla", makeAr: "تسلا", model: "Model Y 2020-24", modelAr: "موديل واي 2020-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Toyota - تويوتا
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Avalon 2019-21", modelAr: "أفالون 2019-21", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Camry 2018-24", modelAr: "كامري 2018-24", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "C-HR 2017-21", modelAr: "سي-إتش آر 2017-21", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla 2017-19", modelAr: "كورولا 2017-19", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    // Toyota - تويوتا (44 مركبة)
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Alphard 2020-25", modelAr: "ألفارد 2020-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Alphard Hybrid 2021-25", modelAr: "ألفارد هايبرد 2021-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Avalon 2017-18", modelAr: "أفالون 2017-18", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Avalon 2019-21", modelAr: "أفالون 2019-21", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Avalon Hybrid 2017-18", modelAr: "أفالون هايبرد 2017-18", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Avalon Hybrid 2019-21", modelAr: "أفالون هايبرد 2019-21", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "bZ4x 2023-25", modelAr: "بي زد 4 إكس 2023-25", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Camry 2018-20", modelAr: "كامري 2018-20", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Camry 2021-24", modelAr: "كامري 2021-24", package: "TSS 2.5", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Camry Hybrid 2018-20", modelAr: "كامري هايبرد 2018-20", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Camry Hybrid 2021-24", modelAr: "كامري هايبرد 2021-24", package: "TSS 2.5", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "C-HR 2017-21", modelAr: "سي-إتش آر 2017-21", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "C-HR Hybrid 2017-21", modelAr: "سي-إتش آر هايبرد 2017-21", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla 2017-19", modelAr: "كورولا 2017-19", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla 2020-25", modelAr: "كورولا 2020-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla Cross 2022-25", modelAr: "كورولا كروس 2022-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla Cross Hybrid 2023-25", modelAr: "كورولا كروس هايبرد 2023-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla Hatchback 2019-25", modelAr: "كورولا هاتشباك 2019-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Corolla Hybrid 2020-25", modelAr: "كورولا هايبرد 2020-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Crown 2023-25", modelAr: "كراون 2023-25", package: "TSS 3.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Grand Highlander 2024-25", modelAr: "جراند هايلاندر 2024-25", package: "TSS 3.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Grand Highlander Hybrid 2024-25", modelAr: "جراند هايلاندر هايبرد 2024-25", package: "TSS 3.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Highlander 2017-19", modelAr: "هايلاندر 2017-19", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Highlander 2020-25", modelAr: "هايلاندر 2020-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Highlander Hybrid 2017-19", modelAr: "هايلاندر هايبرد 2017-19", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Highlander Hybrid 2020-25", modelAr: "هايلاندر هايبرد 2020-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Mirai 2021-22", modelAr: "ميراي 2021-22", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Prius 2016-20", modelAr: "بريوس 2016-20", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Prius 2021-22", modelAr: "بريوس 2021-22", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Prius 2023-25", modelAr: "بريوس 2023-25", package: "TSS 3.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Prius Prime 2017-20", modelAr: "بريوس برايم 2017-20", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Prius Prime 2021-22", modelAr: "بريوس برايم 2021-22", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "RAV4 2016-18", modelAr: "راف 4 2016-18", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "RAV4 2019-25", modelAr: "راف 4 2019-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "RAV4 Hybrid 2016-18", modelAr: "راف 4 هايبرد 2016-18", package: "TSS-P", longitudinal: "نعم", lateral: "جزئي", minSpeed: "31"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "RAV4 Hybrid 2019-25", modelAr: "راف 4 هايبرد 2019-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "RAV4 Prime 2021-25", modelAr: "راف 4 برايم 2021-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Sequoia 2023-25", modelAr: "سيكويا 2023-25", package: "TSS 2.5", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Sienna 2018-20", modelAr: "سيينا 2018-20", package: "TSS-P", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Sienna 2021-25", modelAr: "سيينا 2021-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Tundra 2022-25", modelAr: "تندرا 2022-25", package: "TSS 2.5", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Tundra Hybrid 2022-25", modelAr: "تندرا هايبرد 2022-25", package: "TSS 2.5", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Toyota", makeAr: "تويوتا", model: "Venza 2021-25", modelAr: "فينزا 2021-25", package: "TSS 2.0", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Volkswagen - فولكس واجن
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Arteon 2018-23", modelAr: "أرتيون 2018-23", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Atlas 2018-24", modelAr: "أطلس 2018-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Atlas Cross Sport 2021-24", modelAr: "أطلس كروس سبورت 2021-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf 2015-24", modelAr: "جولف 2015-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf Alltrack 2017-18", modelAr: "جولف أولتراك 2017-18", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf GTE 2016-18", modelAr: "جولف GTE 2016-18", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf GTI 2018-24", modelAr: "جولف GTI 2018-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf R 2018-24", modelAr: "جولف R 2018-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Golf SportWagen 2015-18", modelAr: "جولف سبورت واجن 2015-18", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "ID.4 2021-24", modelAr: "آي دي 4 2021-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "ID.Buzz 2024", modelAr: "آي دي باز 2024", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Jetta 2018-24", modelAr: "جيتا 2018-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Jetta GLI 2019-24", modelAr: "جيتا GLI 2019-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Passat 2015-22", modelAr: "باسات 2015-22", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Polo 2020-24", modelAr: "بولو 2020-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "T-Cross 2021", modelAr: "تي كروس 2021", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "T-Roc 2021-24", modelAr: "تي روك 2021-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Taos 2022-24", modelAr: "تاوس 2022-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Tiguan 2019-24", modelAr: "تيجوان 2019-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Volkswagen", makeAr: "فولكس واجن", model: "Touran 2017", modelAr: "توران 2017", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // MAN - مان (شركة جديدة)
    Vehicle(make: "MAN", makeAr: "مان", model: "eTGE 2020-24", modelAr: "إي تي جي إي 2020-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "جزئي", minSpeed: "50"),
    Vehicle(make: "MAN", makeAr: "مان", model: "TGE 2017-24", modelAr: "تي جي إي 2017-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "جزئي", minSpeed: "50"),
    
    // Rivian - ريفيان (شركة جديدة)
    Vehicle(make: "Rivian", makeAr: "ريفيان", model: "R1S 2022-24", modelAr: "آر 1 إس 2022-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Rivian", makeAr: "ريفيان", model: "R1T 2021-24", modelAr: "آر 1 تي 2021-24", package: "All", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // SEAT - سيات (شركة جديدة)
    Vehicle(make: "SEAT", makeAr: "سيات", model: "Ateca 2018-23", modelAr: "أتيكا 2018-23", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "SEAT", makeAr: "سيات", model: "Leon 2014-20", modelAr: "ليون 2014-20", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "SEAT", makeAr: "سيات", model: "Tarraco 2019-23", modelAr: "تاراكو 2019-23", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    
    // Škoda - سكودا (شركة جديدة)
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Enyaq iV 2022-24", modelAr: "إنياك iV 2022-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Kamiq 2021-24", modelAr: "كاميك 2021-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Karoq 2019-24", modelAr: "كاروك 2019-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Kodiaq 2018-24", modelAr: "كودياك 2018-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Octavia 2015-19", modelAr: "أوكتافيا 2015-19", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Octavia 2020-24", modelAr: "أوكتافيا 2020-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Scala 2020-24", modelAr: "سكالا 2020-24", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
    Vehicle(make: "Škoda", makeAr: "سكودا", model: "Superb 2015-22", modelAr: "سوبيرب 2015-22", package: "ACC + Lane", longitudinal: "نعم", lateral: "نعم", minSpeed: "0"),
]

// MARK: - Computed Brands Array
var brands: [Brand] {
    let grouped = Dictionary(grouping: vehiclesData, by: { $0.make })
    return grouped.map { key, vehicles in
        let nameAr = vehicles.first?.makeAr ?? key
        return Brand(name: key, nameAr: nameAr, vehicles: vehicles)
    }.sorted { $0.nameAr < $1.nameAr }
}

// MARK: - Unsupported Vehicles
let unsupportedVehicles = [
    "Toyota RAV4 2025+",
    "Toyota Camry 2025+",
    "Toyota Corolla 2025+",
    "Lexus TX 2024+",
    "Lexus GX 2024+"
]

// MARK: - Cars View
struct CarsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    @State private var showUnsupportedList = false
    
    let productURL = "https://nmk.sa/redirect/products/1586232927"
    
    var filteredBrands: [Brand] {
        if searchText.isEmpty {
            return brands
        }
        return brands.filter { brand in
            brand.name.localizedCaseInsensitiveContains(searchText) ||
            brand.nameAr.contains(searchText) ||
            brand.vehicles.contains { vehicle in
                vehicle.model.localizedCaseInsensitiveContains(searchText) ||
                vehicle.modelAr.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    orderButton
                    legendSection
                    searchBar
                    brandsGrid
                    unsupportedWarning
                    Spacer(minLength: 30)
                }
            }
            .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
            .navigationTitle("السيارات المدعومة")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var legendSection: some View {
        VStack(alignment: .trailing, spacing: 15) {
            HStack {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.blue)
                Text("دليل المصطلحات")
                    .font(.headline)
                Spacer()
            }
            .environment(\.layoutDirection, .rightToLeft)
            
            VStack(alignment: .trailing, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.green)
                        .frame(width: 25)
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("التحكم الطولي (ACC)")
                            .font(.system(size: 14, weight: .semibold))
                        Text("التحكم بالتسارع والفرامل تلقائياً")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
                
                Divider()
                
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "arrow.left.arrow.right")
                        .foregroundColor(.blue)
                        .frame(width: 25)
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("التحكم الجانبي (LKA)")
                            .font(.system(size: 14, weight: .semibold))
                        Text("التحكم بالمقود للبقاء في المسار")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
                
                Divider()
                
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "speedometer")
                        .foregroundColor(.orange)
                        .frame(width: 25)
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("السرعة الدنيا")
                            .font(.system(size: 14, weight: .semibold))
                        Text("السرعة الدنيا لتفعيل النظام (0 = من الثبات)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .environment(\.layoutDirection, .rightToLeft)
                
                Divider()
                
                HStack(spacing: 15) {
                    HStack(spacing: 5) {
                        Text("✓")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(red: 21/255, green: 87/255, blue: 36/255))
                            .frame(width: 20, height: 20)
                            .background(Color(red: 212/255, green: 237/255, blue: 218/255))
                            .cornerRadius(5)
                        Text("مدعوم")
                            .font(.caption)
                    }
                    
                    HStack(spacing: 5) {
                        Text("~")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255))
                            .frame(width: 20, height: 20)
                            .background(Color(red: 255/255, green: 243/255, blue: 205/255))
                            .cornerRadius(5)
                        Text("جزئي")
                            .font(.caption)
                    }
                    
                    HStack(spacing: 5) {
                        Text("✗")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(red: 114/255, green: 28/255, blue: 36/255))
                            .frame(width: 20, height: 20)
                            .background(Color(red: 248/255, green: 215/255, blue: 218/255))
                            .cornerRadius(5)
                        Text("غير مدعوم")
                            .font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 5)
                .environment(\.layoutDirection, .rightToLeft)
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var headerSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "car.2.fill")
                .font(.system(size: 50))
                .foregroundColor(.white)
            
            Text("المركبات المدعومة")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            
            Text("القائد الآلي الجيل الثالث")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            HStack(spacing: 20) {
                StatBadge(value: "\(brands.count)", label: "شركة")
                StatBadge(value: "\(vehiclesData.count)", label: "مركبة")
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 25)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 102/255, green: 126/255, blue: 234/255),
                    Color(red: 118/255, green: 75/255, blue: 162/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    var orderButton: some View {
        Button(action: {
            if let url = URL(string: productURL) {
                UIApplication.shared.open(url)
            }
        }) {
            HStack {
                Image(systemName: "cart.fill")
                Text("اطلبه الآن")
                    .font(.system(size: 17, weight: .bold))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 12)
            .background(Color.green)
            .cornerRadius(25)
        }
        .padding(.vertical, 15)
    }
    
    var unsupportedWarning: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: {
                withAnimation {
                    showUnsupportedList.toggle()
                }
            }) {
                HStack {
                    Image(systemName: showUnsupportedList ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("سيارات غير مدعومة حالياً")
                            .font(.headline)
                            .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255))
                        Text("اضغط لعرض القائمة")
                            .font(.caption)
                            .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255).opacity(0.7))
                    }
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                        .font(.title3)
                }
            }
            
            if showUnsupportedList {
                Divider()
                    .background(Color.orange.opacity(0.5))
                
                Text("⚠️ بسبب نظام الحماية الجديد:")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(unsupportedVehicles, id: \.self) { vehicle in
                    HStack(spacing: 6) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red.opacity(0.7))
                            .font(.caption)
                        Text(vehicle)
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255))
                        Spacer()
                    }
                }
                
                Text("نعمل على إيجاد حلول لهذه السيارات")
                    .font(.caption)
                    .foregroundColor(Color(red: 133/255, green: 100/255, blue: 4/255).opacity(0.8))
                    .padding(.top, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(Color(red: 255/255, green: 243/255, blue: 205/255))
        .overlay(
            Rectangle()
                .fill(Color.orange)
                .frame(width: 5),
            alignment: .leading
        )
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("ابحث عن سيارتك...", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
        .cornerRadius(12)
        .padding()
    }
    
    var brandsGrid: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("اختر الشركة المصنعة")
                .font(.headline)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(filteredBrands) { brand in
                    NavigationLink(destination: BrandDetailView(brand: brand, productURL: productURL)) {
                        BrandCardView(brand: brand, colorScheme: colorScheme)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}

// MARK: - Supporting Views
struct StatBadge: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.2))
        .cornerRadius(10)
    }
}

struct BrandCardView: View {
    let brand: Brand
    let colorScheme: ColorScheme
    
    var logoName: String {
        let logoMap: [String: String] = [
            "Acura": "acura", "Audi": "audi", "Chevrolet": "chevrolet",
            "Chrysler": "chrysler", "CUPRA": "cupra", "Dodge": "dodge",
            "Ford": "ford", "Genesis": "genesis", "GMC": "gmc",
            "Honda": "honda", "Hyundai": "hyundai", "Jeep": "jeep",
            "Kia": "kia", "Lexus": "lexus", "Lincoln": "lincoln",
            "MAN": "man", "Mazda": "mazda", "Nissan": "nissan", "RAM": "ram",
            "Rivian": "rivian", "SEAT": "seat", "Škoda": "skoda",
            "Subaru": "subaru", "Tesla": "tesla", "Toyota": "toyota",
            "Volkswagen": "volkswagen"
        ]
        return logoMap[brand.name] ?? "car.fill"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            
            Text(brand.nameAr)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(1)
            
            Text("\(brand.vehicles.count) مركبة")
                .font(.caption2)
                .foregroundColor(Color(red: 102/255, green: 126/255, blue: 234/255))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
        .cornerRadius(12)
        .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.2), radius: 3, x: 0, y: 2)
    }
}

struct SupportBadge: View {
    let text: String
    
    var backgroundColor: Color {
        if text == "نعم" { return Color(red: 212/255, green: 237/255, blue: 218/255) }
        else if text == "لا" { return Color(red: 248/255, green: 215/255, blue: 218/255) }
        else { return Color(red: 255/255, green: 243/255, blue: 205/255) }
    }
    
    var textColor: Color {
        if text == "نعم" { return Color(red: 21/255, green: 87/255, blue: 36/255) }
        else if text == "لا" { return Color(red: 114/255, green: 28/255, blue: 36/255) }
        else { return Color(red: 133/255, green: 100/255, blue: 4/255) }
    }
    
    var body: some View {
        Text(text == "نعم" ? "✓" : (text == "لا" ? "✗" : "~"))
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(textColor)
            .frame(width: 22, height: 22)
            .background(backgroundColor)
            .cornerRadius(5)
    }
}

struct SpeedBadge: View {
    let minSpeed: String
    
    var body: some View {
        VStack(spacing: 1) {
            Text(minSpeed)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
            Text("كم/س")
                .font(.system(size: 7))
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(width: 40, height: 28)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 102/255, green: 126/255, blue: 234/255),
                    Color(red: 118/255, green: 75/255, blue: 162/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(6)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - Brand Detail View
struct BrandDetailView: View {
    let brand: Brand
    let productURL: String
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var logoName: String {
        let logoMap: [String: String] = [
            "Acura": "acura", "Audi": "audi", "Chevrolet": "chevrolet",
            "Chrysler": "chrysler", "CUPRA": "cupra", "Dodge": "dodge",
            "Ford": "ford", "Genesis": "genesis", "GMC": "gmc",
            "Honda": "honda", "Hyundai": "hyundai", "Jeep": "jeep",
            "Kia": "kia", "Lexus": "lexus", "Lincoln": "lincoln",
            "MAN": "man", "Mazda": "mazda", "Nissan": "nissan", "RAM": "ram",
            "Rivian": "rivian", "SEAT": "seat", "Škoda": "skoda",
            "Subaru": "subaru", "Tesla": "tesla", "Toyota": "toyota",
            "Volkswagen": "volkswagen"
        ]
        return logoMap[brand.name] ?? "car.fill"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    VStack(spacing: 12) {
                        Image(logoName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        
                        Text(brand.nameAr)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("\(brand.vehicles.count) مركبة مدعومة")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        HStack(spacing: 5) {
                            Text("اضغط للعودة للشركات")
                            Image(systemName: "chevron.left")
                        }
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 102/255, green: 126/255, blue: 234/255),
                                Color(red: 118/255, green: 75/255, blue: 162/255)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // زر الطلب
                Button(action: {
                    if let url = URL(string: productURL) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "cart.fill")
                        Text("اطلبه الآن")
                            .font(.system(size: 17, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.green)
                    .cornerRadius(25)
                }
                .padding(.vertical, 15)
                
                // قائمة السيارات - RTL
                VStack(spacing: 0) {
                    // Header Row - الموديل على اليمين، السرعة على اليسار
                    HStack(spacing: 0) {
                        Text("السرعة")
                            .frame(width: 42, alignment: .center)
                        Text("جانبي")
                            .frame(width: 32, alignment: .center)
                        Text("طولي")
                            .frame(width: 32, alignment: .center)
                        Text("الحزمة")
                            .frame(width: 55, alignment: .center)
                        Text("الموديل")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .font(.system(size: 9, weight: .semibold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 10)
                    .background(Color(UIColor.systemGray5))
                    
                    // Vehicle Rows
                    ForEach(brand.vehicles) { vehicle in
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                SpeedBadge(minSpeed: vehicle.minSpeed)
                                    .frame(width: 42)
                                
                                SupportBadge(text: vehicle.lateral)
                                    .frame(width: 32)
                                
                                SupportBadge(text: vehicle.longitudinal)
                                    .frame(width: 32)
                                
                                Text(vehicle.package)
                                    .font(.system(size: 7))
                                    .foregroundColor(.secondary)
                                    .frame(width: 55, alignment: .center)
                                    .lineLimit(2)
                                
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text(vehicle.model)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(Color(red: 102/255, green: 126/255, blue: 234/255))
                                        .multilineTextAlignment(.trailing)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    if vehicle.modelAr != vehicle.model {
                                        Text(vehicle.modelAr)
                                            .font(.system(size: 8))
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.trailing)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                            
                            Divider()
                        }
                    }
                }
                .background(colorScheme == .dark ? Color(UIColor.secondarySystemGroupedBackground) : Color.white)
                .cornerRadius(12)
                .shadow(color: colorScheme == .dark ? Color.clear : Color.gray.opacity(0.2), radius: 5, x: 0, y: 3)
                .padding()
            }
        }
        .background(colorScheme == .dark ? Color.black : Color(UIColor.systemGroupedBackground))
        .navigationBarTitle(brand.nameAr, displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
Group {
            CarsView()
                .preferredColorScheme(.light)
            
            CarsView()
                .preferredColorScheme(.dark)
        }
}
