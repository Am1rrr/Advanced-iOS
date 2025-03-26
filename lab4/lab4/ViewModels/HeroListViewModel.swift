//
//  HeroListViewModel.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import Foundation

import SwiftUI

class HeroListViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        fetchHeroes()
    }
    
    func fetchHeroes() {
        isLoading = true
        HeroService.shared.fetchHeroes { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
