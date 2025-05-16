//
//  CarDetailView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-05-15.
//

import SwiftUI

struct CarDetailView: View {
    @ObservedObject var appState: AppState
    let car: Car
    
    // Additional details for each car
    private func getCarDescription() -> String {
        switch car.name {
        case "Rolls-Royce Cullinan":
            return "The pinnacle of luxury SUVs with unmatched comfort and prestige. Features include starlight headliner, champagne cooler, and whisper-quiet V12 engine."
        case "Lamborghini Urus":
            return "The world's first Super Sport Utility Vehicle, combining supercar performance with SUV versatility. 0-60 mph in just 3.6 seconds."
        case "Porsche Cayenne":
            return "Performance-focused luxury SUV with dynamic handling and impressive off-road capability. Perfect blend of sportiness and practicality."
        case "Tesla Model X":
            return "All-electric SUV with falcon-wing doors, autopilot capabilities, and lightning-fast acceleration. Features a minimalist interior with a large touchscreen."
        case "Rolls-Royce Phantom":
            return "The ultimate statement of automotive luxury. Hand-built excellence with a whisper-quiet cabin and the smoothest ride experience possible."
        case "Mercedes-Benz S Class":
            return "The technological tour de force of the automotive world. Cutting-edge features with unsurpassed comfort and safety innovations."
        case "Porsche 911":
            return "The iconic sports car with perfect balance of performance and everyday usability. Precision German engineering in its purest form."
        case "Ferrari 488 Spider":
            return "Open-top driving pleasure with blistering performance. The retractable hardtop transforms from coupe to convertible in just 14 seconds."
        case "Lamborghini Huracan Spyder":
            return "Breathtaking performance paired with the thrill of open-air driving. The naturally-aspirated V10 engine delivers an unforgettable soundtrack."
        case "Audi R8 Spyder":
            return "Everyday supercar with V10 power. Combines striking design with Audi's legendary build quality and all-weather capability."
        default:
            return "Luxury vehicle rental with premium features including leather interior, advanced technology package, and exceptional driving dynamics."
        }
    }
    
    var body: some View {
        VStack {
            // Header with back button
            HStack {
                Button(action: {
                    appState.currentScreen = .browse
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Text(car.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Color.clear
                    .frame(width: 40, height: 10)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Car image
                    Image(car.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    // Rating
                    HStack {
                        ForEach(0..<car.rating) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        
                        Spacer()
                        
                        Text("$\(car.price)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("/day")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    // Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("About")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(getCarDescription())
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    
                    // Category
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Category")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(car.category)
                            .font(.body)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            
            // Book now button
            Button(action: {
                appState.selectedCar = car
                appState.currentScreen = .payment
            }) {
                Text("Book now")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(15)
            }
            .padding()
        }
    }
}
