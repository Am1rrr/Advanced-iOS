//
//  HeroDetailView.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import Foundation
import SwiftUI

struct HeroDetailView: View {
    let hero: Hero
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: hero.images.lg)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            
            Text(hero.name).font(.largeTitle)
            Text(hero.biography.fullName).font(.title2)
            
            VStack(alignment: .leading) {
                Text("Power Stats:").font(.headline)
                Text("Intelligence: \(hero.powerstats.intelligence)")
                Text("Strength: \(hero.powerstats.strength)")
                Text("Speed: \(hero.powerstats.speed)")
                Text("Durability: \(hero.powerstats.durability)")
                Text("Power: \(hero.powerstats.power)")
                Text("Combat: \(hero.powerstats.combat)")
            }
            .padding()
        }
        .navigationTitle(hero.name)
    }
}

