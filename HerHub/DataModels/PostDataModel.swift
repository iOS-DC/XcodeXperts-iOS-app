//
//  PostService.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

import Foundation
//
//final class PostService {
//    static let shared = PostService()
//    private init() {}
//
//    private var posts: [Post] = []
//
//    // CREATE
//    func createPost(communityID: UUID, authorID: UUID, text: String, imageURL: String? = nil) -> Post {
//        let newPost = Post(
//            id: UUID(),                 // ✅ UUID instead of String
//            communityID: communityID,   // ✅ UUID
//            authorID: authorID,         // ✅ UUID
//            text: text,
//            imageURL: imageURL,
//            likesCount: 0,
//            comments: [],
//            createdAt: Date()
//        )
//        posts.append(newPost)
//        return newPost
//    }
//
//    // READ
//    func getPosts(for communityID: UUID) -> [Post] {
//        return posts.filter { $0.communityID == communityID }
//    }
//
//    // UPDATE (Like)
//    func likePost(postID: UUID) {
//        guard let index = posts.firstIndex(where: { $0.id == postID }) else { return }
//        posts[index].likesCount += 1
//    }
//
//    // DELETE
//    func deletePost(postID: UUID) {
//        posts.removeAll { $0.id == postID }
//    }
//}
