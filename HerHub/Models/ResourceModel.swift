//
//  ResourceModel.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//

import Foundation

// MARK: - Resource Model
struct Resource: Codable, Identifiable, Equatable {
    var id = UUID()                    // Unique ID for each resource
    var title: String                  // Title shown on card (e.g. “Mental Health & Yoga”)
    var description: String            // Short summary shown under the title
    var category: ResourceCategory     // Used for filtering/sorting if needed
    var content: String                // Full text shown after tapping on resource
    var author: String                 // Name of author or editor
    var estimatedReadTime: String      // e.g. “5 min read”
    var imageURL: String?              // Optional image shown on the card/article page
    var isBookmarked: Bool = false     // Whether user bookmarked it
    var isLiked: Bool = false          // Whether user liked it
}

// MARK: - Category Enum
enum ResourceCategory: String, Codable, CaseIterable {
    case menstrualHealth = "Understanding Your Menstrual Cycle"
    case mentalHealth = "Mental Health & Yoga Cycle"
    case nutrition = "Nutrition During Your Cycle"
}
