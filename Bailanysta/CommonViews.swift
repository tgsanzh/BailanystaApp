//
//  CommonViews.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct appTextField: View {
    @Binding var text: String
    let placeholder: String
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.currentTheme.backgroundColor)
                .shadow(radius: 2)
            
            TextField(placeholder, text: $text)
                .padding()
                .foregroundColor(themeManager.currentTheme.textColor)
                .autocapitalization(.none)
        }
        .autocorrectionDisabled(true)
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct appSecureField: View {
    @Binding var text: String
    let placeholder: String
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(themeManager.currentTheme.backgroundColor)
                .shadow(radius: 2)
            
            SecureField(placeholder, text: $text)
                .padding()
                .foregroundColor(themeManager.currentTheme.textColor)
                .autocapitalization(.none)
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
}

struct appButton: View {
    let title: String
    @Binding var isLoading: Bool
    let action: () -> Void
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: themeManager.currentTheme.backgroundColor))
                        .padding(.trailing, 8) // Отступ между индикатором и текстом
                } else {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(themeManager.currentTheme.backgroundColor)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(themeManager.currentTheme.primaryColor)
            .cornerRadius(16)
        }
        .disabled(isLoading)
        .padding(.horizontal)
    }
}
