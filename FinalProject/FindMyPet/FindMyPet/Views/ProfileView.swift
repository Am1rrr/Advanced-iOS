//
//  ProfileView.swift
//  FindMyPet
//
//  Created by amir on 10.05.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var myPostsViewModel = MyPostsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack{
                Rectangle()
                    .frame(width: 410, height: 120)
                    .foregroundColor(Color(red: 188/255, green: 230/255, blue: 154/255))
                Text("Profile")
                    .font(.largeTitle).bold()
                    .padding(.top, 30)
            }
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let user = Auth.auth().currentUser {
                        Text("Welcome, \(user.email ?? "Unknown user")")
                            .font(.headline)
                    }

                    Text("My Pet Posts")
                        .font(.headline)

                    if myPostsViewModel.posts.isEmpty {
                        Text("You haven't posted anything yet.")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    } else {
                        ForEach(myPostsViewModel.posts) { post in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(post.title)
                                    .font(.headline)
                                Text(post.description)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                Text("Status: \(post.petStatus.rawValue.capitalized)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                        }
                    }

                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray4))
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .onAppear {
            myPostsViewModel.fetchMyPosts()
        }
    }
}

#Preview {
    ProfileView()
}
