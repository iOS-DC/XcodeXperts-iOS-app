//
//  UserModel.swift
//  HerHub
//
//  Created by Nihar Sandhu on 28/10/25.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID().uuidString
    var email: String?
    var phoneNumber: String?
    var password: String
    
    // MARK: - Linked Cycle Data
    var baselineProfile: CycleBaselineProfile?   // Set 1 — asked once
    var recentCheckIns: [CycleCheckIn]?          // Set 2 — asked every cycle
    var latestPrediction: CyclePrediction?       // holds current forecast data
}

// MARK: - Sample User for Testing / SwiftUI Preview
extension User {
    static let sample = User(
        email: "nihar@herhub.app",
        phoneNumber: "+91 99999 99999",
        password: "herhub123",
        baselineProfile: CycleBaselineProfile.sample,
        recentCheckIns: [CycleCheckIn.sample],
        latestPrediction: CyclePrediction.sample
    )
}
