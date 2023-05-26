//
//  IconTabsItemScheme.swift
//  AdmiralUI
//
//  Created on 12.02.2021.
//

import AdmiralTheme

/**
 IconTabsItemScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - IconTabsItemScheme() - Initialize default IconTabsItemScheme with default themezation
Example to create IconTabsItemScheme:
Code
 ```
let scheme = IconTabsItemScheme()
 ```
 */
public struct IconTabsItemScheme: AppThemeScheme {

    /// Title color.
    public var titleColor = ControlParameter<AColor>()

    /// Image color.
    public var imageColor = ControlParameter<AColor>()

    /// Content view background color.
    public var contentViewBackGroundColor = ControlParameter<AColor>()

    /// Background color.
    public var backgroundColor: AColor

    /// Title label font.
    public var titleLabelFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.subhead2
        backgroundColor = theme.colors.backgroundBasic
        
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        imageColor.set(parameter: theme.colors.elementAccent, for: .normal)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)

        titleColor.set(parameter: theme.colors.textAccent, for: .selected)
        imageColor.set(parameter: theme.colors.elementStaticWhite, for: .selected)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
        
        titleColor.set(parameter: theme.colors.textAccent, for: [.selected, .highlighted])
        imageColor.set(parameter: theme.colors.elementStaticWhite, for: [.selected, .highlighted])
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent, for: [.selected, .highlighted])
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
        
        titleColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: [.selected, .disabled])
        imageColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: [.selected, .disabled])
        contentViewBackGroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: [.selected, .disabled])
    }
    
}
