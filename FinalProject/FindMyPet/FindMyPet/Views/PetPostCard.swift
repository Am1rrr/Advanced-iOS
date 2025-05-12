//
//  PetPostCard.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

//import SwiftUI
//
//struct PetPostCard: View {
//    let post: PetPost
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            AsyncImage(url: URL(string: post.imageUrl)) { image in
//                image
//                    .resizable()
////                    .scaledToFill()
//                    .frame(height:200)
//                    .clipped()
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(height: 200)
//            .cornerRadius(10)
//
//            Text(post.title)
//                .font(.headline)
//            Text(post.description)
//                .font(.subheadline)
//                .lineLimit(2)
//                .foregroundColor(.gray)
//
//            Text(post.timestamp, style: .date)
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(radius: 2)
//        .padding(.horizontal)
//    }
//}


import SwiftUI

struct PetPostCard: View {
    let post: PetPost
    let onMessageOwner: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image
                    .resizable()
                    .frame(height:200)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .cornerRadius(10)

            Text(post.title)
                .font(.headline)
            Text(post.description)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.gray)

            Text(post.timestamp, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)

            Button("Message Owner") {
                onMessageOwner()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}



#Preview {
    PetPostCard(post: PetPost(
        id: "1",
        userId: "user123",
        type: .Dog,
        petStatus: .Lost,
        title: "Lost Dog",
        description: "A big brown dog lost near the park.",
        imageUrl: "https://images.unsplash.com/photo-1422565096762-bdb997a56a84?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        timestamp: Date()
    ), onMessageOwner: {
        print("Preview: Message button tapped")
    })
}
