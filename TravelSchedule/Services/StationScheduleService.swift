//
//  StationScheduleService.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 05.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationSchedule = Components.Schemas.ScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(station: String) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationSchedule(station: String) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        
        return try response.ok.body.json
    }
}
