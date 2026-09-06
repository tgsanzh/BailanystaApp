//
//  HomeRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol ProfileRepository {
    func getProfile(token: String, userId: Int) async -> Profile
    func getMyProfile(token: String) async -> Profile
}
