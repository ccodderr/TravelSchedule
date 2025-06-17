//
//  SplashScreen.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 15.06.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var show = false

    var body: some View {
        Color.blackUniversal
            .ignoresSafeArea()
            .overlay(
                Image("splashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .task {
                Task {
                    try await Task.sleep(for: .seconds(2))
                    show = true
                }
            }
            .fullScreenCover(isPresented: $show) {
                TabScreenView()
            }
    }
}

struct TabScreenView: View {
    @State private var selectedTab = 0
    @EnvironmentObject private var viewModel: RouteViewModel
    @EnvironmentObject private var filterViewModel: FilterViewModel

    var body: some View {
        NavigationStack(path: $viewModel.path) {
            TabView(selection: $selectedTab) {
                MainView()
                    .tabItem {
                        Image("tab_Schedule")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? .ypBlack : .grayUniversal)
                    }
                    .tag(0)
                
                SettingsView()
                    .tabItem {
                        Image("tab_Settings")
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 1 ? .ypBlack : .grayUniversal)
                    }
                    .tag(1)
            }
            .tint(.ypBlack)
            .navigationDestination(for: NavigationScreen.self) { screen in
                switch screen {
                case .city:
                    CitySelectionView(onCitySelected: { viewModel.didSelectCity($0)} )
                case .station:
                    StationSelectionView(onStationSelected: { viewModel.didSelectStation($0)} )
                case .carriers:
                    CarriersListView()
                case .filterCarriers:
                    FilterView()
                }
            }
        }
    }
}
