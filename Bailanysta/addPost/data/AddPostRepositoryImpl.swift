//
//  AddPostRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class AddPostRepositoryImpl: AddPostRepository {
    func addPost(content: String, token: String) async {
        guard let url = URL(string: "\(BASE_URL)/posts/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let postBody = PostCreate(content: content)
        request.httpBody = try? JSONEncoder().encode(postBody)

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
    }
}
