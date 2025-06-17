//
//  ErrorTypeModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 15.06.2025.
//

import SwiftUI

enum ErrorTypeModel: String {
    case serverError
    case noInternetConnection
    
    var image: Image {
        Image(self.rawValue)
    }
    
    var message: String {
        switch self {
        case .serverError: return "Ошибка сервера"
        case .noInternetConnection: return "Нет интернета"
        }
    }
}
