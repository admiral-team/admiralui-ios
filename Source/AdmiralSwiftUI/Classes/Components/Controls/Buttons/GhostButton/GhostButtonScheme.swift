//
//  GhostButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 GhostButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - GhostButtonScheme() - Initialize default GhostButtonScheme with default themezation
 - GhostButtonScheme(
     font: AFont,
     textColorNormal: AColor,
     textColorHighlighted: AColor,
     textColorDisabled: AColor
   )
 # Example to create GhostButtonScheme:
 # Code
 ```
let scheme = GhostButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct GhostButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The font color of GhostButton
    public let font: AFont

    /// The text color GhostButton
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        font = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }

    public init(
        font: AFont,
        textColorNormal: AColor,
        textColorHighlighted: AColor,
        textColorDisabled: AColor
    ) {
        self.font = font
        textColor.set(parameter: textColorNormal, for: .normal)
        textColor.set(parameter: textColorHighlighted, for: .highlighted)
        textColor.set(parameter: textColorDisabled, for: .disabled)
    }
}
