//
//  RouteViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

enum NavigationScreen: String, Identifiable {
    case city
    case station
    case carriers
    case filterCarriers
    
    var id: String { self.rawValue }
}

final class RouteViewModel: ObservableObject {
    enum ActiveSelection {
        case from
        case to
    }
    
    private struct RoutePoint {
        var city: String?
        var station: String?
        
        var displayText: String? {
            guard let city, let station else { return nil }
            return "\(city), \(station)"
        }
    }
    
    @Published private(set) var mode: Mode = .content
    @Published private(set) var fromRaw: String?
    @Published private(set) var toRaw: String?
    @Published var path: [NavigationScreen] = []
    
    private var from = RoutePoint()
    private var to = RoutePoint()
    private var activeSelection: ActiveSelection?
    
//    init() {
//        
//        Task { @MainActor in
//            try await Task.sleep(for: .seconds(9))
//            mode = .error(.noInternetConnection)
//        }
//    }
    
    var isReadyToSearch: Bool {
        from.station != nil && to.station != nil
    }
    
    func selectFrom() {
        activeSelection = .from
        path.append(.city)
    }
    
    func selectTo() {
        activeSelection = .to
        path.append(.city)
    }
    
    func swapAction() {
        swap(&from, &to)
        fromRaw = from.displayText
        toRaw = to.displayText
    }
    
    func didSelectCity(_ city: String) {
        guard let selection = activeSelection else { return }
        switch selection {
        case .from: from.city = city
        case .to: to.city = city
        }
        path.append(.station)
    }
    
    func didSelectStation(_ station: String) {
        guard let selection = activeSelection else { return }
        switch selection {
        case .from:
            from.station = station
            fromRaw = from.displayText
        case .to:
            to.station = station
            toRaw = to.displayText
        }
        path.removeAll()
    }
    
    func showCarriers() {
        path.append(.carriers)
    }
    
    func showFilters() {
        path.append(.filterCarriers)
    }
}
