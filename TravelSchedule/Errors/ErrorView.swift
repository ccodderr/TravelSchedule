//
//  ErrorView.swift
//  TravelSchedule
//
//  Created by Yana Silosieva on 15.06.2025.
//

import SwiftUI

struct ErrorView: View {
    let errorType: ErrorTypeModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(spacing: 16) {
                errorType.image
                    .resizable()
                    .frame(width: 223, height: 223)
                
                Text(errorType.message)
                    .font(.bold24)
                    .foregroundStyle(Color.ypBlack)
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(errorType: .noInternetConnection)
}
