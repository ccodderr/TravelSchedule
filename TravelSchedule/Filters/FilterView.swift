//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 16.06.2025.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject private var viewModel: FilterViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("Время отправления")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.ypBlack)
                        ForEach(DepartureTime.allCases) { time in
                            HStack {
                                Text(time.rawValue)
                                    .foregroundColor(.ypBlack)
                                Spacer()
                                Image(systemName: viewModel.selectedTimes.contains(time) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.ypBlack)
                                    .onTapGesture {
                                        viewModel.toggleTime(time)
                                    }
                            }
                            .padding(.vertical, 19)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: .zero) {
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.ypBlack)
                        
                        ForEach([TransferOption.yes, TransferOption.no], id: \.self) { option in
                            HStack {
                                Text(option.rawValue).foregroundColor(.ypBlack)
                                Spacer()
                                Image(systemName: viewModel.transferOption == option ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(.ypBlack)
                                    .onTapGesture {
                                        viewModel.transferOption = option
                                    }
                            }
                            .padding(.vertical, 19)
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                viewModel.applyFilters()
                dismiss()
            }) {
                Text("Применить")
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
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.ypBlack)
                }
            }
        }
    }
}

