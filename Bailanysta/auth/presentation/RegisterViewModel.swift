//
//  RegisterViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    static let shared = RegisterViewModel()
    
    @Published var nickname: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    
    @Published var errorText: String = ""
    
    @Published var isActive: Bool = false
    
    func register() {
        if nickname.isEmpty {
            errorText = "Необходимо ввести никнейм"
            return
        }
        else if password.count < 8 {
            errorText = "Пароль должен состоять минимум из 8 символов"
            return
        }
        else if password != confirmPassword {
            errorText = "Пароли не совпадают"
            return
        }
        isLoading = true
        let authRepo: AuthRepository = AuthRepositoryImpl()
        authRepo.register(nickname: nickname, password: password) { result in
            switch result {
                case
                    .success(let token):
                        KeychainService.shared.save(key: "access_token", value: token.accessToken)
                        print("Access token: \(token.accessToken)")
                        self.isActive = true
                case
                    .failure(let error):
                        self.errorText = error.localizedDescription
                        print("Error: \(error.localizedDescription)")
            }
            self.isLoading = false
        }
        

    }
}
