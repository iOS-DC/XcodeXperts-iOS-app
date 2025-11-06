//
//  CommunityService.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

import Foundation

final class CommunityService {
    static let shared = CommunityService()
    private init() {}

    private var communities: [Community] = []

    // CREATE
    func createCommunity(name: String, description: String, createdBy: String, themeColor: String) -> Community {
        let newCommunity = Community(
            id: UUID().uuidString,
            name: name,
            description: description,
            coverImageURL: nil,
            themeColor: themeColor,
            createdBy: createdBy,
            guidelines: [],
            members: [createdBy],
            createdAt: Date()
        )
        communities.append(newCommunity)
        return newCommunity
    }

    // READ
    func getAllCommunities() -> [Community] {
        return communities
    }

    func getCommunity(by id: String) -> Community? {
        return communities.first { $0.id == id }
    }

    // UPDATE
    func updateCommunity(_ id: String, newName: String?, newDescription: String?) {
        guard let index = communities.firstIndex(where: { $0.id == id }) else { return }
        if let newName = newName { communities[index].name = newName }
        if let newDescription = newDescription { communities[index].description = newDescription }
    }

    // DELETE
    func deleteCommunity(by id: String) {
        communities.removeAll { $0.id == id }
    }
}
