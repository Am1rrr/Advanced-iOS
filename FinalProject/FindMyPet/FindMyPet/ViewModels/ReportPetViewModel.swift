//
//  ReportPetViewModel.swift
//  FindMyPet
//
//  Created by amir on 09.05.2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import UIKit

class ReportPetViewModel: ObservableObject {
    @Published var petStatus: PetStatus = .Lost
    @Published var type: PetType = .Other
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var uploadSuccess = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    func submitReport() {
        guard let image = image,
              let userId = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Image and user must be provided"
            return
        }

        isLoading = true

        uploadImage(image) { [weak self] url in
            guard let self = self, let url = url else {
                self?.isLoading = false
                self?.errorMessage = "Failed to upload image"
                return
            }

            let newPost = PetPost(
                userId: userId,
                type: self.type,
                petStatus: self.petStatus,
                title: self.title,
                description: self.description,
                imageUrl: url.absoluteString,
                timestamp: Date()
            )

            do {
                _ = try self.db.collection("pet_posts").addDocument(from: newPost)
                self.uploadSuccess = true
            } catch {
                self.errorMessage = error.localizedDescription
            }

            self.isLoading = false
        }
    }

    private func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        let ref = storage.reference().child("images/\(UUID().uuidString).jpg")

        ref.putData(imageData, metadata: nil) { _, error in
            if error != nil {
                completion(nil)
            } else {
                ref.downloadURL(completion: { url, _ in
                    completion(url)
                })
            }
        }
    }
}
