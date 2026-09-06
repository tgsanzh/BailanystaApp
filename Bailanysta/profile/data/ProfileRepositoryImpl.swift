//
//  HomeRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class ProfileRepositoryImpl: ProfileRepository {
    func getProfile(token: String, userId: Int) async -> Profile {
        guard let url = URL(string: "\(BASE_URL)/users/\(userId)") else {
            print("Invalid URL")
            return Profile(nickname: "", posts: [])
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
            
            let profile = try decoder.decode(ProfileResponseDTO.self, from: data)
            return profile.toEntity()
        } catch {
            print("Ошибка при декодировании: \(error.localizedDescription)")
            return Profile(nickname: "", posts: [])
        }
    }
    
    func getMyProfile(token: String) async -> Profile {
        guard let url = URL(string: "\(BASE_URL)/users/me") else {
            print("Invalid URL")
            return Profile(nickname: "", posts: [])
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
            
            let profile = try decoder.decode(ProfileResponseDTO.self, from: data)
            return profile.toEntity()
        } catch {
            print("Ошибка при декодировании: \(error.localizedDescription)")
            return Profile(nickname: "", posts: [])
        }
    }
}
