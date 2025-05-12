//
//  ChatViewModel.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Firebase
import FirebaseAuth
import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessage: String = ""

    let db = Firestore.firestore()
    let chatId: String
    let currentUserId = Auth.auth().currentUser?.uid

    init(chatId: String) {
        self.chatId = chatId
        listenForMessages()
    }

    func listenForMessages() {
        db.collection("chats").document(chatId).collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, _ in
                self.messages = snapshot?.documents.compactMap {
                    try? $0.data(as: ChatMessage.self)
                } ?? []
            }
    }

    func sendMessage() {
        guard let currentUserId = currentUserId else { return }
        let message = ChatMessage(
            senderId: currentUserId,
            text: newMessage,
            timestamp: Date()
        )

        do {
            _ = try db.collection("chats").document(chatId)
                .collection("messages").addDocument(from: message)

            newMessage = ""
        } catch {
            print("Send failed: \(error)")
        }
    }
}
