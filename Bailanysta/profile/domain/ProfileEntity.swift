//
//  PostEntity.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

struct Profile: Identifiable {
    let id = UUID()
    let nickname: String
    let posts: [Post]
}
