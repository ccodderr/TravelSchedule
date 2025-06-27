//
//  StationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 27.06.2025.
//

import Combine
import SwiftUI

@MainActor
final class StationSelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var filteredStations: [Components.Schemas.Station] = []
    
    let stations: [Components.Schemas.Station]
    private var subscriptions = Set<AnyCancellable>()
    
    private let onStationSelected: (Components.Schemas.Station) -> Void
    private let city: Components.Schemas.Settlement?
    
    init(
        city: Components.Schemas.Settlement?,
        onStationSelected: @escaping (Components.Schemas.Station) -> Void
    ) {
        self.city = city
        self.onStationSelected = onStationSelected
        
        stations = city?.stations ?? []
        addObservers()
    }
    
    func didSelect(_ station: Components.Schemas.Station) {
        onStationSelected(station)
    }
}

private extension StationSelectionViewModel {
    func addObservers() {
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                
                self.applyFilter()
            }
            .store(in: &subscriptions)
    }
    
    func applyFilter() {
        filteredStations = searchText.isEmpty
        ? stations
        : stations.filter {
            $0.title?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }
}
