//
//  userModel.swift
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
    var cycleProfile: CycleProfile?
}
