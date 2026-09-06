//
//  NotificationScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct NotificationScreen: View {
    
    @ObservedObject var viewModel: NotificationViewModel = NotificationViewModel.shared
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(spacing: 12) {
            
            Text("Уведомления")
                            .font(.title)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: themeManager.currentTheme.buttonColor))
                    .padding(8)
            }
            
            ScrollView {
                ForEach (viewModel.notifications) { notification in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(notification.message)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                        
                        .padding(.top, 4)
                        
                        Text(notification.formattedDate)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.3), radius: 2)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            viewModel.refresh()
        }
        .navigationBarBackButtonHidden(true)
    }
}
