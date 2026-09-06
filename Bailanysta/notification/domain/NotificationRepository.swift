//
//  NotificationRepository.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

protocol NotificationRepository {
    func getNotifications(token: String) async -> [Notification]
}
