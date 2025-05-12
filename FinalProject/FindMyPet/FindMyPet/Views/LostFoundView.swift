//
//  LostFoundView.swift
//  FindMyPet
//
//  Created by amir on 08.05.2025.
//

//import SwiftUI
//
//struct LostFoundView: View {
//    @StateObject private var viewModel = LostFoundViewModel()
//    @State private var selectedTab = "Lost"
//    @State private var searchText = ""
//    @State private var selectedFilter: String = "All"
//
//    let filters = ["All", "Cat", "Dog", "Other"]
//
//    var body: some View {
//        NavigationStack{
//            VStack(spacing: 0) {
//                
//                HStack {
//                    Text("Lost&Found")
//                        .font(.title2.bold())
//                    Spacer()
//                    HStack(spacing: 16) {
//                        Image(systemName: "slider.horizontal.3")
//                        Image(systemName: "magnifyingglass")
//                    }
//                    .font(.title3)
//                }
//                .padding()
//                .background(Color(red: 188/255, green: 230/255, blue: 154/255))
//                
//                HStack(spacing: 0) {
//                    Button(action: { selectedTab = "Lost" }) {
//                        Text("Lost")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(selectedTab == "Lost" ? Color(red: 188/255, green: 230/255, blue: 154/255) : Color.clear)
//                            .foregroundColor(.primary)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                    .padding()
//                    
//                    Button(action: { selectedTab = "Found" }) {
//                        Text("Found")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(selectedTab == "Found" ? Color(red: 188/255, green: 230/255, blue: 154/255) : Color.clear)
//                            .foregroundColor(.primary)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                }
//                .padding(.horizontal)
//                
//                ScrollView {
//                    LazyVStack {
//                        ForEach(selectedTab == "Lost" ? viewModel.lostPosts : viewModel.foundPosts) { post in
//                            PetPostCard(post: post)
//                        }
//                    }
//                }
//            }
//            .onAppear {
//                viewModel.fetchPosts()
//            }
////            .navigationTitle("Lost & Found")
//        }
//    }
//}

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LostFoundView: View {
    @StateObject private var viewModel = LostFoundViewModel()
    @State private var selectedTab = "Lost"
    @State private var searchText = ""
    @State private var selectedFilter: String = "All"
    
    @State private var chatId: String?
    @State private var navigateToChat = false

    let filters = ["All", "Cat", "Dog", "Other"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Lost&Found")
                        .font(.title2.bold())
                    Spacer()
                    HStack(spacing: 16) {
//                        Image(systemName: "slider.horizontal.3")
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.title3)
                }
                .padding()
                .background(Color(red: 188/255, green: 230/255, blue: 154/255))

                HStack(spacing: 0) {
                    Button(action: { selectedTab = "Lost" }) {
                        Text("Lost")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedTab == "Lost" ? Color(red: 188/255, green: 230/255, blue: 154/255) : Color.clear)
                            .foregroundColor(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding()

                    Button(action: { selectedTab = "Found" }) {
                        Text("Found")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedTab == "Found" ? Color(red: 188/255, green: 230/255, blue: 154/255) : Color.clear)
                            .foregroundColor(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
                
                Picker("Pet Type", selection: $viewModel.selectedPetType) {
                    Text("All").tag(PetType?.none)
                    Text("Dog").tag(PetType?.some(.Dog))
                    Text("Cat").tag(PetType?.some(.Cat))
                    Text("Other").tag(PetType?.some(.Other))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                let filteredPosts = viewModel.allPosts.filter { post in
                    (viewModel.selectedPetType == nil || post.type == viewModel.selectedPetType) &&
                    post.petStatus.rawValue == selectedTab
                }


                ScrollView {
                    LazyVStack {
                        ForEach(filteredPosts) { post in
                            PetPostCard(post: post) {
                                startOrOpenChat(with: post.userId)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchPosts()
            }
            .onChange(of: viewModel.selectedPetType) { _ in
                viewModel.fetchPosts()
            }
//            .navigationTitle("Lost & Found")
            .navigationDestination(isPresented: $navigateToChat) {
                if let chatId = chatId {
                    ChatView(viewModel: ChatViewModel(chatId: chatId))
                }
            }
        }
    }

    private func startOrOpenChat(with userId: String) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        if currentUserId == userId { return }

        let users = [currentUserId, userId].sorted()
        let db = Firestore.firestore()
        let chatsRef = db.collection("chats")

        chatsRef
            .whereField("users", isEqualTo: users)
            .getDocuments { snapshot, error in
                if let doc = snapshot?.documents.first {
                    chatId = doc.documentID
                    navigateToChat = true
                } else {
                    let newChat = Chat(
                        id: nil,
                        users: users,
                        lastMessage: "",
                        lastTimestamp: Date()
                    )
                    do {
                        let ref = try chatsRef.addDocument(from: newChat)
                        chatId = ref.documentID
                        navigateToChat = true
                    } catch {
                        print("Error creating chat: \(error)")
                    }
                }
            }
    }
}


#Preview {
    LostFoundView()
}



