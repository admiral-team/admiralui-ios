//
//  OutlineSliderTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 OutlineSliderTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - OutlineSliderTabScheme() - Initialize default OutlineSliderTabScheme with default themezation
 - OutlineSliderTabScheme(
     backgroundColor: AColor,
     titleColorNormal: AColor,
     titleFontNormal: AFont,
     borderColorNormal: AColor,
     borderColorDisabled: AColor,
     thumbColorSelected: AColor,
     thumbColorDisabled: AColor,
     titleFontSelected:  AFont,
     titleColorDisabled: AColor,
     titleColorSelected: AColor
   )
 # Example to create OutlineSliderTabScheme:
 # Code
 ```
let scheme = OutlineSliderTabScheme()
 ```
 */
@available(iOS 14.0, *)
/// Outline slider tab scheme.
public final class OutlineSliderTabScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// Background color.
    public var backgroundColor: AColor

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()

    /// Border color.
    public var borderColor = ControlParameter<AColor>()

    /// Title item color.
    public var titleColor = ControlParameter<AColor>()

    /// Title item font.
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public convenience init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        self.init(
            backgroundColor: theme.colors.backgroundBasic,
            titleColorNormal: theme.colors.textPrimary,
            titleFontNormal: theme.fonts.subhead3,
            borderColorNormal: theme.colors.elementAdditional,
            borderColorDisabled: theme.colors.elementAdditional.withAlpha(alpha),
            thumbColorSelected: theme.colors.elementAccent,
            thumbColorDisabled: theme.colors.elementAccent.withAlpha(alpha),
            titleFontSelected: theme.fonts.subhead2,
            titleColorDisabled: theme.colors.textSecondary,
            titleColorSelected: theme.colors.textSecondary
        )
    }

    public init(
        backgroundColor: AColor,
        titleColorNormal: AColor,
        titleFontNormal: AFont,
        borderColorNormal: AColor,
        borderColorDisabled: AColor,
        thumbColorSelected: AColor,
        thumbColorDisabled: AColor,
        titleFontSelected:  AFont,
        titleColorDisabled: AColor,
        titleColorSelected: AColor
    ) {
        self.backgroundColor = backgroundColor

        titleColor.set(parameter: titleColorNormal, for: .normal)
        titleFont.set(parameter: titleFontNormal, for: .normal)

        borderColor.set(parameter: borderColorNormal, for: .normal)
        borderColor.set(parameter: borderColorDisabled, for: .disabled)

        thumbColor.set(parameter: thumbColorSelected, for: .selected)
        thumbColor.set(parameter: thumbColorDisabled, for: .disabled)

        titleFont.set(parameter: titleFontSelected, for: .selected)

        titleColor.set(parameter: titleColorDisabled, for: .disabled)
        titleColor.set(parameter: titleColorSelected, for: .selected)
    }

}
