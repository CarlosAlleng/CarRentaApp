//
//  PaymentView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-03-06.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var appState: AppState
    let car: Car
    @State private var selectedCard: CreditCard?
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400) // Default to 1 day
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    
    let cards = [
        CreditCard(id: 1, last4: "7920", brand: "mastercard", expiry: "06/25", isPrimary: true)
    ]
    
    // Date formatter for displaying dates
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // Calculate number of days between start and end date
    private var numberOfDays: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return max(components.day ?? 1, 1) // Ensure at least 1 day
    }
    
    // Calculate total price based on car's daily rate and number of days
    private var totalPrice: Int {
        return car.price * numberOfDays
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {
                    appState.currentScreen = .browse
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Spacer()
                Text("Your Cards")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .padding()
            
            // Rental Period Selection
            VStack(alignment: .leading, spacing: 16) {
                Text("Rental Period")
                    .font(.headline)
                    .fontWeight(.bold)
                
                // Start Date Selector
                Button(action: {
                    showStartDatePicker.toggle()
                }) {
                    HStack {
                        Text("From")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(dateFormatter.string(from: startDate))
                            .foregroundColor(.primary)
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                if showStartDatePicker {
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        in: Date()...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: startDate) { _ in
                        // If start date is after end date, update end date
                        if startDate >= endDate {
                            endDate = startDate.addingTimeInterval(86400) // Add 1 day
                        }
                        showStartDatePicker = false
                    }
                }
                
                // End Date Selector
                Button(action: {
                    showEndDatePicker.toggle()
                }) {
                    HStack {
                        Text("To")
                            .foregroundColor(.gray)
                        Spacer()
                        Text(dateFormatter.string(from: endDate))
                            .foregroundColor(.primary)
                        Image(systemName: "calendar")
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                if showEndDatePicker {
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        in: startDate...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .onChange(of: endDate) { _ in
                        showEndDatePicker = false
                    }
                }
                
                // Show rental duration
                HStack {
                    Text("Duration")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(numberOfDays) \(numberOfDays == 1 ? "day" : "days")")
                        .fontWeight(.medium)
                }
                .padding(.top, 8)
            }
            .padding()
            
            // Cards
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(cards) { card in
                        CreditCardView(card: card, isSelected: selectedCard?.id == card.id)
                            .onTapGesture {
                                selectedCard = card
                            }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            // Payment Summary
            VStack(spacing: 16) {
                HStack {
                    Text(car.name)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("$\(car.price) × \(numberOfDays)")
                        .fontWeight(.medium)
                }
                
                Divider()
                
                HStack {
                    Text("Total")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(totalPrice)")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                Button(action: {
                    // Navigate to confirmation screen when Pay Now is clicked
                    appState.currentScreen = .confirmation
                }) {
                    Text("Pay now")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
    }
}

struct CreditCardView: View {
    let card: CreditCard
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Primary Card")
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
                if card.brand == "mastercard" {
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                            .opacity(0.8)
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 20, height: 20)
                            .opacity(0.8)
                    }
                }
            }
            
            Text("•••• •••• •••• \(card.last4)")
                .font(.title2)
                .foregroundColor(isSelected ? .white : .primary)
            
            Text(card.expiry)
                .foregroundColor(isSelected ? .white : .gray)
        }
        .padding()
        .background(isSelected ? Color.black : Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}
