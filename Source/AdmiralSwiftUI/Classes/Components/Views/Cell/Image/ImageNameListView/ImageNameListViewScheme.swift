//
//  ImageNameListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageNameListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var backgroundNameViewColor = ControlParameter<AColor>()
    public var titleLabelTextColor = ControlParameter<AColor>()
    
    public var titleFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        titleLabelTextColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
        
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary, for: .normal)
        backgroundNameViewColor.set(parameter: theme.colors.backgroundSecondary.withAlpha(alpha), for: .disabled)
        titleFont = theme.fonts.subhead1
    }
}
