//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 19.06.2025.
//

import Combine
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @Published private(set) var mode: Mode = .content
    
//    init() {
//        
//        Task { @MainActor in
//            try await Task.sleep(for: .seconds(9))
//            mode = .error(.noInternetConnection)
//        }
//    }
}
