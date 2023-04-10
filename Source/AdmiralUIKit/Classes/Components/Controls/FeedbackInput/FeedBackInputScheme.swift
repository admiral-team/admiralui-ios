//
//  FeedBackInputScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 FeedBackInputScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - FeedBackInputScheme() - Initialize default FeedBackInputScheme with default themezation
Example to create FeedBackInputScheme:
Code
 ```
let scheme = FeedBackInputScheme()
 ```
 */
public struct FeedBackInputScheme: AppThemeScheme {

    /// Default color.
    public var defaultColor = ControlParameter<AColor>()

    /// Selected color.
    public var selectedColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        defaultColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        selectedColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        defaultColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        selectedColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
