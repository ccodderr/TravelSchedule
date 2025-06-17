//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 02.06.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var selectedTab = 0
    @State private var showSplash = true
    
    @StateObject private var routeViewModel = RouteViewModel()
    @StateObject private var filterViewModel = FilterViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                SplashScreen()
                    .environmentObject(routeViewModel)
                    .environmentObject(filterViewModel)
                
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

//                testFetchStations()
//                nearestCity()
//                routeStations()
//                schedualBetweenStations()
//                carrierInfo()
//                stationSchedule()
//                stationsList()
//                copyright()
