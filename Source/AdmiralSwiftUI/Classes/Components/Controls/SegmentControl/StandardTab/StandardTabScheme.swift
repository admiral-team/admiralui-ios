//
//  StandardTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.05.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 StandardTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - StandardTabScheme() - Initialize default StandardTabScheme with default themezation
 - StandardTabScheme(
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
 # Example to create StandardTabScheme:
 # Code
 ```
let scheme = StandardTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class StandardTabScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The backgorund color of StandardTab
    public var backgroundColor: AColor

    /// The thumb color of StandardTab
    public var thumbColor = ControlParameter<AColor>()

    /// The border color of StandardTab
    public var borderColor = ControlParameter<AColor>()

    /// The title color of StandardTab
    public var titleColor = ControlParameter<AColor>()

    /// The title font of StandardTab
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundBasic.withAlpha(0.0)

        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleFont.set(parameter: theme.fonts.subhead3, for: .normal)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)


        titleFont.set(parameter: theme.fonts.subhead2, for: .selected)

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
