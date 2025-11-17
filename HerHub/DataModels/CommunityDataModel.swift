//
//  CommunityService.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

import Foundation

//final class CommunityService {
//    static let shared = CommunityService()
//    private init() {}
//
//    private var communities: [Community] = []
//
//    // CREATE
//    func createCommunity(name: String, description: String, createdBy: UUID, themeColor: String) -> Community {
//        let newCommunity = Community(
//            id: UUID(),                      // UUID type
//            name: name,
//            description: description,
//            coverImageURL: nil,
//            themeColor: themeColor,
//            createdBy: createdBy,            // UUID type
//            guidelines: [],
//            members: [createdBy],            // [UUID] type
//            createdAt: Date()
//        )
//        communities.append(newCommunity)
//        return newCommunity
//    }
//
//    // READ
//    func getAllCommunities() -> [Community] {
//        return communities
//    }
//
//    func getCommunity(by id: UUID) -> Community? {
//        return communities.first { $0.id == id }
//    }
//
//    // UPDATE
//    func updateCommunity(_ id: UUID, newName: String?, newDescription: String?) {
//        guard let index = communities.firstIndex(where: { $0.id == id }) else { return }
//        if let newName = newName {
//            communities[index].name = newName
//        }
//        if let newDescription = newDescription {
//            communities[index].description = newDescription
//        }
//    }
//
//    // DELETE
//    func deleteCommunity(by id: UUID) {
//        communities.removeAll { $0.id == id }
//    }
//}
