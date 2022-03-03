//
//  IconTabsItemScheme.swift
//  AdmiralUI
//
//  Created on 12.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct IconTabsItemScheme {
    
    var titleColor = ControlParameter<AColor>()
    var imageColor = ControlParameter<AColor>()
    var contentViewBackGroundColor = ControlParameter<AColor>()
    var backgroundColor: AColor
 
    var titleLabelFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.subhead2
        backgroundColor = theme.colors.backgroundBasic
        
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        imageColor.set(parameter: theme.colors.elementAccent, for: .normal)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)

        titleColor.set(parameter: theme.colors.textAccent, for: .selected)
        imageColor.set(parameter: theme.colors.elementStaticWhite, for: .selected)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
        
        titleColor.set(parameter: theme.colors.textAccent, for: [.selected, .highlighted])
        imageColor.set(parameter: theme.colors.elementStaticWhite, for: [.selected, .highlighted])
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent, for: [.selected, .highlighted])
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
        
        titleColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.selected, .disabled])
        imageColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: [.selected, .disabled])
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: [.selected, .disabled])
    }
    
}
