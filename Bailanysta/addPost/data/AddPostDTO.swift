//
//  AddPostDTO.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

struct PostCreate: Codable {
    let content: String
}

struct PostResponse: Codable {
    let status_code: Int
    let status: String
}
