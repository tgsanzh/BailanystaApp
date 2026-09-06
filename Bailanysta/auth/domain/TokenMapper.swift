//
//  TokenMapper.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

extension AuthResponseDTO {
    func toEntity() -> AuthToken {
        return AuthToken(accessToken: accessToken, tokenType: tokenType)
    }
}
