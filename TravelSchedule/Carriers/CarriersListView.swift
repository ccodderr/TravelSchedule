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
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(spacing: 0) {
                headerView
                
                if filterViewModel.loading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    Spacer()
                } else if filterViewModel.carrier.isEmpty {
                    Spacer()
                    Text("Вариантов нет")
                        .foregroundColor(.ypBlack)
                        .font(.bold24)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(filterViewModel.carrier) { info in
                                CarrierCard(info: info)
                                    .onTapGesture {
                                        viewModel.didSelectRoute(info)
                                    }
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
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding([.horizontal, .bottom])
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
            .task {
                guard let from = viewModel.from.station?.codes?.yandex_code,
                      let to = viewModel.to.station?.codes?.yandex_code
                else { return }
                
                await filterViewModel.load(from: from, to: to)
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("\(viewModel.fromRaw ?? "") → \(viewModel.toRaw ?? "")")
                .font(.bold24)
                .foregroundColor(.ypBlack)
                .padding()
            
            Spacer(minLength: .zero)
        }
    }
}

private struct CarrierCard: View {
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
                                .font(.regular12)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()

                    Text(info.date)
                        .font(.regular12)
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
