//
//  LostFoundViewModel.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

//import Foundation
//import FirebaseFirestore
//
//class LostFoundViewModel: ObservableObject {
//    @Published var lostPosts: [PetPost] = []
//    @Published var foundPosts: [PetPost] = []
//    @Published var selectedPetType: PetType? = nil
//    
//    private var db = Firestore.firestore()
//    
//    func fetchPosts() {
//        db.collection("pet_posts").order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
//            guard let documents = snapshot?.documents else { return }
//            let posts = documents.compactMap{ try? $0.data(as: PetPost.self)}
//
//            let filtered = posts.filter { post in
//                self.selectedPetType == nil || post.type == self.selectedPetType
//            }
//            
//            self.lostPosts = posts.filter{ $0.petStatus.rawValue == "Lost"}
//            self.foundPosts = posts.filter{ $0.petStatus.rawValue == "Found"}
//        }
//    }
//}

import Foundation
import FirebaseFirestore

class LostFoundViewModel: ObservableObject {
    @Published var allPosts: [PetPost] = []
    @Published var selectedPetType: PetType? = nil

    private var db = Firestore.firestore()

    func fetchPosts() {
        db.collection("pet_posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.allPosts = documents.compactMap { try? $0.data(as: PetPost.self) }
            }
    }
}

