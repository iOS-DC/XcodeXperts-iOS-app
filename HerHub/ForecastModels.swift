//
//  ForecastModels.swift
//  HerHub
//
//  Created by Nihar Sandhu on 28/10/25.
//

import Foundation

struct CycleForecastDay: Codable, Identifiable {
    var id = UUID().uuidString
    
    var date: Date
    var phase: CyclePhase
    var predictedFertility: FertilityLevel
    var predictedEnergy: EnergyLevel
    var expectedMood: MoodState
    var expectedSymptoms: [SymptomDetail]
    var recommendations: [String]
    var phaseDescription: String
}

