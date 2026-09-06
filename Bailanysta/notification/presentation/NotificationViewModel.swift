//
//  NotificationViewModel.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import Foundation

final class NotificationViewModel: ObservableObject {
    static let shared: NotificationViewModel = NotificationViewModel()
    var repository: NotificationRepository
    
    init(repository: NotificationRepository = NotificationRepositoryImpl())
    {
        self.repository = repository
    }
    
    @Published var notifications: [Notification] = []
    @Published var isLoading: Bool = false
    
    func getNotifications() {
        Task {
            if let accessToken = KeychainService.shared.load(key: "access_token"), !accessToken.isEmpty {
                Task {
                    isLoading = true
                    let notifications = await repository.getNotifications(token: accessToken)
                    self.notifications = notifications
                    isLoading = false
                }
                
            } else {
                print("Access token is missing or empty")
            }
        }
    }
    
    func refresh() {
        getNotifications()
    }
}
