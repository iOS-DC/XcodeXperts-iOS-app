//
//  CycleDataManager.swift
//  HerHub
//
//  Created by Dhruv on 10/11/25.
//

import Foundation
import Supabase

// MARK: - Private Data Manager
final class CycleDataManager {
    
    private let client: SupabaseClient
    
    init(client: SupabaseClient = SupabaseManager.shared.client) {
        self.client = client
    }
    
    // MARK: - Save / Fetch Baseline Profile
    func saveBaselineProfile(_ profile: CycleBaselineProfile) async throws {
        _ = try await client
            .from("cycle_baseline_profiles")
            .insert(profile)
            .execute()
    }
    
    func fetchBaselineProfile() async throws -> [CycleBaselineProfile] {
        let response: PostgrestResponse<[CycleBaselineProfile]> = try await client
            .from("cycle_baseline_profiles")
            .select()
            .execute()
        return response.value
    }
    
    // MARK: - Save / Fetch Check-In
    func saveCheckIn(_ checkIn: CycleCheckIn) async throws {
        _ = try await client
            .from("cycle_check_ins")
            .insert(checkIn)
            .execute()
    }
    
    func fetchCheckIns() async throws -> [CycleCheckIn] {
        let response: PostgrestResponse<[CycleCheckIn]> = try await client
            .from("cycle_check_ins")
            .select()
            .execute()
        return response.value
    }
    
    // MARK: - Save / Fetch Predictions
    func savePrediction(_ prediction: CyclePrediction) async throws {
        _ = try await client
            .from("cycle_predictions")
            .insert(prediction)
            .execute()
    }
    
    func fetchPredictions() async throws -> [CyclePrediction] {
        let response: PostgrestResponse<[CyclePrediction]> = try await client
            .from("cycle_predictions")
            .select()
            .execute()
        return response.value
    }
}
