//
//  DailyTrackingModels.swift
//  HerHub
//
//  Created by Nihar Sandhu on 28/10/25.
//

import Foundation

struct DailyEntry: Codable, Identifiable {
    var id = UUID().uuidString
    var date: Date
    var mood: MoodState
    var symptoms: [SymptomCategory: [SymptomDetail]]
    var notes: String?
}

// Mood selection
enum MoodState: String, Codable, CaseIterable {
    case excellent, good, okay, low, anxious, tired
}

// Symptom tracking categories
enum SymptomCategory: String, Codable, CaseIterable {
    case head, body, digestive, emotional
}

// Detailed symptoms user selects daily
enum SymptomDetail: String, Codable, CaseIterable {
    // Head
    case headache, migraine, dizziness, brainFog
    // Body
    case tenderBreasts, breastSensitivity, backache, lowerBackPain
    case bodyAches, musclePain, jointPain
    // Digestive
    case bloating, nausea, constipation, diarrhea
    // Emotional
    case moodSwings, irritability, anxiety, depression, cryingSpells
}

