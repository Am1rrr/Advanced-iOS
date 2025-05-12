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

    private let apiKey = "208ebff0a03d133a70552b3d7d899e7f"
    private let city = "London"

    func fetchWeather() {
        weatherData.removeAll()
        loadingStates = [:]

        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.loadCurrentWeather() }
                group.addTask { await self.loadForecast() }
                group.addTask { await self.loadAirPollution() }
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
    
    private func loadAirPollution() async {
        let title = "Air Quality"
        await MainActor.run { loadingStates[title] = .loading }

        do {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=51.5074&lon=-0.1278&appid=\(apiKey)")!
            let (data, _) = try await URLSession.shared.data(from: url)

            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let list = json["list"] as? [[String: Any]],
               let first = list.first,
               let main = first["main"] as? [String: Any],
               let aqi = main["aqi"] as? Int {

                let aqiDescription: String
                switch aqi {
                case 1: aqiDescription = "Good"
                case 2: aqiDescription = "Fair"
                case 3: aqiDescription = "Moderate"
                case 4: aqiDescription = "Poor"
                case 5: aqiDescription = "Very Poor"
                default: aqiDescription = "Unknown"
                }

                let result = WeatherData(title: title, value: "AQI: \(aqi) - \(aqiDescription)")
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
    
    private func loadWeatherAlerts() async {
        let title = "Weather Alerts"
        await MainActor.run { loadingStates[title] = .loading }

        let latitude = 51.5074
        let longitude = -0.1278

        do {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=hourly,daily&appid=\(apiKey)")!
            
            let (data, _) = try await URLSession.shared.data(from: url)

            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let alerts = json["alerts"] as? [[String: Any]] {
                
                if alerts.isEmpty {
                    let result = WeatherData(title: title, value: "No weather alerts.")
                    await MainActor.run {
                        self.weatherData.append(result)
                        self.loadingStates[title] = .success
                    }
                } else {
                    for alert in alerts {
                        if let event = alert["event"] as? String,
                           let description = alert["description"] as? String {
                            let result = WeatherData(title: title, value: "\(event): \(description)")
                            await MainActor.run {
                                self.weatherData.append(result)
                            }
                        }
                    }
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


