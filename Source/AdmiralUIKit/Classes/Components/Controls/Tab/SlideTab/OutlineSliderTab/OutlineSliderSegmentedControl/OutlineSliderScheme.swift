//
//  OutlineSliderScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 OutlineSliderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - OutlineSliderScheme() - Initialize default OutlineSliderScheme with default themezation
Example to create OutlineSliderScheme:
Code
 ```
let scheme = OutlineSliderScheme()
 ```
 */
public struct OutlineSliderScheme: AppThemeScheme {

    /// Item scheme.
    public struct ItemScheme {
        
        /// Title font.
        public var titleFont = ControlParameter<AFont>()

        /// Title color.
        public var titleColor = ControlParameter<AColor>()
    }

    /// Item scheme.
    public var itemScheme = ItemScheme()

    /// Badge scheme.
    public var badgeScheme: BadgeScheme

    /// Badge border color.
    public var badgeBorderColor: AColor

    /// Border color.
    public var borderColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        badgeBorderColor = theme.colors.backgroundBasic

        itemScheme.titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.normal, .selected])
        borderColor.set(parameter: theme.colors.elementAccent, for: [.normal, .selected])
        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        borderColor.set(parameter: theme.colors.elementAccent, for: .selected)

        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.selected, .highlighted])
        borderColor.set(parameter: theme.colors.elementAccent, for: [.selected, .highlighted])

        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.selected, .disabled])
        borderColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)

        badgeScheme = BadgeScheme(theme: theme)
    }
    
}
