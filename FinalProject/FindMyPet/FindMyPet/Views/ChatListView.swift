//
//  ChatListView.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//


import SwiftUI

struct ChatListView: View {
    @StateObject private var viewModel = ChatListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.chats) { chat in
                NavigationLink {
                    ChatView(viewModel: ChatViewModel(chatId: chat.id!))
                } label: {
                    VStack(alignment: .leading) {
                        Text(chat.lastMessage)
                            .font(.body)
                            .lineLimit(1)
                        Text(chat.lastTimestamp, style: .time)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Messages")
            .onAppear {
                viewModel.fetchChats()
            }
        }
    }
}

#Preview {
    ChatListView()
}
