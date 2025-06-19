//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 19.06.2025.
//

import Combine

final class SettingsViewModel: ObservableObject {
    @Published private(set) var mode: Mode = .content
    
//    init() {
//        
//        Task { @MainActor in
//            try await Task.sleep(for: .seconds(9))
//            mode = .error(.noInternetConnection)
//        }
//    }
}
