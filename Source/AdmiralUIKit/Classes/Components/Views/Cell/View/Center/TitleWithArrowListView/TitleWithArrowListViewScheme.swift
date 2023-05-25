//
//  TitleWithArrowListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralTheme

/**
 TitleWithArrowListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleWithArrowListViewScheme() - Initialize default TitleWithArrowListViewScheme with default themezation
Example to create TitleWithArrowListViewScheme:
Code
 ```
let scheme = TitleWithArrowListViewScheme()
 ```
 */
public struct TitleWithArrowListViewScheme: AppThemeScheme {

    /// View background color.
    public var viewBackgroundColor = ControlParameter<AColor>()

    /// Title label text color.
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// Arrow image tint color.
    public var arrowImageTintColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        viewBackgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        viewBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleLabelTextColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        arrowImageTintColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
        arrowImageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.title1
    }
}
