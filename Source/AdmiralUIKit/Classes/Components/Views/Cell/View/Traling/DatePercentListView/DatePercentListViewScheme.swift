//
//  DatePercentListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 DatePercentListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DatePercentListViewScheme() - Initialize default DatePercentListViewScheme with default themezation
Example to create DatePercentListViewScheme:
Code
 ```
let scheme = DatePercentListViewScheme()
 ```
 */
public struct DatePercentListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Title color.
    public var titleColor = ControlParameter<AColor>()

    /// Subtitle color.
    public var subtitleColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    /// Subtitle font.
    public var subtitleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.subhead3
        subtitleFont = theme.fonts.subhead3
    }
}
