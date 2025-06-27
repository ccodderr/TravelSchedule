//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 15.06.2025.
//

import SwiftUI

struct StationSelectionView: View {
    @StateObject private var viewModel: StationSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(
        city: Components.Schemas.Settlement?,
        onStationSelected: @escaping (Components.Schemas.Station) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: .init(
                city: city,
                onStationSelected: onStationSelected
            )
        )
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                    .padding(.top)
                
                if viewModel.filteredStations.isEmpty {
                    Spacer()
                    Text("Станция не найдена")
                        .foregroundColor(.ypBlack)
                        .font(.bold24)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.filteredStations, id: \.self) { station in
                        Button(action: {
                            viewModel.didSelect(station)
                        }) {
                            HStack {
                                if let station = station.title {
                                    Text(station)
                                        .foregroundColor(.ypBlack)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.ypBlack)
                            }
                        }
                        .listRowBackground(Color.ypWhite)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.inset)
                    .scrollContentBackground(.hidden)
                    .background(Color.ypWhite)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Выбор станции")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.ypBlack)
                    }
                }
            }
        }
    }
}


//#Preview {
//    StationSelectionView { selectedCity in
//        print("Выбрана станция: \(selectedCity)")
//    }
//}
