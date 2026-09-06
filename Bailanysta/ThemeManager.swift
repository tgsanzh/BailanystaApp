//
//  ThemeManager.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "appTheme"), savedTheme == "dark" {
            currentTheme = .dark
        } else {
            currentTheme = .light
        }
    }
    
    func switchToLightTheme() {
        currentTheme = .light
        UserDefaults.standard.set("light", forKey: "appTheme")
    }
    
    func switchToDarkTheme() {
        currentTheme = .dark
        UserDefaults.standard.set("dark", forKey: "appTheme")
    }
}
