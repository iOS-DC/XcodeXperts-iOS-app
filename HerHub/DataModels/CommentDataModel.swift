//
//  CommentService.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

//import Foundation
//
//final class CommentService {
//    static let shared = CommentService()
//    private init() {}
//
//    private var comments: [Comment] = []
//
//    // CREATE
//    func addComment(to postID: UUID, authorID: UUID, text: String) -> Comment {
//        let comment = Comment(
//            id: UUID(),               // now UUID type
//            postID: postID,
//            authorID: authorID,
//            text: text,
//            createdAt: Date()
//        )
//        comments.append(comment)
//        return comment
//    }
//
//    // READ
//    func getComments(for postID: UUID) -> [Comment] {
//        return comments.filter { $0.postID == postID }
//    }
//
//    // UPDATE
//    func editComment(commentID: UUID, newText: String) {
//        guard let index = comments.firstIndex(where: { $0.id == commentID }) else { return }
//        comments[index].text = newText
//    }
//
//    // DELETE
//    func deleteComment(commentID: UUID) {
//        comments.removeAll { $0.id == commentID }
//    }
//}
