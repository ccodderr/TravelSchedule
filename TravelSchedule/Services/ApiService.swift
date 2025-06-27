//
//  ApiService.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 27.06.2025.
//

import OpenAPIURLSession

actor ApiService {
    private let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    private let apikey = "64a9210b-d557-4ff0-bcbf-8681060ea076"
    
    func getAllStations() async throws -> AllStations {
        let service = AllStationsService(
            client: client,
            apikey: apikey
        )
        
        return try await service.getAllStations()
    }
    
    func getCarriers(by code: String) async throws -> CarrierInfo {
        let service = CarrierInfoService(
            client: client,
            apikey: apikey
        )
        
        return try await service.getCarrierInfo(code: code)
    }
    
    func scheduleBetweenStations(
        from: String,
        to: String
    ) async throws -> ScheduleBetweenStations {
        let service = ScheduleBetweenStationsService(
            client: client,
            apikey: apikey
        )
        
        return try await service.getScheduleBetweenStations(from: from, to: to)
    }
}
