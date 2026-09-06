//
//  PostMapper.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

extension ProfileResponseDTO {
    func toEntity() -> Profile {
        return Profile(
            nickname: nickname,
            posts: posts.map { $0.toEntity() }
        )
    }
}
