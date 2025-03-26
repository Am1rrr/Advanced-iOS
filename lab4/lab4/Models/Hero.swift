//
//  Hero.swift
//  lab4
//
//  Created by amir on 26.03.2025.
//

import Foundation

struct Hero: Identifiable, Codable {
    let id: Int
    let name: String
    let slug: String
    let powerstats: PowerStats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections
    let images: HeroImages?
}


struct PowerStats: Codable {
    let intelligence, strength, speed, durability, power, combat: Int
}

struct Biography: Codable {
    let fullName: String
    let placeOfBirth: String
    let firstAppearance: String
    let publisher: String
}

struct Appearance: Codable {
    let gender: String
    let race: String?
    let height: [String]
    let weight: [String]
    let eyeColor: String
    let hairColor: String
}

struct Work: Codable {
    let occupation: String
    let base: String
}

struct Connections: Codable {
    let groupAffiliation: String
    let relatives: String
}

struct HeroImages: Codable {
    let xs, sm, md, lg: String
}


