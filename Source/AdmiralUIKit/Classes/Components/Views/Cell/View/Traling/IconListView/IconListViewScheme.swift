//
//  IconListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct IconListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var imageTintColor = ControlParameter<AColor>()
    var imageViewAlpha = ControlParameter<CGFloat>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
}
