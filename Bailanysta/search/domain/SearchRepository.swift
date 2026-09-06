//
//  HomeRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol SearchRepository {
    func getPosts(token:String, search: String) async -> [Post]
}
