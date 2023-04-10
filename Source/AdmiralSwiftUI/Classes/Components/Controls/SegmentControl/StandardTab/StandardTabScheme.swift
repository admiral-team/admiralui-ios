//
//  StandardTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.05.2021.
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 StandardTabScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StandardTabScheme() - Initialize default StandardTabScheme with default themezation
 # Example to create StandardTabScheme:
 # Code
 ```
let scheme = StandardTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class StandardTabScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The backgorund color
    public var backgroundColor: AColor

    /// The thumb color
    public var thumbColor = ControlParameter<AColor>()

    /// The border color
    public var borderColor = ControlParameter<AColor>()

    /// The title color
    public var titleColor = ControlParameter<AColor>()

    /// The title font
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundBasic.withAlpha(0.0)

        titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        titleFont.set(parameter: theme.fonts.subhead3, for: .normal)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)

        titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .selected)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)

        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

}
