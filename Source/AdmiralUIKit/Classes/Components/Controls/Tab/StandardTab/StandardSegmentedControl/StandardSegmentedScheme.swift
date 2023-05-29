//
//  StandardSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme

/**
 StandardSegmentedScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StandardSegmentedScheme() - Initialize default StandardSegmentedScheme with default themezation
Example to create StandardSegmentedScheme:
Code
 ```
let scheme = StandardSegmentedScheme()
 ```
 */
public struct StandardSegmentedScheme: AppThemeScheme {

    /// Item scheme.
    public struct ItemScheme {

        /// Title color.
        public var titleColor = ControlParameter<AColor>()

        /// Title font.
        public var titleFont = ControlParameter<AFont>()
    }

    /// Item scheme.
    public var itemScheme = ItemScheme()

    /// Border color.
    public var borderColor = ControlParameter<AColor>()

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        itemScheme.titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)

        
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        itemScheme.titleFont.set(parameter: theme.fonts.subhead2, for: [.disabled, .selected])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.disabled, .selected])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.disabled, .selected])
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
    
}
