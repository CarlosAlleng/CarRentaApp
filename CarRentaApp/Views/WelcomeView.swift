//
//  WelcomeView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-03-06.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            Image("WelcomeImage") // background image
                .resizable()
                .edgesIgnoringSafeArea(.all) // Ensure the image covers the entire screen
            
            VStack {
                // Added more spacing at the top
                Spacer()
                    .frame(height: 80)
                
                // Title section moved down
                VStack(alignment: .center, spacing: 1) {
                    Text("Miles Car Rental")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .padding(15)
                    
                    Text("Rent the car of your dreams")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
                .padding(10)
                
                // Add flexible space to push content down
                Spacer()
                
                Button(action: {
                    // Changed to navigate to the rental form instead of browse
                    appState.currentScreen = .rentalForm
                }) {
                    Text("Get started")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding()
            }
        }
    }
}
