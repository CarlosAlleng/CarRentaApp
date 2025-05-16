//
//  RentalFormView.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-05-15.
//

import SwiftUI

struct RentalFormView: View {
    @ObservedObject var appState: AppState
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var address = ""
    @State private var contactNumber = ""
    @State private var province = ""
    @State private var licenseNumber = ""
    
    @State private var showErrorMessage = false
    
    // Check if all fields are filled
    private var isFormComplete: Bool {
        !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !contactNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !province.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !licenseNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Button(action: {
                    appState.currentScreen = .welcome
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Text("Rental Information")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Empty view for alignment
                Color.clear
                    .frame(width: 40, height: 10)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Form fields
                    VStack(alignment: .leading) {
                        Text("Personal Information")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        
                        FormField(title: "First Name", text: $firstName)
                        FormField(title: "Last Name", text: $lastName)
                        FormField(title: "Address", text: $address)
                        FormField(title: "Contact Number", text: $contactNumber)
                            .keyboardType(.phonePad)
                        FormField(title: "Province", text: $province)
                        FormField(title: "License Number", text: $licenseNumber)
                    }
                    .padding()
                    
                    if showErrorMessage && !isFormComplete {
                        Text("Please fill in all fields")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.bottom)
                    }
                    
                    Spacer()
                }
            }
            
            // Next button
            Button(action: {
                if isFormComplete {
                    // Save user info to app state if needed
                    appState.userInfo = UserInfo(
                        firstName: firstName,
                        lastName: lastName,
                        address: address,
                        contactNumber: contactNumber,
                        province: province,
                        licenseNumber: licenseNumber
                    )
                    
                    // Navigate to browse screen
                    appState.currentScreen = .browse
                } else {
                    showErrorMessage = true
                }
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormComplete ? Color.yellow : Color.gray.opacity(0.5))
                    .cornerRadius(15)
            }
            .disabled(!isFormComplete)
            .padding()
        }
    }
}

struct FormField: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField(title, text: $text)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(keyboardType)
        }
    }
}
