//
//  LogoSegmentedScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 LogoSegmentedScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - LogoSegmentedScheme() - Initialize default LogoSegmentedScheme with default themezation
Example to create LogoSegmentedScheme:
Code
 ```
let scheme = LogoSegmentedScheme()
 ```
 */
public struct LogoSegmentedScheme: AppThemeScheme {

    /// Item scheme.
    public struct ItemScheme {

        /// Alpha.
        public var alpha = ControlParameter<CGFloat>()

        /// Border color.
        public var borderColor = ControlParameter<AColor>()
    }

    /// Item scheme.
    public var itemScheme = ItemScheme()

    /// Border color.
    public var borderColor = ControlParameter<AColor>()

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        itemScheme.alpha.set(parameter: 1.0, for: [.selected, .disabled])
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)

        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        itemScheme.borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: [.selected, .disabled])
        itemScheme.alpha.set(parameter: 0.5, for: [.selected, .disabled])
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: [.selected, .disabled])
        
        itemScheme.alpha.set(parameter: 0.5, for: .disabled)
    }
    
}
