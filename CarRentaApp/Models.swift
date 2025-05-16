//
//  Models.swift
//  CarRentaApp
//
//  Created by Carlos Alleng on 2025-03-06.
//

//import SwiftUI
//
//struct Car: Identifiable {
//    let id: Int
//    let name: String
//    let price: Int
//    let rating: Int
//    let category: String
//    let highlight: Bool
//}
//
//struct CreditCard: Identifiable {
//    let id: Int
//    let last4: String
//    let brand: String
//    let expiry: String
//    let isPrimary: Bool
//}
//
//struct UserInfo {
//    var firstName: String
//    var lastName: String
//    var address: String
//    var contactNumber: String
//    var province: String
//    var licenseNumber: String
//}
//
//class AppState: ObservableObject {
//    @Published var currentScreen: Screen = .welcome
//    @Published var selectedCar: Car?
//    @Published var userInfo: UserInfo?
//    
//    enum Screen {
//        case welcome
//        case rentalForm
//        case browse
//        case carDetail
//        case payment
//    }
//}


import SwiftUI

struct Car: Identifiable {
    let id: Int
    let name: String
    let price: Int
    let rating: Int
    let category: String
    let highlight: Bool
}

struct CreditCard: Identifiable {
    let id: Int
    let last4: String
    let brand: String
    let expiry: String
    let isPrimary: Bool
}

struct UserInfo {
    var firstName: String
    var lastName: String
    var address: String
    var contactNumber: String
    var province: String
    var licenseNumber: String
}

class AppState: ObservableObject {
    @Published var currentScreen: Screen = .welcome
    @Published var selectedCar: Car?
    @Published var userInfo: UserInfo?
    
    enum Screen {
        case welcome
        case rentalForm
        case browse
        case carDetail
        case payment
        case confirmation // Added new case for confirmation screen
    }
}
