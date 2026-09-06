//
//  RegisterViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel(repository: HomeRepositoryImpl())
    
    private let repository: HomeRepository
    
    init(repository: HomeRepository) {
        self.repository = repository
    }
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var posts: [Post] = []
    
    func getPosts() {
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            
            guard !isLoading else { return }
            
            Task {
                isLoading = true
                errorMessage = nil
                let posts = await repository.getPosts(token: accessToken)
                if posts.isEmpty {
                    errorMessage = "Не удалось загрузить посты"
                }
                self.posts = posts
                isLoading = false
            }
            
        } else {
            print("Access token is missing or empty")
        }
        
    }
    
    func refresh() {
        getPosts()
    }
    
    func like(postId: Int) {
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            Task {
                let result = await repository.like(token: accessToken, postId: postId)
                if result == 200 {
                    posts = posts.map { post in
                        if post.id == postId {
                            return Post(
                                id: post.id,
                                userId: post.userId,
                                nickname: post.nickname,
                                content: post.content,
                                createdAt: post.createdAt,
                                likesCount: post.likesCount + 1,
                                commentsCount: post.commentsCount,
                                liked: true,
                            )
                        } else {
                            return post
                        }
                    }
                }
            }
            
        } else {
            print("Access token is missing or empty")
        }

    }
    
    func unlike(postId: Int) {
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            Task {
                let result = await repository.unlike(token: accessToken, postId: postId)
                if result == 200 {
                    posts = posts.map { post in
                        if post.id == postId {
                            return Post(
                                id: post.id,
                                userId: post.userId,
                                nickname: post.nickname,
                                content: post.content,
                                createdAt: post.createdAt,
                                likesCount: post.likesCount - 1,
                                commentsCount: post.commentsCount,
                                liked: false,
                            )
                        } else {
                            return post
                        }
                    }
                }
            }
            
        } else {
            print("Access token is missing or empty")
        }

    }
}
