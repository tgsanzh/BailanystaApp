//
//  RegisterViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class SearchViewModel: ObservableObject {
    static let shared = SearchViewModel(repository: SearchRepositoryImpl(), homeRepository: HomeRepositoryImpl())
    
    private let repository: SearchRepository
    private let homeRepository: HomeRepository
    
    init(repository: SearchRepositoryImpl, homeRepository: HomeRepositoryImpl) {
        self.repository = repository
        self.homeRepository = homeRepository
    }
    
    @Published var searchText: String = ""
    
    @Published var lastChecked: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var posts: [Post] = []
    
    func getPosts() {
        
        if lastChecked == searchText { return }
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            Task {
                guard !isLoading else { return }
                lastChecked = searchText
                isLoading = true
                errorMessage = nil
                let posts = await repository.getPosts(token: accessToken, search: searchText)
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
                let result = await homeRepository.like(token: accessToken, postId: postId)
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
                
                let result = await homeRepository.unlike(token: accessToken, postId: postId)
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
