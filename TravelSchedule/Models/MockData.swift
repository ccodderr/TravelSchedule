//
//  MockData.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import Foundation

struct MockData {
    static let carriers: [TravelInfo] = [
        TravelInfo(
            departureTime: "22:30",
            arrivalTime: "08:15",
            carrier: CarrierModel(
                title: "РЖД",
                logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"),
                email: "info@rzd.ru",
                phone: "+7 800 775-00-00"
            ),
            hasTransfers: true,
            duration: "20 часов",
            date: "14 января"
        ),
        TravelInfo(
            departureTime: "01:15",
            arrivalTime: "09:00",
            carrier: CarrierModel(
                title: "ФГК",
                logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"),
                email: "support@fgk.ru",
                phone: "+7 495 123-45-67"
            ),
            hasTransfers: false,
            duration: "9 часов",
            date: "15 января"
        ),
        TravelInfo(
            departureTime: "12:30",
            arrivalTime: "21:00",
            carrier: CarrierModel(
                title: "Урал логистика",
                logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"),
                email: "contact@urallog.ru",
                phone: "+7 343 333-33-33"
            ),
            hasTransfers: false,
            duration: "9 часов",
            date: "16 января"
        ),
        TravelInfo(
            departureTime: "22:30",
            arrivalTime: "08:15",
            carrier: CarrierModel(
                title: "РЖД",
                logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"),
                email: "info@rzd.ru",
                phone: "+7 800 775-00-00"
            ),
            hasTransfers: true,
            duration: "20 часов",
            date: "17 января"
        ),
        TravelInfo(
            departureTime: "22:30",
            arrivalTime: "08:15",
            carrier: CarrierModel(
                title: "РЖД",
                logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/thy_kopya.jpg"),
                email: "info@rzd.ru",
                phone: "+7 800 775-00-00"
            ),
            hasTransfers: false,
            duration: "20 часов",
            date: "17 января"
        )
    ]
}
