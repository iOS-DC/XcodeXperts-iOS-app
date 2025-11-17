
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
//    private func loadResources() {
//        if let savedResources = loadResourcesFromDisk() {
//            resources = savedResources
//        } else {
//            resources = loadSampleResources()
//            saveResources() // Save sample on first run
//        }
//    }
    private func loadResources() {
        // Always load fresh sample data for now
        resources = loadSampleResources()
        saveResources()
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
    // MARK: - Sample Data
    private func loadSampleResources() -> [Resource] {
        return [
            Resource(
                title: "Understanding Your Menstrual Cycle",
                description: "A comprehensive guide to understanding the four phases of your menstrual cycle and what to expect.",
                category: .featured,
                content: "Your menstrual cycle is divided into four phases: menstrual, follicular, ovulation, and luteal. Each affects your body differently.",
                author: "HerHub Experts",
                estimatedReadTime: "5 min read",
                imageURL: "menstrual_cycle_image"
            ),
            Resource(
                title: "Mental Health & Yoga Cycle",
                description: "Discover how yoga and mindfulness can help manage PMS symptoms and improve overall well-being.",
                category: .health,
                content: "Yoga helps manage stress hormones and supports emotional health throughout your cycle.",
                author: "Dr. Meera Sharma",
                estimatedReadTime: "5 min read",
                imageURL: "yoga_cycle_image"
            ),
            Resource(
                title: "Nutrition During Your Cycle",
                description: "Learn about the best foods to eat during different phases of your cycle for optimal health.",
                category: .wellness,
                content: "Each menstrual phase benefits from specific nutrients that can support hormone balance.",
                author: "Nutritionist Ananya Rao",
                estimatedReadTime: "6 min read",
                imageURL: "nutrition_image"
            ),
            Resource(
                title: "Exercise and Your Hormones",
                description: "Learn how to adjust your workout routine to work with your hormonal changes.",
                category: .fitness,
                content: "Sync your workouts with your hormone levels for better results and less fatigue.",
                author: "Fitness Coach Priya Singh",
                estimatedReadTime: "7 min read",
                imageURL: "exercise_hormones_image"
            ),
            Resource(
                title: "Sleep and Hormonal Balance",
                description: "Understanding the connection between quality sleep and hormonal health.",
                category: .wellness,
                content: "Proper rest regulates hormones and keeps your menstrual cycle consistent.",
                author: "HerHub Experts",
                estimatedReadTime: "6 min read",
                imageURL: "sleep_balance_image"
            ),
            Resource(
                title: "Managing PMS Naturally",
                description: "Natural remedies and lifestyle changes to help manage PMS symptoms effectively.",
                category: .lifestyle,
                content: "Simple self-care practices and nutrition adjustments can reduce PMS discomfort.",
                author: "HerHub Experts",
                estimatedReadTime: "7 min read",
                imageURL: "pms_management_image"
            ),
           
            Resource(
                title: "Hormonal Acne Solutions",
                description: "Understanding and treating hormonal acne with natural and medical approaches.",
                category: .skincare,
                content: "Learn about effective routines and ingredients that balance hormones and improve skin health.",
                author: "Dr. Aarohi Mehta",
                estimatedReadTime: "6 min read",
                imageURL: "hormonal_acne_image"
            )
        ]
    }

}
