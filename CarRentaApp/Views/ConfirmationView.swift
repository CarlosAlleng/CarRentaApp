//
//  ConfirmationView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-05-16.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Full-screen confirmation image with proper scaling
            Image("ConfirmationImage")
                .resizable()
                .scaledToFit() // Changed from .fill to .fit to ensure entire content is visible
                .frame(maxWidth: .infinity)
                .padding(.vertical) // Add some padding to ensure no content is cut off
                .background(Color.white) // Add background color to fill any empty space
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Button to return to welcome screen
                Button(action: {
                    appState.currentScreen = .welcome
                }) {
                    Text("Return Home")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 3) // Add shadow to make button stand out
                }
                .padding(.bottom, 60)
            }
        }
    }
}

