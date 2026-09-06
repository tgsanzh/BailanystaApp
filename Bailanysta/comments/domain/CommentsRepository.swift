//
//  HomeRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol CommentsRepository {
    func getComments(id: Int) async -> [Comment]
    func addComment(token: String, comment: String, postId: Int) async -> Int
}
