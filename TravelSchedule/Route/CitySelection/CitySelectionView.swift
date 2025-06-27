//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct CitySelectionView: View {
    @StateObject private var viewModel: CitySelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(onCitySelected: @escaping (Components.Schemas.Settlement) -> Void) {
        _viewModel = StateObject(wrappedValue: .init(onCitySelected: onCitySelected))
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                    .padding(.top)
                
                if viewModel.loading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    Spacer()
                } else if viewModel.filteredCities.isEmpty {
                    Spacer()
                    Text("Город не найден")
                        .foregroundColor(.ypBlack)
                        .font(.bold24)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.filteredCities, id: \.self) { city in
                        Button(action: {
                            viewModel.didSelect(city)
                        }) {
                            HStack {
                                if let title = city.title {
                                    Text(title)
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
            .navigationTitle("Выбор города")
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
            .task {
                await viewModel.loadAllCities()
            }
        }
    }
}

#Preview {
    CitySelectionView { selectedCity in
        print("Выбран город: \(selectedCity)")
    }
}
