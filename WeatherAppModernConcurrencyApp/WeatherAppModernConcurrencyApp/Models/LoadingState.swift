//
//  LoadingState.swift
//  WeatherAppModernConcurrencyApp
//
//  Created by amir on 11.04.2025.
//

import Foundation

enum LoadingState {
    case idle, loading, success, failed(Error)
}
