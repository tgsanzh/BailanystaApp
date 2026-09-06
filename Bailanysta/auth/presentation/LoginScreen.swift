//
//  LoginScreen.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct LoginScreen: View {
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel.shared
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        VStack() {
            Text("Вход").font(.largeTitle).padding(.bottom, 28)
            appTextField(text: $viewModel.nickname, placeholder: "Введите почту").padding(.bottom, 10)
            appSecureField(text: $viewModel.password, placeholder: "Введите пароль").padding(.bottom, 10)
            appButton(title: "Войти", isLoading: $viewModel.isLoading) {
                viewModel.login()
            }
            
            Text(viewModel.errorText)
                .font(Font.system(size: 12))
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 0))
            
            NavigationLink(
                destination: RegisterScreen()
                    .environmentObject(themeManager),
                label: {
                    Text("У меня нету аккаунта")
                        .foregroundColor(.blue)
                }
            )
            
            
        }
        .navigationDestination(isPresented: $viewModel.isActive) {
            MainTabView()
                .environmentObject(themeManager)
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginScreen()
        .environmentObject(ThemeManager())
}
