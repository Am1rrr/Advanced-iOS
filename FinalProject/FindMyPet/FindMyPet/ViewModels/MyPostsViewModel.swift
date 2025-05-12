//
//  MyPostsViewModel.swift
//  FindMyPet
//
//  Created by amir on 10.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestore

class MyPostsViewModel: ObservableObject {
    @Published var posts: [PetPost] = []

    func fetchMyPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore()
            .collection("pet_posts")
            .whereField("userId", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Firestore ошибка: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("Нет документов")
                    return
                }

                self.posts = documents.compactMap {
                    do {
                        return try $0.data(as: PetPost.self)
                    } catch {
                        print("Ошибка декодирования: \(error.localizedDescription)")
                        print("Документ: \($0.data())")
                        return nil
                    }
                }

                print("Загружено постов: \(self.posts.count)")
            }
        }
    }
