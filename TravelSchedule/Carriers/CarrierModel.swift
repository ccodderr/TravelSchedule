//
//  CarrierModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import Foundation

struct CarrierModel: Equatable, Hashable {
    let title: String
    let logo: URL?
    let email: String
    let phone: String
    
    init(title: String, logo: URL?, email: String, phone: String) {
        self.title = title
        self.logo = logo
        self.email = email
        self.phone = phone
    }
}
