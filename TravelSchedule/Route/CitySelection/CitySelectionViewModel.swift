//
//  CitySelectionViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 27.06.2025.
//

import Combine
import SwiftUI

@MainActor
final class CitySelectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filteredCities: [Components.Schemas.Settlement] = []
    @Published var loading = false

    var cities: [Components.Schemas.Settlement] = []

    private var subscriptions = Set<AnyCancellable>()
    
    private let onCitySelected: (Components.Schemas.Settlement) -> Void
    private let apiService = ApiService()
    
    init(onCitySelected: @escaping (Components.Schemas.Settlement) -> Void) {
        self.onCitySelected = onCitySelected
        addObservers()
    }
    
    func loadAllCities() async {
        loading = true
        let stations = try? await apiService.getAllStations()
        
        defer {
            loading = false
        }
        
        guard let countries = stations?.countries else { return }
        
        var settlements: [Components.Schemas.Settlement] = []
        
        for country in countries {
            for region in country.regions ?? [] {
                let filtered = region.settlements?.filter {
                    !($0.title?.isEmpty ?? true)
                } ?? []
                
                settlements.append(contentsOf: filtered)
            }
        }
        
        cities = settlements
        applyFilter()
    }
    
    func didSelect(_ city: Components.Schemas.Settlement) {
        onCitySelected(city)
    }
}

private extension CitySelectionViewModel {
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
        filteredCities = searchText.isEmpty
        ? cities
        : cities.filter {
            $0.title?.localizedCaseInsensitiveContains(searchText) ?? false
        }
    }
}
