//
//  DummyDataSeeder.swift
//  HerHub
//
//  Created by Dhruv on 20/11/25.
//

import Foundation

enum SeederError: Error {
    case uploadFailed(String)
}

final class DummyDataSeeder {

    // Call this ONCE (in debug) to seed DB
    static func seedAllDummyData() {
        Task {
            do {
                try await seed()
                print("✅ Seeder finished successfully")
            } catch {
                print("❌ Seeder failed:", error)
            }
        }
    }

    private static func seed() async throws {

        let usersToCreate = [
            ("alice@herhub.com", "+91 11111 11111", "alice123"),
            ("beth@herhub.com",  "+91 22222 22222", "beth123"),
            ("carol@herhub.com", "+91 33333 33333", "carol123")
        ]

        for (index, tuple) in usersToCreate.enumerated() {

            let email = tuple.0
            let phone = tuple.1
            let password = tuple.2

            // ---------------------------------------
            // 1) Create 7-day forecast bundle
            // ---------------------------------------
            let bundleID = UUID()
            let forecastList = build7DayForecast(
                startingOn: Date().addingTimeInterval(TimeInterval(86400 * index)),
                variant: index
            )

            let bundle = DailyForecastBundle(id: bundleID, list: forecastList)

            try await CycleDataController.shared.uploadForecastBundle(bundle)
            print("✅ Uploaded forecast bundle \(bundleID)")

            // ---------------------------------------
            // 2) Create CyclePrediction linked to bundle
            // ---------------------------------------
            let prediction = CyclePrediction(
                predicted_cycle_length: 28 + index,
                predicted_next_period_start: Calendar.current.date(
                    byAdding: .day,
                    value: 28 + index,
                    to: Date()
                )!,
                forecastID: bundleID
            )

            try await CycleDataController.shared.uploadPrediction(prediction)
            print("✅ Uploaded prediction for bundle \(bundleID)")

            // ---------------------------------------
            // 3) Create USER with JSONB linked data
            // ---------------------------------------
            let user = User(
                id: UUID(),
                email: email,
                phoneNumber: phone,
                password: password,
                baselineProfile: CycleBaselineProfile.sample,
                recentCheckIns: [CycleCheckIn.sample],
                latestPrediction: prediction
            )

            try await UserController.shared.registerUser(user)
            print("✅ Created user: \(email)")
        }
    }

    // ---------------------------------------
    // Build Sample 7-Day Forecast
    // ---------------------------------------
    private static func build7DayForecast(startingOn start: Date, variant: Int) -> [DailyForecast] {

        var arr: [DailyForecast] = []

        for i in 0..<7 {

            let date = Calendar.current.date(byAdding: .day, value: i, to: start)!

            let phase: CyclePhase = {
                switch i % 4 {
                case 0: return .follicular
                case 1: return .ovulation
                case 2: return .luteal
                default: return .menstrual
                }
            }()

            let fert: FertilityLevel = {
                switch i % 3 {
                case 0: return .low
                case 1: return .med
                default: return .high
                }
            }()

            let energy: EnergyLevel = {
                switch (i + variant) % 3 {
                case 0: return .high
                case 1: return .medium
                default: return .low
                }
            }()

            let moodText: String = {
                switch phase {
                case .follicular: return "Good"
                case .ovulation: return "Happy"
                case .luteal: return "Okay"
                case .menstrual: return "Calm"
                }
            }()

            let symptoms: [Symptom] = {
                if phase == .menstrual { return [Symptom(name: "Cramps", intensity: 6)] }
                if phase == .luteal { return [Symptom(name: "Fatigue", intensity: 3)] }
                return []
            }()

            let recs: [String] = {
                switch phase {
                case .follicular: return ["Focus on creative work", "High intensity workout"]
                case .ovulation: return ["Social day", "Plan meetings"]
                case .luteal: return ["Eat magnesium-rich foods", "Take breaks"]
                case .menstrual: return ["Rest", "Use a heating pad"]
                }
            }()

            let df = DailyForecast(
                id: UUID(),
                date: date,
                phase: phase,
                fertility: fert,
                energy: energy,
                weatherDescription: "\(phase.rawValue.capitalized) — sample forecast",
                mood: moodText,
                symptoms: symptoms,
                recommendations: recs
            )

            arr.append(df)
        }

        return arr
    }
}
