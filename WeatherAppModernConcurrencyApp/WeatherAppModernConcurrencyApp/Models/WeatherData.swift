//
//  WeatherData.swift
//  WeatherAppModernConcurrencyApp
//
//  Created by amir on 11.04.2025.
//

import Foundation

struct WeatherData: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}
