//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
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
                Toggle("Темная тема", isOn: $isDarkMode)
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
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypBlack)
                    
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.ypBlack)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 24)
            }
        }
    }
}
