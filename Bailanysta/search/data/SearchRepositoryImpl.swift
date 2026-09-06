//
//  HomeRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class SearchRepositoryImpl: SearchRepository {
    func getPosts(token: String, search: String) async -> [Post] {
        guard let url = URL(string: "\(BASE_URL)/posts/search/\(search)") else {
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
}
