//
//  TravelInfo.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import Foundation

struct TravelInfo: Identifiable, Sendable {
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let carrier: CarrierModel
    let hasTransfers: Bool
    let duration: String
    let date: String
    
    var departureHour: Int {
        let hourString = departureTime.prefix(2)
        return Int(hourString) ?? 0
    }
    
    init(
        departureTime: String,
        arrivalTime: String,
        carrier: CarrierModel,
        hasTransfers: Bool,
        duration: String,
        date: String
    ) {
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.carrier = carrier
        self.hasTransfers = hasTransfers
        self.duration = duration
        self.date = date
    }
}

