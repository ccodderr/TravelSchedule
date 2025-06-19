//
//  SearchBar.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 17.06.2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 22)
                .padding(.leading, 8)
                .foregroundColor(searchText.isEmpty ? .grayUniversal : .ypBlack)

            TextField(
                "",
                text: $searchText,
                prompt: Text("Введите запрос")
                    .foregroundStyle(Color.grayUniversal)
            )
            .autocorrectionDisabled()
            .foregroundStyle(Color.ypBlack)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(.trailing, 8)
                        .foregroundColor(.grayUniversal)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 36)
        .background(Color.ypLightGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}
