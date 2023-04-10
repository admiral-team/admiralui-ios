//
//  TitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TitleListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleListViewScheme() - Initialize default TitleListViewScheme with default themezation
Example to create TitleListViewScheme:
Code
 ```
let scheme = TitleListViewScheme()
 ```
 */
public struct TitleListViewScheme: AppThemeScheme {

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
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        titleFont = theme.fonts.body1
    }
}
