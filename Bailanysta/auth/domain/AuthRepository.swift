//
//  LoginRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol AuthRepository {
    func register(nickname: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void)
    func login(nickname: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void)
}
