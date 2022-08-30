//
//  UnderlineTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources
/**
 UnderlineTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - UnderlineTabScheme() - Initialize default UnderlineTabScheme with default themezation
 - UnderlineTabScheme(
     backgroundColor: AColor,
     titleColorNormal: AColor,
     titleFontNormal: AFont,
     borderColorNormal: AColor,
     borderColorDisabled: AColor,
     thumbColorNormal: AColor,
     thumbColorSelected: AColor,
     titleFontSelected: AFont,
     titleColorDisabled: AColor,
     titleColorSelected: AColor,
     thumbColorDisabled: AColor
   )
 # Example to create UnderlineTabScheme:
 # Code
 ```
let scheme = UnderlineTabScheme()
 ```
 */
@available(iOS 14.0, *)
/// Underline tab scheme.
public struct UnderlineTabScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// Background color.
    public var backgroundColor: AColor

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()

    /// Border color.
    public var borderColor = ControlParameter<AColor>()

    /// Title color.
    public var titleColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundBasic

        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleFont.set(parameter: theme.fonts.body2, for: .normal)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)

        titleFont.set(parameter: theme.fonts.body1, for: .selected)

        titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .selected)

        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

    public init(
        backgroundColor: AColor,
        titleColorNormal: AColor,
        titleFontNormal: AFont,
        borderColorNormal: AColor,
        borderColorDisabled: AColor,
        thumbColorNormal: AColor,
        thumbColorSelected: AColor,
        titleFontSelected: AFont,
        titleColorDisabled: AColor,
        titleColorSelected: AColor,
        thumbColorDisabled: AColor
    ) {
        self.backgroundColor = backgroundColor

        titleColor.set(parameter: titleColorNormal, for: .normal)
        titleFont.set(parameter: titleFontNormal, for: .normal)

        borderColor.set(parameter: borderColorNormal, for: .normal)
        borderColor.set(parameter: borderColorDisabled, for: .disabled)
        thumbColor.set(parameter: thumbColorNormal, for: .normal)
        thumbColor.set(parameter: thumbColorSelected, for: .selected)

        titleFont.set(parameter: titleFontSelected, for: .selected)

        titleColor.set(parameter: titleColorDisabled, for: .disabled)
        titleColor.set(parameter: titleColorSelected, for: .selected)

        thumbColor.set(parameter: thumbColorDisabled, for: .disabled)
    }

}
