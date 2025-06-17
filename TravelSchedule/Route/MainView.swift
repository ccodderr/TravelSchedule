//
//  MainView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: RouteViewModel
    @EnvironmentObject private var filterViewModel: FilterViewModel

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: .zero) {
                    Button(action: viewModel.selectFrom) {
                        HStack {
                            Text(viewModel.fromRaw ?? "Откуда")
                                .foregroundStyle(
                                    viewModel.fromRaw == nil
                                    ? .grayUniversal
                                    : .blackUniversal
                                )
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: viewModel.selectTo) {
                        HStack {
                            Text(viewModel.toRaw ?? "Куда")
                                .foregroundStyle(
                                    viewModel.toRaw == nil
                                    ? .grayUniversal
                                    : .blackUniversal
                                )
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.whiteUniversal)
                )
                
                Button(action: viewModel.swapAction) {
                    Image(.swapIcon)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blueUniversal)
            )
            
            if viewModel.fromRaw != nil &&
                viewModel.toRaw != nil {
                Button(action: viewModel.showCarriers) {
                    Text("Найти")
                        .foregroundStyle(.whiteUniversal)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 47)
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.blueUniversal)
                )
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Маршрут")
    }
}

//#Preview {
//    @Previewable @StateObject var routeViewModel = RouteViewModel()
//
//    MainView()
//        .environmentObject(routeViewModel)
//}
