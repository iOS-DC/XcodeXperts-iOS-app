//
//  CycleModels.swift
//  HerHub
//
//  Created by Nihar Sandhu on 28/10/25.
//

import Foundation

// MARK: - One-Time Baseline Profile
struct CycleBaselineProfile: Codable, Equatable {
    var age: Int
    var baseCycleLength: Int                // average days between periods
    var basePeriodLength: Int               // average period duration
    var onBirthControl: Bool
    var hasPCOS: Bool
    var exercisePerWeek: String             // None / 1–2x / 3–5x / Daily
    var avgSleepHours: Double
    var baselineStress: Int                 // 1–10 scale
    var lastPeriodStart: Date
}

// MARK: - Recurring (Monthly / Pre-Cycle) Check-In
struct CycleCheckIn: Codable, Equatable {
    var id = UUID()
    var date: Date
    var symptomsPresent: Bool
    var currentStress: Int
    var sleepHours: Double
    var sickOrMeds: Bool
    var exerciseChange: ExerciseChange
    var periodStartedToday: Bool?
}

enum ExerciseChange: String, Codable, CaseIterable {
    case less, same, more
}

// MARK: - Cycle Prediction Summary
struct CyclePrediction: Codable, Equatable {
    var predicted_cycle_length: Int
    var predicted_next_period_start: Date
    var forecastID: UUID?

    enum CodingKeys: String, CodingKey {
        case predicted_cycle_length = "predicted_cycle_length"
        case predicted_next_period_start = "predicted_next_period_start"
        case forecastID = "forecastID"
    }
}


//this stores daily forecast and helps us build weak dependecy
struct DailyForecastBundle: Codable, Equatable {
    var id: UUID          // referenced by CyclePrediction.forecastID
    var list: [DailyForecast]
}



// MARK: - 7-Day Forecast Data
struct DailyForecast: Codable, Equatable {
    var id = UUID()
    var date: Date
    var phase: CyclePhase
    var fertility: FertilityLevel
    var energy: EnergyLevel
    var weatherDescription: String
    var mood: String
    var symptoms: [Symptom]          // FIXED naming
    var recommendations: [String]    // NEW
}
struct Symptom: Codable, Equatable {
    var name: String
    var intensity: Int  // 1–10 scale or 0–100
}


// MARK: - Enum Sets
enum CyclePhase: String, Codable {
    case menstrual, follicular, ovulation, luteal
}

enum FertilityLevel: String, Codable {
    case low, med, high
}
enum EnergyLevel: String, Codable {
    case high, medium, low
}

// MARK: - Sample Data
extension CycleBaselineProfile {
    static let sample = CycleBaselineProfile(
        age: 23,
        baseCycleLength: 28,
        basePeriodLength: 5,
        onBirthControl: false,
        hasPCOS: false,
        exercisePerWeek: "3–5x",
        avgSleepHours: 7.0,
        baselineStress: 5,
        lastPeriodStart: Calendar.current.date(byAdding: .day, value: -20, to: Date())!
    )
}

extension CycleCheckIn {
    static let sample = CycleCheckIn(
        date: Date(),
        symptomsPresent: true,
        currentStress: 6,
        sleepHours: 7.5,
        sickOrMeds: false,
        exerciseChange: .same,
        periodStartedToday: false
    )
}

extension DailyForecast {
    static func sampleList(start: Date = Date()) -> [DailyForecast] {
        return (0..<7).map { i in
            DailyForecast(
                date: Calendar.current.date(byAdding: .day, value: i, to: start)!,
                phase: [.follicular, .ovulation, .luteal, .menstrual][i % 4],
                fertility: [.low, .med, .high][i % 3],
                energy: [.high, .medium, .low][i % 3],
                weatherDescription: "Sample Forecast \(i)",
                mood: "Mood \(i)",
                symptoms: [],
                recommendations: ["Recommendation \(i)"]
            )
        }
    }
}

extension DailyForecastBundle {
    static func sample() -> DailyForecastBundle {
        let id = UUID()
        return DailyForecastBundle(
            id: id,
            list: DailyForecast.sampleList()
        )
    }
}

extension CyclePrediction {
    static func sample() -> CyclePrediction {
        return CyclePrediction(
            predicted_cycle_length: 28,
            predicted_next_period_start: Calendar.current.date(byAdding: .day, value: 28, to: Date())!,
            forecastID: nil // set after uploading DailyForecastBundle
        )
    }
}

