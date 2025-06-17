//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 14.06.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Toggle("Темная тема", isOn: $isDarkMode)
                
                NavigationLink(destination: TermsOfUseView()) {
                    HStack {
                        Text("Пользовательское соглашение")
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Text("Приложение использует API «Яндекс.Расписания»")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("Версия 1.0 (beta)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            SettingsView()
//        }
//    }
//}
