//
//  LoginRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    
    func login(nickname: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void) {
        guard let url = URL(string: "\(BASE_URL)/auth/login") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0)))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body = AuthRequestDTO(nickname: nickname, password: password)
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 0)))
                    return
                }

                do {
                    let responseDTO = try JSONDecoder().decode(AuthResponseDTO.self, from: data)
                    completion(.success(responseDTO.toEntity()))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
    }
    
    func register(nickname: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void) {
        guard let url = URL(string: "\(BASE_URL)/auth/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = AuthRequestDTO(nickname: nickname, password: password)
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let responseDTO = try JSONDecoder().decode(AuthResponseDTO.self, from: data)
                completion(.success(responseDTO.toEntity()))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
