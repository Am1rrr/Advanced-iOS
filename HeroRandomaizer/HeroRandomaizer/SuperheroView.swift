//
//  SuperheroView.swift
//  HeroRandomaizer
//
//  Created by amir on 07.03.2025.
//

import SwiftUI

struct Superhero: Codable, Identifiable {
    let id: Int
    let name: String
    let biography: Biography
    let powerstats: Powerstats
    let appearance: Appearance
    let images: SuperheroImages
}

struct Biography: Codable {
    let fullName: String
    let placeOfBirth: String
    let alignment: String
}

struct Powerstats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int
}

struct Appearance: Codable {
    let gender, race: String
}

struct SuperheroImages: Codable {
    let lg: String
}

struct SuperheroView: View {
    @State private var superhero: Superhero?
    @State private var isLoading = false
    @State private var errorMessage: String?

    let apiURL = "https://akabab.github.io/superhero-api/api/all.json"

    var body: some View {
        VStack {
            if let superhero = superhero {
                VStack {
                    AsyncImage(url: URL(string: superhero.images.lg)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())

                    Text(superhero.name)
                        .font(.largeTitle)
                        .bold()

                    VStack(alignment: .leading, spacing: 5) {
                        Text("**Full Name:** \(superhero.biography.fullName)")
                        Text("**Birthplace:** \(superhero.biography.placeOfBirth)")
                        Text("**Alignment:** \(superhero.biography.alignment)")
                        Text("**Intelligence:** \(superhero.powerstats.intelligence)")
                        Text("**Strength:** \(superhero.powerstats.strength)")
                        Text("**Speed:** \(superhero.powerstats.speed)")
                        Text("**Durability:** \(superhero.powerstats.durability)")
                        Text("**Power:** \(superhero.powerstats.power)")
                        Text("**Combat:** \(superhero.powerstats.combat)")
                    }
                    .padding()

                    Button("Fetch Random Hero", action: fetchRandomHero)
                        .buttonStyle(.borderedProminent)
                        .padding()
                }
                .padding()
            } else if isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Button("Fetch Superhero", action: fetchRandomHero)
                    .buttonStyle(.borderedProminent)
                    .padding()
            }
        }
        .onAppear {
            fetchRandomHero()
        }
    }

    func fetchRandomHero() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let url = URL(string: apiURL)!
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let heroes = try JSONDecoder().decode([Superhero].self, from: data)
                
                print("DEBUG: ", heroes)
                
                DispatchQueue.main.async {
                    superhero = heroes.randomElement()
                    isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to fetch superhero."
                    isLoading = false
                }
            }
        }
    }
}



