//
//  CommentService.swift
//  HerHub
//
//  Created by Driksha Thakur on 28/10/25.
//

import Foundation

final class CommentService {
    static let shared = CommentService()
    private init() {}

    private var comments: [Comment] = []

    // CREATE
    func addComment(to postID: String, authorID: String, text: String) -> Comment {
        let comment = Comment(
            id: UUID().uuidString,
            postID: postID,
            authorID: authorID,
            text: text,
            createdAt: Date()
        )
        comments.append(comment)
        return comment
    }

    // READ
    func getComments(for postID: String) -> [Comment] {
        return comments.filter { $0.postID == postID }
    }

    // UPDATE
    func editComment(commentID: String, newText: String) {
        guard let index = comments.firstIndex(where: { $0.id == commentID }) else { return }
        comments[index].text = newText
    }

    // DELETE
    func deleteComment(commentID: String) {
        comments.removeAll { $0.id == commentID }
    }
}
