//
//  Models.swift
//  Lab2
//
//  Created by amir on 27.02.2025.
//

import Foundation

// MARK: - Модель пользователя
struct UserProfile: Hashable, Identifiable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int
}

// MARK: - Модель поста
struct Post: Hashable, Identifiable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int
}

