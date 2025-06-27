//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 27.06.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @Environment(\.dismiss) private var dismiss
    let info: CarrierModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 24) {
                        AsyncImage(url: info.logo) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Color.gray.opacity(0.2)
                            }
                        }
                        .frame(height: 104)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .padding(.top, 24)
                        
                        Text(info.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.ypBlack)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("E-mail")
                                .foregroundColor(.ypBlack)
                            
                            Text(info.email)
                                .font(.regular12)
                                .foregroundColor(.blueUniversal)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Телефон")
                                .foregroundColor(.ypBlack)
                            
                            Text(info.phone)
                                .font(.regular12)
                                .foregroundColor(.blueUniversal)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
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
                
                ToolbarItem(placement: .principal) {
                    headerView
                }
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Информация о перевозчике")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.ypBlack)
            
            Spacer()
        }
    }
}

