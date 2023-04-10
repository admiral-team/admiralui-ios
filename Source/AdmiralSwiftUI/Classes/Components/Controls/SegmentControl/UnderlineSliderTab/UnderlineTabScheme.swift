//
//  UnderlineTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 UnderlineTabScheme - the visual scheme of UnderlineTab.
 You can create a by specifying the following parameters in init:
 - UnderlineTabScheme() - Initialize default UnderlineTabScheme with default themezation
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

}
