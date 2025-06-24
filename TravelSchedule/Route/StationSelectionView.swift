//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 15.06.2025.
//

import SwiftUI

struct StationSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    let stations = [
        "Ленинградский вокзал",
        "Казанский вокзал",
        "Ярославский вокзал",
        "Курский вокзал",
        "Белорусский вокзал",
        "Киевский вокзал",
        "Рижский вокзал",
        "Ладожский вокзал",
        "Витебский вокзал"
    ]
    let onStationSelected: (String) -> Void
    
    private var filteredStations: [String] {
        if searchText.isEmpty {
            return stations
        } else {
            return stations.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack {
                SearchBar(searchText: $searchText)
                    .padding(.top)
                
                if filteredStations.isEmpty {
                    Spacer()
                    Text("Станция не найдена")
                        .foregroundColor(.ypBlack)
                        .font(.bold24)
                        .padding()
                    Spacer()
                } else {
                    List(filteredStations, id: \.self) { station in
                        Button(action: {
                            onStationSelected(station)
                        }) {
                            HStack {
                                Text(station)
                                    .foregroundColor(.ypBlack)
                                
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


#Preview {
    StationSelectionView { selectedCity in
        print("Выбрана станция: \(selectedCity)")
    }
}
