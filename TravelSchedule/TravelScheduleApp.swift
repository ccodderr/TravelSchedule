//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 02.06.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @State private var selectedTab = 0
    @State private var showSplash = true
    
    @StateObject private var routeViewModel = RouteViewModel()
    @StateObject private var filterViewModel = FilterViewModel()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                SplashScreen()
                    .environmentObject(routeViewModel)
                    .environmentObject(filterViewModel)
                    .environmentObject(settingsViewModel)
            }
        }
    }
}

//                testFetchStations()
//                nearestCity()
//                routeStations()
//                scheduleBetweenStations()
//                carrierInfo()
//                stationSchedule()
//                stationsList()
//                copyright()
