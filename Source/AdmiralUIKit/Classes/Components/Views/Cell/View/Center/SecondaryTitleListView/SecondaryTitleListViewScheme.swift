//
//  SecondaryTitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 SecondaryTitleListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SecondaryTitleListViewScheme() - Initialize default SecondaryTitleListViewScheme with default themezation
Example to create SecondaryTitleListViewScheme:
Code
 ```
let scheme = SecondaryTitleListViewScheme()
 ```
 */
public struct SecondaryTitleListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Text color.
    public var textColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.headline
    }
}
