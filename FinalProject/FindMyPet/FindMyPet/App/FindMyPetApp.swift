//
//  FindMyPetApp.swift
//  FindMyPet
//
//  Created by amir on 07.05.2025.
//

import SwiftUI

@main
struct FindMyPetApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    init(){
        FirebaseManager.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
