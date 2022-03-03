//
//  CirclePageControlScheme.swift
//  AdmiralUI
//
//  Created on 27.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CirclePageControlScheme {
    
    var backgroundColor: AColor
    var centerButtonBackgroundColor: AColor
    var progressColor: AColor
    var buttonImageColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        centerButtonBackgroundColor = theme.colors.elementAccent
        progressColor = theme.colors.elementAccent
        buttonImageColor = theme.colors.elementStaticWhite
    }
    
}
