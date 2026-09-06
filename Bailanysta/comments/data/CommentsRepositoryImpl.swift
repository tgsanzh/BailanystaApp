//
//  HomeRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class CommentsRepositoryImpl: CommentsRepository {
    func getComments(id: Int) async -> [Comment] {
        guard let url = URL(string: "\(BASE_URL)/posts/\(id)/comments/") else {
            print("Invalid URL")
            return []
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Полученные данные: \(jsonString)")
            }
            
            let comments = try decoder.decode([CommentsDTO].self, from: data)
            return comments.map { $0.toEntity() }
        } catch {
            print("Ошибка при декодировании: \(error.localizedDescription)")
            return []
        }
    }
    
    func addComment(token: String, comment: String, postId: Int) async -> Int {
        guard let url = URL(string: "\(BASE_URL)/posts/\(postId)/comments") else { return 404 }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let postBody = CommentCreate(content: comment)
        request.httpBody = try? JSONEncoder().encode(postBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data or error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
        }.resume()
        return 200
    }
}


