//
//  RouteViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

enum NavigationScreen: Identifiable, Hashable {
    case city
    case station(settlement: Components.Schemas.Settlement)
    case carriers
    case filterCarriers
    case carrierDetail(carrier: CarrierModel)
    
    var id: Int {
        switch self {
        case .city:
            return 0
        case .station:
            return 1
        case .carriers:
            return 2
        case .filterCarriers:
            return 3
        case .carrierDetail:
            return 4
        }
    }
}

@MainActor
final class RouteViewModel: ObservableObject {
    enum ActiveSelection {
        case from
        case to
    }
    
    struct RoutePoint: Sendable {
        var city: Components.Schemas.Settlement?
        var station: Components.Schemas.Station?
        
        var displayText: String? {
            guard let city = city?.title, let station = station?.title
            else { return nil }
            
            return "\(city), \(station)"
        }
    }
    
    @Published var stories: [StoryModel] = [
        StoryModel.story1,
        StoryModel.story2,
        StoryModel.story3,
        StoryModel.story4
    ]

    @Published var selectedStory: StoryModel?
    
    @Published private(set) var mode: Mode = .content
    @Published private(set) var fromRaw: String?
    @Published private(set) var toRaw: String?
    @Published var path: [NavigationScreen] = []
    
    private(set) var from = RoutePoint()
    private(set) var to = RoutePoint()
    
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
    
    func didSelectCity(_ city: Components.Schemas.Settlement) {
        guard let selection = activeSelection else { return }
        switch selection {
        case .from: from.city = city
        case .to: to.city = city
        }
        
        path.append(.station(settlement: city))
    }
    
    func didSelectStation(_ station: Components.Schemas.Station) {
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
    
    func didSelectRoute(_ route: TravelInfo) {
        path.append(.carrierDetail(carrier: route.carrier))
    }
}
