//
//  ChatMessage.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Foundation
import FirebaseFirestore

struct ChatMessage: Identifiable, Codable {
    @DocumentID var id: String?
    var senderId: String
    var text: String
    var timestamp: Date
}
