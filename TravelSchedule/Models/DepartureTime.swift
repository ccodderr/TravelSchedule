//
//  DepartureTime.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

enum DepartureTime: String, CaseIterable, Identifiable {
    case morning = "Утро 06:00 - 12:00"
    case day = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
    
    var id: String { rawValue }
}

extension DepartureTime {
    var range: Range<Int> {
        switch self {
        case .morning: return 6..<12
        case .day:     return 12..<18
        case .evening: return 18..<24
        case .night:   return 0..<6
        }
    }
}
