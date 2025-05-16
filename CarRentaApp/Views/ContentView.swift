//
//  ContentView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-02-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .welcome:
                WelcomeView(appState: appState)
            case .rentalForm:
                RentalFormView(appState: appState)
            case .browse:
                BrowseView(appState: appState)
            case .carDetail:
                if let car = appState.selectedCar {
                    CarDetailView(appState: appState, car: car)
                }
            case .payment:
                if let car = appState.selectedCar {
                    PaymentView(appState: appState, car: car)
                }
            case .confirmation:
                ConfirmationView(appState: appState)
            }
        }
    }
}
