//
//  CarriersListView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import SwiftUI

struct CarriersListView: View {
    @EnvironmentObject private var viewModel: RouteViewModel
    @EnvironmentObject private var filterViewModel: FilterViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            headerView

            if filterViewModel.carrier.isEmpty {
                Spacer()
                Text("Вариантов нет")
                    .foregroundColor(.ypBlack)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(filterViewModel.carrier) { info in
                            CarrierCard(info: info)
                        }
                    }
                    .padding()
                }
            }

            Button(action: viewModel.showFilters) {
                Text("Уточнить время")
                    .foregroundColor(.whiteUniversal)
                    .font(.system(size: 17, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blueUniversal)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    filterViewModel.reset()
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("\(viewModel.fromRaw ?? "") → \(viewModel.toRaw ?? "")")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
                .padding()
            
            Spacer(minLength: .zero)
        }
    }
}

struct CarrierCard: View {
    let info: TravelInfo

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    AsyncImage(url: info.carrier.logo) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else {
                            Color.gray.opacity(0.2)
                        }
                    }
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    VStack(alignment: .leading) {
                        Text(info.carrier.title)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.blackUniversal)
                        
                        if info.hasTransfers {
                            Text("С пересадкой")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()

                    Text(info.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.blackUniversal)
                }

                HStack {
                    Text(info.departureTime)
                        .foregroundColor(.blackUniversal)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.grayUniversal)
                    
                    Text(info.duration)
                        .foregroundColor(.blackUniversal)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.grayUniversal)
                    
                    Text(info.arrivalTime)
                        .foregroundColor(.blackUniversal)
                }
                .font(.subheadline)
            }
            .padding()
        }
        .background(Color(.lightGrayUniversal))
        .cornerRadius(16)
    }
}
