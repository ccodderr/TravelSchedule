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

@MainActor
final class FilterViewModel: ObservableObject {
    @Published var selectedTimes: Set<DepartureTime> = []
    @Published var transferOption: TransferOption?
    @Published var carrier: [TravelInfo] = []
    @Published var loading = false
    @Published var loaded = false
    
    private var allCarriers: [TravelInfo] = []
    private let apiService = ApiService()
    
    func reset() {
        carrier = []
        selectedTimes = []
        allCarriers = []
        transferOption = nil
        loaded = false
    }
    
    func load(from: String, to: String) async {
        guard !loaded else { return }
        
        loaded = true
        loading = true
        let schedules = try? await apiService.scheduleBetweenStations(from: from, to: to)
        
        defer {
            loading = false
        }
        
        guard let schedules else { return }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.allowsFractionalUnits = true
        formatter.zeroFormattingBehavior = .dropAll

        var travels: [TravelInfo] = []
        for carrier in schedules.segments ?? [] {
            let departure = carrier.departure ?? ""
            let arrival = carrier.arrival ?? ""
            let hasTransfers = carrier.has_transfers ?? false
            let duration = TimeInterval(carrier.duration ?? 0)
            let title = carrier.thread?.carrier?.title ?? ""
            let logo = carrier.thread?.carrier?.logo ?? ""
            let email = carrier.thread?.carrier?.email ?? ""
            let phone = carrier.thread?.carrier?.phone ?? ""
            let date = carrier.start_date ?? ""
            
            let durationRaw = formatter.string(from: duration) ?? String(duration)
            
            let travel = TravelInfo(
                departureTime: departure,
                arrivalTime: arrival,
                carrier: .init(
                    title: title,
                    logo: URL(string: logo),
                    email: email,
                    phone: phone
                ),
                hasTransfers: hasTransfers,
                duration: durationRaw,
                date: date
            )
            
            travels.append(travel)
        }
        
        carrier = travels
        allCarriers = travels
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
        
        var filtered = allCarriers
        
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
