//
//  RegisterScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct RegisterScreen: View {
    @ObservedObject private var viewModel: RegisterViewModel = RegisterViewModel.shared
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack() {
            Text("Регистрация").font(.largeTitle).padding(.bottom, 28)
            appTextField(text: $viewModel.nickname, placeholder: "Введите никнейм").padding(.bottom, 10)
            appSecureField(text: $viewModel.password, placeholder: "Введите пароль").padding(.bottom, 10)
            appSecureField(text: $viewModel.confirmPassword, placeholder: "Повторите пароль").padding(.bottom, 10)
            
            appButton(title: "Зарегистрироваться", isLoading: $viewModel.isLoading) {
                viewModel.register()
            }
            
            Text(viewModel.errorText)
                .font(Font.system(size: 12))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 0))
        
            Text("У меня уже есть аккаунт")
                .foregroundColor(.blue)
                .onTapGesture {
                    dismiss()
                }
        }
        .navigationDestination(isPresented: $viewModel.isActive) {        
            MainTabView()
                .environmentObject(themeManager)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterScreen()
        .environmentObject(ThemeManager())
}
