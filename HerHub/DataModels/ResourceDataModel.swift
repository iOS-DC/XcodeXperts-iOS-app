
//
//  ResourceManager.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//

import Foundation

class ResourceManager {
    static let shared = ResourceManager()
    
    private let documentsDirectory: URL
    private let archiveURL: URL
    private var resources: [Resource] = []
    
    private init() {
        // Locate app's Documents directory
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        archiveURL = documentsDirectory.appendingPathComponent("Resources").appendingPathExtension("plist")
        
        loadResources()
    }
    
    // MARK: - Public Access
    func getAllResources() -> [Resource] {
        return resources
    }
    
    func addResource(_ resource: Resource) {
        resources.append(resource)
        saveResources()
    }
    
    func updateResource(_ resource: Resource) {
        if let index = resources.firstIndex(where: { $0.id == resource.id }) {
            resources[index] = resource
            saveResources()
        }
    }
    
    func deleteResource(at index: Int) {
        resources.remove(at: index)
        saveResources()
    }
    
    func toggleBookmark(for id: UUID) {
        if let index = resources.firstIndex(where: { $0.id == id }) {
            resources[index].isBookmarked.toggle()
            saveResources()
        }
    }
    
    func toggleLike(for id: UUID) {
        if let index = resources.firstIndex(where: { $0.id == id }) {
            resources[index].isLiked.toggle()
            saveResources()
        }
    }
    
    // MARK: - Persistence
    private func loadResources() {
        if let savedResources = loadResourcesFromDisk() {
            resources = savedResources
        } else {
            resources = loadSampleResources()
            saveResources() // Save sample on first run
        }
    }
    
    private func loadResourcesFromDisk() -> [Resource]? {
        guard let codedData = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Resource].self, from: codedData)
    }
    
    private func saveResources() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let codedData = try? encoder.encode(resources) {
            try? codedData.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    // MARK: - Sample Data
    private func loadSampleResources() -> [Resource] {
        let resource1 = Resource(
            title: "Understanding Your Menstrual Cycle",
            description: "Learn how your hormones change throughout your cycle.",
            category: .menstrualHealth,
            content: """
            Your menstrual cycle is divided into four main phases: menstrual, follicular, ovulation, and luteal.
            Each phase affects your energy, mood, and health differently.
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
            Yoga and breathing exercises can help regulate hormonal balance and improve mental health.
            """,
            author: "Dr. Meera Sharma",
            estimatedReadTime: "6 min read",
            imageURL: "mental_health_image"
        )
        
        let resource3 = Resource(
            title: "Nutrition During Your Cycle",
            description: "Learn what foods help boost energy at each menstrual phase.",
            category: .nutrition,
            content: """
            Nutrition plays a vital role in hormone regulation. Each phase of your cycle can benefit from specific foods.
            """,
            author: "Nutritionist Ananya Rao",
            estimatedReadTime: "7 min read",
            imageURL: "nutrition_image"
        )
        
        return [resource1, resource2, resource3]
    }
}
