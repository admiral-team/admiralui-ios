//
//  HeaderButtonWithArrowScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct HeaderButtonWithArrowScheme {
    
    var textColor = ControlParameter<AColor>()
    var titleLabelFont: AFont
    
    var imageColor = ControlParameter<AColor>()
    

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: [.normal])
        textColor.set(parameter: theme.colors.textAccentPressed, for: [.highlighted])
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.disabled])
        
        imageColor.set(parameter: theme.colors.elementAccent, for: [.normal])
        imageColor.set(parameter: theme.colors.elementAccentPressed, for: [.highlighted])
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled])
        
    }
    
}

