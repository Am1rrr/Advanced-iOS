//
//  WeatherComponentView.swift
//  WeatherAppModernConcurrencyApp
//
//  Created by amir on 11.04.2025.
//

import SwiftUI

struct WeatherComponentView: View {
    let title: String
    let state: LoadingState
    let data: WeatherData?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline)

            switch state {
            case .idle:
                Text("Idle").foregroundColor(.gray)
            case .loading:
                HStack { ProgressView(); Text("Loading...").foregroundColor(.gray) }
            case .success:
                if let data = data {
                    Text(data.value).foregroundColor(.primary)
                }
            case .failed(let error):
                Text("Error: \(error.localizedDescription)").foregroundColor(.red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

