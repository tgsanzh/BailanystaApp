//
//  HomeDTO.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

struct ProfileResponseDTO: Codable {
    let nickname: String
    let posts: [PostsResponseDTO]
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case posts
    }
}
