//
//  UserDataModel.swift
//  HerHub
//
//  Created by Dhruv on 10/11/25.
//
import Foundation

final class CycleDataController {
    
    // Singleton
    static let shared = CycleDataController()
    private let manager = CycleDataManager()
    
    private init() {}
    
    // MARK: - Baseline Profile
    func uploadBaselineProfile(_ profile: CycleBaselineProfile) async throws {
        try await manager.saveBaselineProfile(profile)
    }
    
    func getBaselineProfile() async throws -> CycleBaselineProfile? {
        let profiles = try await manager.fetchBaselineProfile()
        return profiles.first
    }
    
    // MARK: - Check-Ins
    func uploadCheckIn(_ checkIn: CycleCheckIn) async throws {
        try await manager.saveCheckIn(checkIn)
    }
    
    func getCheckIns() async throws -> [CycleCheckIn] {
        try await manager.fetchCheckIns()
    }
    
    // MARK: - Predictions (Weak Dependency)
    func uploadPrediction(_ prediction: CyclePrediction) async throws {
        try await manager.savePrediction(prediction)
    }
    
    func getPredictions() async throws -> [CyclePrediction] {
        try await manager.fetchPredictions()
    }

    // MARK: - Forecast Bundles (NEW)
    func uploadForecastBundle(_ bundle: DailyForecastBundle) async throws {
        try await manager.saveForecastBundle(bundle)
    }

    func getForecastBundle(id: UUID) async throws -> DailyForecastBundle? {
        try await manager.fetchForecastBundle(id: id)
    }
    
    // MARK: - Combined Helper
    /// Returns the latest prediction + resolved 7-day forecast
    func getLatestResolvedForecast() async throws -> [DailyForecast] {
        guard let prediction = try await getPredictions().last,
              let forecastID = prediction.forecastID else {
            return []
        }
        
        return try await getForecastBundle(id: forecastID)?.list ?? []
    }
}
