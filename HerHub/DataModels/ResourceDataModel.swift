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
    func addResource(_ resource: Resource) {
        resources.append(resource)
    }

    func getAllResources() -> [Resource] {
        return resources
    }

    func getResource(by id: UUID) -> Resource? {
        return resources.first { $0.id == id }
    }

    func updateResource(_ updatedResource: Resource) {
        if let index = resources.firstIndex(where: { $0.id == updatedResource.id }) {
            resources[index] = updatedResource
        }
    }

    func deleteResource(by id: UUID) {
        resources.removeAll { $0.id == id }
    }

    // MARK: - Bookmark / Like
    func toggleBookmark(for id: UUID) {
        guard let index = resources.firstIndex(where: { $0.id == id }) else { return }
        resources[index].isBookmarked.toggle()
    }

    func toggleLike(for id: UUID) {
        guard let index = resources.firstIndex(where: { $0.id == id }) else { return }
        resources[index].isLiked.toggle()
    }

    // MARK: - Sample Data
    func loadSampleData() {
        let resource1 = Resource(
            title: "Understanding Your Menstrual Cycle",
            description: "Learn how your hormones change throughout your cycle.",
            category: .menstrualHealth,
            content: """
            Your menstrual cycle is divided into four main phases: menstrual, follicular, ovulation, and luteal.
            Each phase affects your energy, mood, and health differently...
            """,
            author: "HerHub Editorial Team",
            estimatedReadTime: "5 min read",
            imageURL: "menstrual_cycle_image"
        )

        let resource2 = Resource(
            title: "Mental Health & Yoga Cycle",
            description: "Discover how mindfulness and yoga balance hormones.",
            category: .mentalHealth,
            content: """
            Yoga and breathing exercises can help regulate hormonal balance and improve mental health...
            """,
            author: "Dr. Meera Sharma",
            estimatedReadTime: "6 min read",
            imageURL: "mental_health_image"
        )

        resources = [resource1, resource2]
    }
}
