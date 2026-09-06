//
//  NotificationMapper.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

extension NotificationsDTO {
    func toEntity() -> Notification {
        return Notification(
            id: id,
            message: message,
            postId: postId,
            createdAt: createdAt
        )
    }
}
