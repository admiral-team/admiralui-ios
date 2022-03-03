//
//  SecondaryTitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SecondaryTitleListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var textColor = ControlParameter<AColor>()
    
    public var titleFont: AFont
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.headline
    }
}
