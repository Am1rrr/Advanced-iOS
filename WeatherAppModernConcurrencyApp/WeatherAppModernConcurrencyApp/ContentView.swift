//
//  ContentView.swift
//  WeatherAppModernConcurrencyApp
//
//  Created by amir on 11.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(["Current Conditions", "5-Day Forecast", "Air Quality", "Weather Alerts"], id: \ .self) { title in
                        WeatherComponentView(title: title,
                                              state: viewModel.loadingStates[title] ?? .idle,
                                              data: viewModel.weatherData.first(where: { $0.title == title }))
                    }
                }
                .padding()
            }
            .navigationTitle("Weather Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        viewModel.fetchWeather()
                    }
                }
            }
            .onAppear {
                viewModel.fetchWeather()
            }
        }
    }
}

#Preview {
    ContentView()
}
