//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct CitySelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""
    
    let cities = ["Москва", "Санкт Петербург", "Сочи", "Горный воздух", "Краснодар", "Казань", "Омск", "Томск", "Пермь", "Красноярск"]
    let onCitySelected: (String) -> Void
    
    private var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.top)
            
            if filteredCities.isEmpty {
                Spacer()
                Text("Город не найден")
                    .foregroundColor(.ypBlack)
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                Spacer()
            } else {
                List(filteredCities, id: \.self) { city in
                    Button(action: {
                        onCitySelected(city)
                    }) {
                        HStack {
                            Text(city)
                                .foregroundColor(.ypBlack)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.ypBlack)
                        }
                    }
                }
                .listStyle(.inset)
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
    }
}

#Preview {
    CitySelectionView { selectedCity in
        print("Выбран город: \(selectedCity)")
    }
}
