//
//  CommentsViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

final class CommentsViewModel: ObservableObject {
    
    private let repository: CommentsRepository
    
    @Published var postId: Int
    
    init(repository: CommentsRepository, postId: Int) {
        self.repository = repository
        self.postId = postId
    }
    
    @Published var commentText: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var comments: [Comment] = []
    
    func getComments() {
        Task {
            isLoading = true
            errorMessage = nil
            let comments = await repository.getComments(id: postId)
            if comments.isEmpty {
                errorMessage = "Не удалось загрузить посты"
            }
            self.comments = comments
            isLoading = false
        }
    }
    
    func addComment() {
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            Task {
                await repository.addComment(token: accessToken, comment: commentText, postId: postId)
                refresh()
            }
        } else {
            print("Access token is missing or empty")
        }
        
    }
    
    func refresh() {
        getComments()
    }
}
