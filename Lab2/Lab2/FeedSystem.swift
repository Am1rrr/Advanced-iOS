//
//  FeedSystem.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import Foundation
import Combine

class FeedSystem: ObservableObject {
    @Published private var userCache: [UUID: UserProfile] = [:]
    @Published private var feedPosts: [Post] = []
    @Published private var hashtags: Set<String> = []

    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0)
    }

    func removePost(_ post: Post) {
        feedPosts.removeAll { $0.id == post.id }
    }
}

