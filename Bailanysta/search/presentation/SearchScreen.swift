//
//  HomeScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct SearchScreen: View {
    
    @ObservedObject private var viewModel: SearchViewModel = SearchViewModel.shared
    
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 12) {
            
            appTextField(text: $viewModel.searchText, placeholder: "Поиск...")
                .onChange(of: viewModel.searchText) {
                    viewModel.refresh()
                }

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: themeManager.currentTheme.buttonColor))
                    .padding(8)
            }
            
            ScrollView {
                ForEach (viewModel.posts) { post in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            NavigationLink(
                                destination: ProfileScreen(
                                    viewModel: ProfileViewModel(userId: post.userId, repository: ProfileRepositoryImpl())
                                )
                                    .environmentObject(themeManager),
                                label: {
                                    Text(post.nickname)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            )
                            Text(post.formattedDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        

                        Text(post.content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                        
                        HStack(alignment: .center, spacing: 12) {
                            HStack(spacing: 4) {
                                Text("\(post.likesCount)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if post.liked {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            viewModel.unlike(postId: post.id)
                                        }
                                }
                                else {
                                    Image(systemName: "heart")
                                        .foregroundColor(.secondary)
                                        .onTapGesture {
                                            viewModel.like(postId: post.id)
                                        }
                                }
                            }
                            
                            HStack(spacing: 4) {
                                Text("\(post.commentsCount)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                NavigationLink(
                                    destination: CommentsScreen(
                                        viewModel: CommentsViewModel(repository: CommentsRepositoryImpl(), postId: post.id)
                                    )
                                        .environmentObject(themeManager),
                                    label: {
                                        Image(systemName: "bubble.right")
                                            .foregroundColor(.secondary)
                                    }
                                )
                            }
                        }
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
        
        .navigationBarBackButtonHidden(true)
    }

}

