//
//  AddPostScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct AddPostScreen: View {
    
    @ObservedObject var viewModel: AddPostViewModel = AddPostViewModel.shared
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack {
            TextEditor(text: $viewModel.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .font(.title)
            
            appButton(title: "Опубликовать пост", isLoading: $viewModel.isLoading) {
                viewModel.addPost()
            }
            .padding()
            
        }
        .alert("Успешно", isPresented: $viewModel.showSuccessAlert) {
                Button("Ок", role: .cancel) {}
            } message: {
                Text("Пост успешно отправлен")
            }
    }
}
