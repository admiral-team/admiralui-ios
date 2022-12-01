//
//  ImageNameListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 ImageNameListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ImageNameListViewScheme() - Initialize default ImageNameListViewScheme with default themezation
Example to create ImageNameListViewScheme:
Code
 ```
let scheme = ImageNameListViewScheme()
 ```
 */
public struct ImageNameListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Background name view color.
    public var backgroundNameViewColor = ControlParameter<AColor>()

    /// Title label text color.
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont
    
    public init(theme: AppTheme = .default) {
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
