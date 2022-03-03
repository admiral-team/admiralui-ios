//
//  TitleButtonDropDownScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct TitleButtonDropDownScheme {
    
    var backgroundColor: AColor
    var titleFont: AFont
    var textColor = ControlParameter<AColor>()
    var ghostButtonScheme: HeaderButtonWithArrowScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        titleFont = theme.fonts.headline
        ghostButtonScheme = HeaderButtonWithArrowScheme(theme: theme)
    }
}

