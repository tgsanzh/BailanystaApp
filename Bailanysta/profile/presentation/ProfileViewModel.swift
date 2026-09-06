//
//  ProfileViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    private let repository: ProfileRepository
    
    private let homeRepository: HomeRepository
    
    init(userId: Int, repository: ProfileRepository, homeRepository: HomeRepository = HomeRepositoryImpl()) {
        self.userId = userId
        self.repository = repository
        self.homeRepository = homeRepository
    }
    @Published var userId: Int = -1
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var posts: [Post] = []
    
    @Published var nickname: String = ""
    
    @Published var leaveProfile: Bool = false
    
    func leaveFromAccount() {
        leaveProfile = true
        KeychainService.shared.delete(key: "access_token")
    }
    
    func getProfile() {
        
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            
            Task {
                isLoading = true
                let profile = if userId == -1 {
                    await repository.getMyProfile(token: accessToken)
                }
                else {
                    await repository.getProfile(token: accessToken, userId: userId)
                }
                if profile.posts.isEmpty {
                    errorMessage = "Не удалось загрузить посты"
                }
                self.posts = profile.posts
                self.nickname = profile.nickname
                isLoading = false
            }
            
        } else {
            print("Access token is missing or empty")
        }
    }
    
    func refresh() {
        getProfile()
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
