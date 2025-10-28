//
//  CommunityModels.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

import Foundation
import UIKit

// MARK: - COMMUNITY MODEL
struct Community: Codable, Identifiable {
    let id: String
    var name: String
    var description: String
    var coverImageURL: String?
    var themeColor: String // For UI tint (pink, blue, green, etc.)
    var createdBy: String  // userID (reference to User)
    var guidelines: [Guideline]
    var members: [String]  // userIDs
    var createdAt: Date
}

// MARK: - GUIDELINE MODEL
struct Guideline: Codable, Identifiable {
    let id: String
    var title: String
    var description: String
    var iconName: String? // Optional SF Symbol for UI
}

// MARK: - POST MODEL
struct Post: Codable, Identifiable {
    let id: String
    var communityID: String
    var authorID: String  // Link to User.id
    var text: String
    var imageURL: String?
    var likesCount: Int
    var comments: [Comment]
    var createdAt: Date
}

// MARK: - COMMENT MODEL
struct Comment: Codable, Identifiable {
    let id: String
    var postID: String
    var authorID: String  // Link to User.id
    var text: String
    var createdAt: Date
}

// MARK: - SAMPLE DATA (for Preview / Testing)
extension Community {
    static let sample = Community(
        id: UUID().uuidString,
        name: "First Period Support",
        description: "A safe space to talk and share about first period experiences.",
        coverImageURL: "sample_cover_image",
        themeColor: "pink",
        createdBy: "user1",
        guidelines: [
            Guideline(id: UUID().uuidString, title: "Be Respectful", description: "Support others without judgment.", iconName: "heart.fill"),
            Guideline(id: UUID().uuidString, title: "Stay Private", description: "Don’t share personal contact info.", iconName: "lock.fill")
        ],
        members: ["user1", "user2", "user3"],
        createdAt: Date()
    )
}
