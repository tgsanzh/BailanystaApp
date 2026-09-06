//
//  HomeRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class HomeRepositoryImpl: HomeRepository {
    func getPosts(token: String) async -> [Post] {
        guard let url = URL(string: "\(BASE_URL)/posts/") else {
            print("Invalid URL")
            return []
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Полученные данные: \(jsonString)")
            }
            
            let posts = try decoder.decode([PostsResponseDTO].self, from: data)
            return posts.map { $0.toEntity() }
        } catch {
            print("Ошибка при декодировании: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func like(token: String, postId: Int) async -> Int {
        guard let url = URL(string: "\(BASE_URL)/posts/\(postId)/like") else { return 404 }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data or error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let result = try JSONDecoder().decode(PostResponse.self, from: data)
                print("Status: \(result.status), Code: \(result.status_code)")
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
            }
        }.resume()
        return 200
    }

    func unlike(token: String, postId: Int) async -> Int {
        guard let url = URL(string: "\(BASE_URL)/posts/\(postId)/unlike") else { return 404 }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data or error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let result = try JSONDecoder().decode(PostResponse.self, from: data)
                print("Status: \(result.status), Code: \(result.status_code)")
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
            }
        }.resume()
        
        return 200
    }
    
}

