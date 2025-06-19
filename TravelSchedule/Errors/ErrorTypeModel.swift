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
        Image(rawValue)
    }
    
    var message: String {
        switch self {
        case .serverError: "Ошибка сервера"
        case .noInternetConnection: "Нет интернета"
        }
    }
}

enum Mode {
    case content
    case error(ErrorTypeModel)
}
