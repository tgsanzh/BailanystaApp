//
//  PostMapper.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

extension PostsResponseDTO {
    func toEntity() -> Post {
        return Post(
            id: id,
            userId: userId,
            nickname: nickname,
            content: content,
            createdAt: createdAt,
            likesCount: likesCount,
            commentsCount: commentsCount,
            liked: liked
        )
    }
}
