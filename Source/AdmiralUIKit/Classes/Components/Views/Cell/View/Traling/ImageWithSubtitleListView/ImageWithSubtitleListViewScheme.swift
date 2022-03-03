//
//  ImageWithSubtitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ImageWithSubtitleListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var imageTintColor = ControlParameter<AColor>()
    var subtitleLabelTextColor = ControlParameter<AColor>()
    
    var subtitleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        subtitleFont = theme.fonts.subhead3
    }
}
