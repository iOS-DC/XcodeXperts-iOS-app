//
//  ResourceManager.swift
//  HerHub
//
//  Created by mahika behal on 28/10/25.
//

import Foundation
//
//  ResourceManager.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//

import Foundation

final class ResourceManager {
    static let shared = ResourceManager()
    private init() {}

    // MARK: - Local Resource Storage
    private(set) var resources: [Resource] = []

    // MARK: - CRUD Operations

    // Create
    func addResource(_ resource: Resource) {
        resources.append(resource)
    }

    // Read
    func getAllResources() -> [Resource] {
        return resources
    }

    func getResource(by id: UUID) -> Resource? {
        return resources.first { $0.id == id }
    }

    // Update
    func updateResource(_ updatedResource: Resource) {
        if let index = resources.firstIndex(where: { $0.id == updatedResource.id }) {
            resources[index] = updatedResource
        }
    }

    // Delete
    func deleteResource(by id: UUID) {
        resources.removeAll { $0.id == id }
    }

    // MARK: - Bookmark / Like Handling
    func toggleBookmark(for id: UUID) {
        guard let index = resources.firstIndex(where: { $0.id == id }) else { return }
        resources[index].isBookmarked.toggle()
    }

    func toggleArticleLike(resourceID: UUID, articleID: UUID) {
        guard let rIndex = resources.firstIndex(where: { $0.id == resourceID }) else { return }
        guard let aIndex = resources[rIndex].articles.firstIndex(where: { $0.id == articleID }) else { return }
        resources[rIndex].articles[aIndex].isLiked.toggle()
    }

    // MARK: - Dummy Data
    func loadSampleData() {
        let article1 = Article(
            title: "Mental Health & Your Cycle",
            chapter: "Chapter 3: Managing Mood Changes",
            content: """
            Learn how mood changes throughout your menstrual cycle affect your emotions and confidence. 
            Includes tips for stress management, self-care, and mindfulness.
            """,
            author: "HerHub Editorial Team",
            estimatedReadTime: "5 min read",
            imageURL: "mental_health_image"
        )

        let article2 = Article(
            title: "Understanding Your Menstrual Cycle",
            chapter: "Chapter 2: What’s Normal Period Pain?",
            content: """
            Understanding period pain and how hormones change during each phase. 
            Learn when to seek help and how to manage discomfort naturally.
            """,
            author: "Dr. Meera Sharma",
            estimatedReadTime: "6 min read",
            imageURL: "menstrual_cycle_image"
        )

        let article3 = Article(
            title: "Nutrition During Your Cycle",
            chapter: "Chapter 4: Eating for Each Phase",
            content: """
            Discover what foods support your energy and mood during each phase 
            of your menstrual cycle — from follicular to luteal.
            """,
            author: "Nutritionist Ananya Rao",
            estimatedReadTime: "7 min read",
            imageURL: "nutrition_image"
        )

        let resource1 = Resource(
            title: "Understanding Your Menstrual Cycle",
            description: "Learn about the phases and symptoms of your cycle.",
            category: .menstrualHealth,
            articles: [article2]
        )

        let resource2 = Resource(
            title: "Mental Health & Yoga Cycle",
            description: "Explore how mindfulness and yoga help balance hormones.",
            category: .mentalHealth,
            articles: [article1]
        )

        let resource3 = Resource(
            title: "Nutrition During Your Cycle",
            description: "Know what foods to eat in each menstrual phase.",
            category: .nutrition,
            articles: [article3]
        )

        resources = [resource1, resource2, resource3]
    }
}
