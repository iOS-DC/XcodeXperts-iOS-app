//
//  CycleProfileModels.swift
//  HerHub
//
//  Created by Nihar Sandhu on 28/10/25.
//

import Foundation

// Onboarding profile
struct CycleProfile: Codable {
    var lastRainstorm: Date // last period date
    var rainIntensity: RainIntensity
    var weatherPatternDuration: Int // cycle length days
    var commonSymptoms: [Symptom]
}

// Weather metaphors (onboarding)
enum RainIntensity: String, Codable {
    case light, medium, heavy
}

// Onboarding symptom choices
enum Symptom: String, Codable, CaseIterable {
    case thunderstorm // cramps
    case fog // fatigue
    case rain // mood swings
    case wind // bloating
    case sun // energy boost
}

// Phase tracking
enum CyclePhase: String, Codable {
    case menstrual, follicular, ovulation, luteal
}

// Fertility tracking
enum FertilityLevel: String, Codable {
    case low, medium, high
}

// Energy prediction for UI
enum EnergyLevel: String, Codable {
    case high, medium, low
}

