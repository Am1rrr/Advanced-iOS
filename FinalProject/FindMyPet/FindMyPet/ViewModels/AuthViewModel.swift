//
//  AuthViewModel.swift
//  FindMyPet
//
//  Created by amir on 08.05.2025.
//

import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var nickname = ""
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false
    
    func signIn() {
        errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.isAuthenticated = true
                }
            }
        }
            
    }
    
    func signUp() {
        errorMessage = nil
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    self.errorMessage = error.localizedDescription
                } else if let uid = result?.user.uid {
                    self.saveNickname(uid: uid)
                    self.isAuthenticated = true
                }
            }
        }
    }
    
    private func saveNickname(uid: String) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "nickname": nickname,
            "email": email])
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch{
            errorMessage = error.localizedDescription
        }
    }
}
