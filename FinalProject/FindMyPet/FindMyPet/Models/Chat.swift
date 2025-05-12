//
//  Chat.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Foundation
import FirebaseFirestore

struct Chat: Identifiable, Codable {
    @DocumentID var id: String?
    var users: [String]
    var lastMessage: String
    var lastTimestamp: Date
}
