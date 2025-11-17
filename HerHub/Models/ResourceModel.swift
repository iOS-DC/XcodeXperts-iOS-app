//
//  ResourceModel.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//

import Foundation

// MARK: - Resource Model
struct Resource: Codable, Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String
    var category: ResourceCategory
    var content: String
    var author: String
    var estimatedReadTime: String
    var imageURL: String?
    var isBookmarked: Bool
    var isLiked: Bool
    
    init(
        title: String,
        description: String,
        category: ResourceCategory,
        content: String,
        author: String,
        estimatedReadTime: String,
        imageURL: String? = nil,
        isBookmarked: Bool = false,
        isLiked: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.category = category
        self.content = content
        self.author = author
        self.estimatedReadTime = estimatedReadTime
        self.imageURL = imageURL
        self.isBookmarked = isBookmarked
        self.isLiked = isLiked
    }
}

enum ResourceCategory: String, Codable, CaseIterable {
    case featured = "Featured"
    case health = "Health"
    case wellness = "Wellness"
    case lifestyle = "Lifestyle"
    case fitness = "Fitness"
    case skincare = "Skincare"
}
