//
//  HomeDTO.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

struct PostsResponseDTO: Codable {
    let id: Int
    let userId: Int
    let nickname: String
    let content: String
    let createdAt: Date
    let likesCount: Int
    let commentsCount: Int
    let liked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case nickname
        case content
        case createdAt = "created_at"
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
        case liked
    }
}
