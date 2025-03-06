//
//  ProfileManager.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import Foundation
import Combine

// MARK: - Profile Management System
protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager: ObservableObject {
    static let shared = ProfileManager() // Singleton

    @Published private var activeProfiles: [String: UserProfile] = [:]

    weak var delegate: ProfileUpdateDelegate?

    var onProfileUpdate: ((UserProfile) -> Void)?

    private init() {} // Закрываем init для Singleton

    func loadProfile(id: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let profile = UserProfile(id: UUID(), username: "User\(id)", bio: "Bio", followers: 100)
            DispatchQueue.main.async {
                self.activeProfiles[id] = profile
                self.onProfileUpdate?(profile)
                self.delegate?.profileDidUpdate(profile)
            }
        }
    }
}

