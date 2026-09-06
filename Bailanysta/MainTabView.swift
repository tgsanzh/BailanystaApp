//
//  MainTabView.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen()
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Главная", systemImage: "house.fill")
            }

            NavigationStack {
                SearchScreen()
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Поиск", systemImage: "magnifyingglass")
            }

            NavigationStack {
                AddPostScreen()
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Написать", systemImage: "plus.circle")
            }
            
            NavigationStack {
                NotificationScreen()
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Уведомления", systemImage: "bell.fill")
            }
            
            NavigationStack {
                ProfileScreen(viewModel: ProfileViewModel(userId: -1, repository: ProfileRepositoryImpl()))
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Профиль", systemImage: "person.fill")
            }
        }
    }
}
