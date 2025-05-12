//
//  ChatListViewModel.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChatListViewModel: ObservableObject {
    @Published var chats: [Chat] = []

    private let db = Firestore.firestore()
    private let currentUserId = Auth.auth().currentUser?.uid

    func fetchChats() {
        guard let currentUserId = currentUserId else { return }

        db.collection("chats")
            .whereField("users", arrayContains: currentUserId)
            .order(by: "lastTimestamp", descending: true)
            .addSnapshotListener { snapshot, _ in
                self.chats = snapshot?.documents.compactMap {
                    try? $0.data(as: Chat.self)
                } ?? []
            }
    }
}
