//
//  SupabaseManager.swift
//  HerHub
//
//  Created by Dhruv on 10/11/25.
//

import Foundation
import Supabase

final class SupabaseManager {
    static let shared = SupabaseManager()
    
    private let supabaseUrl = URL(string: "https://ecmyckxjxofrpodzrocj.supabase.co")!
    private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVjbXlja3hqeG9mcnBvZHpyb2NqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI3NjQzOTksImV4cCI6MjA3ODM0MDM5OX0.JpDuj0g3TosgDVQxO2sccZ7RJWFY6JZRCD6S1N9cWLM"
    
    let client: SupabaseClient
    
    private init() {
        client = SupabaseClient(supabaseURL: supabaseUrl, supabaseKey: supabaseKey)
        print("✅ Supabase client initialized successfully")
        
        // Run async test connection after initialization
        Task {
            await self.checkConnection()
        }
    }
    
    /// Async function to verify Supabase connection
    func checkConnection() async {
        do {
            let response = try await client
                .from("test_table")  // ⚠️ Replace with your actual table name
                .select()
                .limit(1)
                .execute()
            
            print("✅ Supabase connected. Response: \(response)")
        } catch {
            print("❌ Supabase connection failed: \(error.localizedDescription)")
        }
    }
}
