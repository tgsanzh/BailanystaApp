//
//  NotificationRepositoryImpl.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class NotificationRepositoryImpl: NotificationRepository {
    
    func getNotifications(token: String) async -> [Notification] {
        guard let url = URL(string: "\(BASE_URL)/notifications/") else {
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
            
            let notifications = try decoder.decode([NotificationsDTO].self, from: data)
            return notifications.map { $0.toEntity() }
        } catch {
            print("Ошибка при декодировании: \(error.localizedDescription)")
            return []
        }
    }
}
