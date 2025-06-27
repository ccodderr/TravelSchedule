//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            switch viewModel.mode {
            case .content:
                contentView
                    .padding(.horizontal)
            case .error(let type):
                ErrorView(errorType: type)
            }
        }
    }
}

private extension SettingsView {
    var contentView: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Toggle("Темная тема", isOn: $viewModel.isDarkMode)
                    .padding()
                    .tint(.blueUniversal)
                
                NavigationLink(destination: TermsOfUseView()) {
                    HStack {
                        Text("Пользовательское соглашение")
                            .foregroundColor(.ypBlack)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.ypBlack)
                    }
                    .padding()
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                        .font(.regular12)
                        .foregroundColor(.ypBlack)
                    
                    Text("Версия 1.0 (beta)")
                        .font(.regular12)
                        .foregroundColor(.ypBlack)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            }
        }
    }
}
