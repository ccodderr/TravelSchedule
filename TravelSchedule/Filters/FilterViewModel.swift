//
//  FilterViewModel.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import Foundation

enum TransferOption: String {
    case yes = "Да"
    case no = "Нет"
}

final class FilterViewModel: ObservableObject {
    @Published var selectedTimes: Set<DepartureTime> = []
    @Published var transferOption: TransferOption? = nil
    @Published var carrier: [TravelInfo] = MockData.carriers

    func reset() {
        carrier = MockData.carriers
        selectedTimes = []
        transferOption = nil
    }
    
    func toggleTime(_ time: DepartureTime) {
        if selectedTimes.contains(time) {
            selectedTimes.remove(time)
        } else {
            selectedTimes.insert(time)
        }
    }

    func applyFilters() {
        print("Selected times: \(selectedTimes.map { $0.rawValue })")
        print("Transfer option: \(transferOption?.rawValue ?? "Не выбрано")")
        
        var filtered = MockData.carriers
        
        if !selectedTimes.isEmpty {
            filtered = filtered.filter { info in
                selectedTimes.contains(where: { $0.range.contains(info.departureHour) })
            }
        }
        
        if let option = transferOption {
            filtered = filtered.filter { info in
                option == .yes ? info.hasTransfers : !info.hasTransfers
            }
        }
        
        carrier = filtered
    }
}
