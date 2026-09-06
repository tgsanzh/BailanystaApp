//
//  LoginDTO.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

struct AuthRequestDTO: Codable {
    let nickname: String
    let password: String
}

struct AuthResponseDTO: Codable {
    let accessToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
