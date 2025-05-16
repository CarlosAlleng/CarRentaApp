//
//  BrowseView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-03-06.
//

import SwiftUI

struct BrowseView: View {
    @ObservedObject var appState: AppState
    @State private var selectedCategory = "SUV"
    
    let categories = ["SUV", "Sedan", "Convertible"]
    let cars: [Car] = [
        Car(id: 1, name: "Rolls-Royce Cullinan", price: 2500, rating: 5, category: "SUV", highlight: true),
        Car(id: 2, name: "Lamborghini Urus", price: 1800, rating: 5, category: "SUV", highlight: true),
        Car(id: 3, name: "Rolls-Royce Phantom", price: 1900, rating: 5, category: "Sedan", highlight: false),
        Car(id: 4, name: "Bentley Continental GT", price: 1500, rating: 4, category: "Sedan", highlight: false),
        Car(id: 5, name: "Audi Q7", price: 1200, rating: 4, category: "SUV", highlight: false),
        Car(id: 6, name: "BMW X5", price: 1300, rating: 4, category: "SUV", highlight: false),
        Car(id: 7, name: "Mercedes-Benz GLE", price: 1400, rating: 4, category: "SUV", highlight: false),
        Car(id: 8, name: "Porsche Cayenne", price: 1600, rating: 5, category: "SUV", highlight: true),
        Car(id: 9, name: "Tesla Model X", price: 1700, rating: 5, category: "SUV", highlight: true),
        Car(id: 10, name: "Audi A4", price: 1100, rating: 4, category: "Sedan", highlight: false),
        Car(id: 11, name: "BMW 3 Series", price: 1000, rating: 4, category: "Sedan", highlight: false),
        Car(id: 12, name: "Mercedes-Benz C-Class", price: 1050, rating: 4, category: "Sedan", highlight: false),
        Car(id: 13, name: "Porsche 911", price: 2000, rating: 5, category: "Convertible", highlight: true),
        Car(id: 14, name: "Ferrari 488 Spider", price: 2200, rating: 5, category: "Convertible", highlight: true),
        Car(id: 15, name: "Lamborghini Huracan Spyder", price: 2300, rating: 5, category: "Convertible", highlight: true),
        Car(id: 16, name: "Audi R8 Spyder", price: 2100, rating: 5, category: "Convertible", highlight: true),
        Car(id: 17, name: "BMW Z4", price: 1500, rating: 4, category: "Convertible", highlight: false),
        Car(id: 18, name: "Mercedes-Benz S Class", price: 1900, rating: 5, category: "Sedan", highlight: true),
        Car(id: 19, name: "Lexus LC 500 Convertible", price: 1500, rating: 4, category: "Convertible", highlight: false)
    ]
    
    var body: some View {
        VStack {
            // Header with back button - Updated to navigate to rental form
            HStack {
                Button(action: {
                    // Changed to navigate back to rental form instead of welcome screen
                    appState.currentScreen = .rentalForm
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Text("Browse Cars")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Empty view for alignment
                Color.clear
                    .frame(width: 60, height: 10)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Spacer()
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(
                                            selectedCategory == category ?
                                                Color.yellow.opacity(0.2) :
                                                Color.gray.opacity(0.1)
                                        )
                                        .cornerRadius(20)
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                    
                    // Car Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(cars.filter { $0.category == selectedCategory }) { car in
                            CarCard(car: car)
                                .onTapGesture {
                                    appState.selectedCar = car
                                    appState.currentScreen = .carDetail
                                }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct CarCard: View {
    let car: Car
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<car.rating) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                }
                Spacer()
                Text("360°")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Display the car image using the car's name
            Image(car.name) // Ensure the image name matches the car's name in Assets.xcassets
                .resizable()
                .aspectRatio(1.5, contentMode: .fit)
                .cornerRadius(10)
            
            Text(car.name)
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack(alignment: .firstTextBaseline) {
                Text("$\(car.price)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("/day")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(car.highlight ? Color.yellow.opacity(0.1) : Color.gray.opacity(0.05))
        .cornerRadius(20)
    }
}


