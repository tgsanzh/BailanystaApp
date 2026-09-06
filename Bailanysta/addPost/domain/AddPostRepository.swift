//
//  AddPostRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol AddPostRepository {
    func addPost(content: String, token: String) async
}
