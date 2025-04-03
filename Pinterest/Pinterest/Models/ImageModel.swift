//
//  ImageModel.swift
//  Pinterest
//
//  Created by amir on 03.04.2025.
//

import Foundation

struct ImageModel: Identifiable, Codable {
    let id: UUID = UUID()
    let url: String
}
