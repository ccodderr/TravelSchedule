//
//  RouteViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import Foundation
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
    
    @Published var fromRaw: String?
    @Published var toRaw: String?
    
    private var fromCity: String?
    private var toCity: String?
    private var fromStation: String?
    private var toStation: String?
    @Published var path: [NavigationScreen] = []
    
    private var activeSelection: ActiveSelection?
    
    var isReadyToSearch: Bool {
        fromStation != nil && toStation != nil
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
        let oldFromCity = fromCity
        fromCity = toCity
        toCity = oldFromCity
        
        let oldFromStantion = fromStation
        fromStation = toStation
        toStation = oldFromStantion
        
        if let fromCity,
           let fromStation {
            fromRaw = "\(fromCity), \(fromStation)"
        }
        if let toCity,
           let toStation {
            toRaw = "\(toCity), \(toStation)"
        }
    }
    
    func didSelectCity(_ city: String) {
        print(city)
        guard let activeSelection = activeSelection else { return }
        switch activeSelection {
        case .from:
            fromCity = city
        case .to:
            toCity = city
        }
        
        path.append(.station)
    }
    
    func didSelectStation(_ station: String) {
        print(station)
        
        guard let activeSelection = activeSelection else { return }
        switch activeSelection {
        case .from:
            fromStation = station
            fromRaw = "\(fromCity ?? "") (\(station))"
        case .to:
            toStation = station
            toRaw = "\(toCity ?? "") (\(station))"
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
