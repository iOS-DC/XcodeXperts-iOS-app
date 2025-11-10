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
    var predictedCycleLength: Int
    var predictedNextPeriodStart: Date
    var sevenDayForecast: [DailyForecast]
}

// MARK: - 7-Day Forecast Data
struct DailyForecast: Codable, Equatable {
    var id = UUID()
    var date: Date
    var phase: CyclePhase
    var fertility: FertilityLevel
    var energy: EnergyLevel
    var weatherDescription: String
}

// MARK: - Enum Sets
enum CyclePhase: String, Codable {
    case menstrual, follicular, ovulation, luteal
}

enum FertilityLevel: String, Codable {
    case low, medium, high
}

enum EnergyLevel: String, Codable {
    case high, medium, low
}

// MARK: - Sample Data for Entire Model
extension CyclePrediction {
    static let sample = CyclePrediction(
        predictedCycleLength: 28,
        predictedNextPeriodStart: Calendar.current.date(byAdding: .day, value: 28, to: Date())!,
        sevenDayForecast: [
            DailyForecast(date: Date(), phase: .follicular, fertility: .low, energy: .high, weatherDescription: "☀️ Sunny — feeling confident and focused"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 1), phase: .follicular, fertility: .medium, energy: .high, weatherDescription: "🌤️ Clear skies — energy stable"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 2), phase: .ovulation, fertility: .high, energy: .high, weatherDescription: "☀️ Bright day — peak fertility, great mood"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 3), phase: .luteal, fertility: .medium, energy: .medium, weatherDescription: "🌥️ Mild clouds — emotional balance needed"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 4), phase: .luteal, fertility: .low, energy: .medium, weatherDescription: "🌦️ Slight rain — slight drop in energy"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 5), phase: .menstrual, fertility: .low, energy: .low, weatherDescription: "🌧️ Rainstorm — rest and self-care"),
            DailyForecast(date: Date().addingTimeInterval(86400 * 6), phase: .menstrual, fertility: .low, energy: .low, weatherDescription: "🌧️ Continued rain — prioritize comfort")
        ]
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
