//
//  CommentsScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct CommentsScreen: View {
    
    @ObservedObject var viewModel: CommentsViewModel
    
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 12) {
            
            HStack {
                appTextField(text: $viewModel.commentText, placeholder: "Написать комментарии...")
                
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    .onTapGesture {
                        viewModel.addComment()
                    }
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: themeManager.currentTheme.buttonColor))
                    .padding(8)
            }
            
            ScrollView { 
                ForEach (viewModel.comments) { comment in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            NavigationLink(
                                destination: ProfileScreen(
                                    viewModel: ProfileViewModel(userId: comment.userId, repository: ProfileRepositoryImpl())
                                )
                                    .environmentObject(themeManager),
                                label: {
                                    Text(comment.nickname)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            )
                            Text(comment.formattedDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        

                        Text(comment.content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                        
                        .padding(.top, 4)
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
    }
}
