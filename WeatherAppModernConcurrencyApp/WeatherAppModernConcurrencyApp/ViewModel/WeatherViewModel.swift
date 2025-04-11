//
//  WeatherViewModel.swift
//  WeatherAppModernConcurrencyApp
//
//  Created by amir on 11.04.2025.
//

import SwiftUI

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weatherData: [WeatherData] = []
    @Published var loadingStates: [String: LoadingState] = [:]

    private let apiKey = "e1d450da1674ccbb4e91e3681e876153"
    private let city = "London"

    func fetchWeather() {
        weatherData.removeAll()
        loadingStates = [:]

        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.loadCurrentWeather() }
                group.addTask { await self.loadForecast() }
            }
        }
    }

    private func loadCurrentWeather() async {
        let title = "Current Conditions"
        await MainActor.run { loadingStates[title] = .loading }
        do {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let main = json["main"] as? [String: Any],
               let temp = main["temp"] as? Double {
                let result = WeatherData(title: title, value: "Temperature: \(temp)°C")
                await MainActor.run {
                    self.weatherData.append(result)
                    self.loadingStates[title] = .success
                }
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            await MainActor.run { loadingStates[title] = .failed(error) }
        }
    }

    private func loadForecast() async {
        let title = "5-Day Forecast"
        await MainActor.run { loadingStates[title] = .loading }
        do {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=\(apiKey)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let list = json["list"] as? [[String: Any]],
               let first = list.first,
               let main = first["main"] as? [String: Any],
               let temp = main["temp"] as? Double,
               let dt_txt = first["dt_txt"] as? String {
                let result = WeatherData(title: title, value: "\(dt_txt): \(temp)°C")
                await MainActor.run {
                    self.weatherData.append(result)
                    self.loadingStates[title] = .success
                }
            } else {
                throw URLError(.badServerResponse)
            }
        } catch {
            await MainActor.run { loadingStates[title] = .failed(error) }
        }
    }
}

