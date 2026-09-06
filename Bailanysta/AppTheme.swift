//
//  AppTheme.swift
//  Bailanysta
//
//  Created by Sanzhar Tursynbay on 06.09.2026.
//

import SwiftUI

struct Theme {
    var primaryColor: Color
    var secondaryColor: Color
    var backgroundColor: Color
    var textColor: Color
    var buttonColor: Color
    
    static let light = Theme(
        primaryColor: .blue,
        secondaryColor: .gray,
        backgroundColor: .white,
        textColor: .gray,
        buttonColor: .blue,
    )
    
    static let dark = Theme(
        primaryColor: .yellow,
        secondaryColor: .gray,
        backgroundColor: .black,
        textColor: .white,
        buttonColor: .yellow,
    )
}
