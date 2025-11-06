//
//  ResourceModel.swift
//  HerHub
//
//  Created by mahika behal on 28/10/25.
//

import Foundation

// MARK: - Resource Model
struct Resource: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var category: ResourceCategory
    var articles: [Article]
    var isBookmarked: Bool = false
}

enum ResourceCategory: String, Codable, CaseIterable {
    case menstrualHealth = "Understanding Your Menstrual Cycle"
    case mentalHealth = "Mental Health & Yoga Cycle"
    case nutrition = "Nutrition During Your Cycle"
}

// MARK: - Article Model
struct Article: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var chapter: String
    var content: String
    var author: String
    var estimatedReadTime: String
    var imageURL: String?
    var isLiked: Bool = false
}
