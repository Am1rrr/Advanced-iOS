//
//  PetPost.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Foundation
import FirebaseFirestore

struct PetPost: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var type: PetType
    var petStatus: PetStatus
    var title: String
    var description: String
    var imageUrl: String
    var timestamp: Date
}




