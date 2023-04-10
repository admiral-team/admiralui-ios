//
//  InformerSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 InformerSegmentedScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - InformerSegmentedScheme() - Initialize default InformerSegmentedScheme with default themezation
Example to create InformerSegmentedScheme:
Code
 ```
let scheme = InformerSegmentedScheme()
 ```
 */
public struct InformerSegmentedScheme: AppThemeScheme {

    /// Item scheme.
    public struct ItemScheme {

        /// Title font.
        public var titleFont: AFont = AppTheme.default.fonts.subtitle1

        /// Subtitle font.
        public var subtitleFont: AFont = AppTheme.default.fonts.subhead4

        /// Title color.
        public var titleColor = ControlParameter<AColor>()

        /// Subtitle color.
        public var subtitleColor = ControlParameter<AColor>()

        /// Border color.
        public var borderColor = ControlParameter<AColor>()
    }

    /// Item scheme.
    public var itemScheme = ItemScheme()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.titleFont = theme.fonts.subtitle1
        itemScheme.subtitleFont = theme.fonts.subhead4
        
        itemScheme.titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        
        itemScheme.borderColor.set(parameter: theme.colors.elementAccent, for: [.selected, .normal])
        itemScheme.borderColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        itemScheme.titleColor.set(parameter: theme.colors.textSecondary, for: [.selected, .disabled])
        
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        itemScheme.subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: [.selected, .disabled])
    }
    
}
