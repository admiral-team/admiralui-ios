//
//  UnderlineSliderScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 UnderlineSliderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - UnderlineSliderScheme() - Initialize default UnderlineSliderScheme with default themezation
Example to create UnderlineSliderScheme:
Code
 ```
let scheme = UnderlineSliderScheme()
 ```
 */
public struct UnderlineSliderScheme: AppThemeScheme {

    /// Item scheme.
    public struct ItemScheme {

        /// Title font.
        public var titleFont = ControlParameter<AFont>()

        /// Title color.
        public var titleColor = ControlParameter<AColor>()
    }

    /// Items scheme.
    public var itemScheme = ItemScheme()

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()
    
    /// Badge scheme.
    public var badgeScheme: BadgeScheme
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleFont.set(parameter: theme.fonts.body2, for: .normal)
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: .selected)
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.normal, .selected])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.normal, .highlighted])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.selected, .highlighted])
        itemScheme.titleFont.set(parameter: theme.fonts.body1, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        
        badgeScheme = BadgeScheme(theme: theme)
    }
    
}
