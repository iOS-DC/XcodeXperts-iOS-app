import Foundation
import UIKit

// MARK: - COMMUNITY MODEL
//struct Community: Codable, Identifiable {
//    let id: UUID
//    var name: String
//    var description: String
//    var coverImageURL: String?
//    var themeColor: String
//    var createdBy: UUID
//    var guidelines: [Guideline]
//    var members: [UUID]
//    var createdAt: Date
//}
//
//// MARK: - GUIDELINE MODEL
//struct Guideline: Codable, Identifiable {
//    let id: UUID
//    var title: String
//    var description: String
//    var iconName: String?
//}
//
//// MARK: - POST MODEL
//struct Post: Codable, Identifiable {
//    let id: UUID
//    var communityID: UUID
//    var authorID: UUID
//    var text: String
//    var imageURL: String?
//    var likesCount: Int
//    var comments: [Comment]
//    var createdAt: Date
//}
//
//// MARK: - COMMENT MODEL
//struct Comment: Codable, Identifiable {
//    let id: UUID
//    var postID: UUID
//    var authorID: UUID
//    var text: String
//    var createdAt: Date
//}
//
//// MARK: - SAMPLE DATA (for Preview / Testing)
//extension Community {
//    static let sample = Community(
//        id: UUID(),
//        name: "First Period Support",
//        description: "A safe space to talk and share about first period experiences.",
//        coverImageURL: "sample_cover_image",
//        themeColor: "pink",
//        createdBy: UUID(),
//        guidelines: [
//            Guideline(id: UUID(), title: "Be Respectful", description: "Support others without judgment.", iconName: "heart.fill"),
//            Guideline(id: UUID(), title: "Stay Private", description: "Don’t share personal contact info.", iconName: "lock.fill")
//        ],
//        members: [UUID(), UUID(), UUID()],
//        createdAt: Date()
//    )
//}
