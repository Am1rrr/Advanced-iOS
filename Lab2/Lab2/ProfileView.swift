//
//  ProfileView.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileManager = ProfileManager.shared
    @State private var profile: UserProfile?

    var body: some View {
        VStack {
            if let profile = profile {
                Text("Username: \(profile.username)")
                Text("Bio: \(profile.bio)")
                Text("Followers: \(profile.followers)")
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            profileManager.loadProfile(id: "1")
            profileManager.onProfileUpdate = { updatedProfile in
                self.profile = updatedProfile
            }
        }
    }
}

