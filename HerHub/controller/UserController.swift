//
//  UserController.swift
//  HerHub
//
//  Created by Dhruv on 11/11/25.
//

import Foundation

final class UserController {
    
    static let shared = UserController()
    private let manager = UserDataManager()
    private init() {}
    
    // MARK: - Create New User
    func registerUser(_ user: User) async throws {
        try await manager.createUser(user)
    }
    
    // MARK: - Login / Fetch by Email
    func loginUser(email: String, password: String) async throws -> User? {
        guard let user = try await manager.fetchUser(byEmail: email) else { return nil }
        return user.password == password ? user : nil
    }
    
    // MARK: - Fetch All Users (Admin / Debug)
    func getAllUsers() async throws -> [User] {
        try await manager.fetchAllUsers()
    }
    
    // MARK: - Update User (for profile edits)
    func updateUser(_ user: User) async throws {
        try await manager.updateUser(user)
    }
    
    // MARK: - Delete User
    func deleteUser(byID id: UUID) async throws {
        try await manager.deleteUser(byID: id)
    }
}
