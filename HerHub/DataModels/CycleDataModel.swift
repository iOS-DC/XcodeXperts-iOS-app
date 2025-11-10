//
//  UserDataModel.swift
//  HerHub
//
//  Created by Dhruv on 10/11/25.
//
import Foundation

final class CycleDataController {
    
    // Singleton pattern for easy use
    static let shared = CycleDataController()
    private let manager = CycleDataManager()
    
    private init() {}
    
    // MARK: - Public APIs
    
    // Upload the user's baseline profile
    func uploadBaselineProfile(_ profile: CycleBaselineProfile) async throws {
        try await manager.saveBaselineProfile(profile)
    }
    
    // Fetch baseline data (return optional single record)
    func getBaselineProfile() async throws -> CycleBaselineProfile? {
        let profiles = try await manager.fetchBaselineProfile()
        return profiles.first
    }
    
    // Upload a new cycle check-in
    func uploadCheckIn(_ checkIn: CycleCheckIn) async throws {
        try await manager.saveCheckIn(checkIn)
    }
    
    // Get all past check-ins
    func getCheckIns() async throws -> [CycleCheckIn] {
        try await manager.fetchCheckIns()
    }
    
    // Upload a new prediction record
    func uploadPrediction(_ prediction: CyclePrediction) async throws {
        try await manager.savePrediction(prediction)
    }
    
    // Fetch recent predictions
    func getPredictions() async throws -> [CyclePrediction] {
        try await manager.fetchPredictions()
    }
}
