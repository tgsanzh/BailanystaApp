//
//  LoginViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel(repository: AuthRepositoryImpl())
    
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    @Published var nickname: String = ""
    @Published var password: String = ""
    @Published var navigateToRegister: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var errorText: String = ""
    
    @Published var isActive: Bool = false
    
    func login() {
        
        if nickname.isEmpty {
            errorText = "Необходимо ввести никнейм"
            return
        }
        else if password.isEmpty {
            errorText = "Необходимо ввести пароль"
            return
        }
        
        isLoading = true
        repository.login(nickname: nickname, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                    case .success(let token):
                        KeychainService.shared.save(key: "access_token", value: token.accessToken)
                        print("Access token: \(token.accessToken)")
                        self?.isActive = true
                    case .failure(let error):
                        self?.errorText = error.localizedDescription
                        print("Ошибка входа: \(error.localizedDescription)")
                }
            }
        }
    }
}
