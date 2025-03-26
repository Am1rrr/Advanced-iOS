//
//  lab4App.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import SwiftUI

@main
struct HeroApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HeroListView(viewModel: HeroListViewModel())
            }
        }
    }
}
