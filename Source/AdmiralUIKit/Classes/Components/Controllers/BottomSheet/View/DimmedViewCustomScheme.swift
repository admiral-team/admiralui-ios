//
//  DimmedViewCustomScheme.swift
//  AdmiralUI
//
//  Created on 22.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct DimmedViewCustomScheme {
    
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundModalView.withAlpha(theme.colors.disabledAlpha)
    }
    
}
