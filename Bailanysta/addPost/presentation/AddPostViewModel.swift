//
//  AddPostViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

final class AddPostViewModel: ObservableObject {
    static let shared = AddPostViewModel(repository: AddPostRepositoryImpl())
    
    private let repository: AddPostRepository
    
    init(repository: AddPostRepository) {
        self.repository = repository
    }
    
    @Published var showSuccessAlert: Bool = false
    @Published var text: String = "Hello world!"
    @Published var isLoading: Bool = false
    
    func addPost() {
        if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
            isLoading = true
            Task {
                await repository.addPost(content: text, token: accessToken)
            }
            showSuccessAlert = true
            isLoading = false
            
        } else {
            print("Access token is missing or empty")
        }
        
    }
}
