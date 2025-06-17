//
//  ApiTestFunctions.swift.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import OpenAPIURLSession
import OpenAPIRuntime

func testFetchStations() {
    Task {
        do {
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            let service = NearestStationsService(
                client: client,
                apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
            )
            
            print("Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            print("Successfully fetched stations: \(stations)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}

func nearestCity() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = NearestCityService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let nearestCity = try await service.getNearestCity(lat: 59.939095, lng: 30.319163)
            print("Success: \(nearestCity)")
        } catch {
            print("Error: \(error)")
        }
    }
}

func routeStations() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = RouteStationsService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let routeStations = try await service.getRouteStations(uid: "018J_5_2")
            print("Success: \(routeStations)")
        } catch {
            print("Error: \(error)")
        }
    }
}

func schedualBetweenStations() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = SchedualBetweenStationsService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let schedualBetweenStations = try await service.getSchedualBetweenStations(from: "c146", to: "c213")
            print("Success: \(schedualBetweenStations)")
        } catch {
            print("Error: \(error)")
        }
    }
}

func carrierInfo() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = CarrierInfoService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let carrierInfo = try await service.getCarrierInfo(code: "1100")
            print("Success: \(carrierInfo)")
        } catch {
            print("Error: \(error)")
        }
    }
}

func stationSchedule() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = StationScheduleService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let stationSchedule = try await service.getStationSchedule(
                station: "s9600213"
            )
            print("Success: \(stationSchedule)")
        } catch {
            print("Error: \(error)")
        }
    }
}

func stationsList() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = AllStationsService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let stationsList = try await service.getAllStations()
            print("Success: \(stationsList)")
            print(stationsList)
        } catch {
            print("Error: \(error)")
        }
    }
}

func copyright() {
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )
    
    let service = CopyrightService(
        client: client,
        apikey: "64a9210b-d557-4ff0-bcbf-8681060ea076"
    )
    
    Task {
        do {
            let copyright = try await service.getCopyright()
            print("Success: \(copyright)")
        } catch {
            print("Error: \(error)")
        }
    }
}
