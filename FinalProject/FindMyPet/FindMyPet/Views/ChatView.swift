//
//  ChatView.swift
//  FindMyPet
//
//  Created by amir on 08.05.2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { msg in
                    HStack {
                        if msg.senderId == viewModel.currentUserId {
                            Spacer()
                            Text(msg.text)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        } else {
                            Text(msg.text)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }

            HStack {
                TextField("Message...", text: $viewModel.newMessage)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    viewModel.sendMessage()
                }
            }
            .padding()
            .padding(.bottom, 40)
            Spacer()
        }
        .navigationTitle("Chat")
    }
}

//#Preview {
//    ChatView(viewModel: <#ChatViewModel#>)
//}
