//
//  CommentsDTO.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

struct CommentsDTO: Codable {
    var id: Int
    var nickname: String
    var user_id: Int
    var content: String
    var created_at: Date
}

struct CommentCreate: Codable {
    var content: String
}
