//
//  InformerTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 27.04.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources
/**
 InformerTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - InformerTabScheme() - Initialize default InformerTabScheme with default themezation
 # Example to create InformerTabScheme:
 # Code
 ```
let scheme = InformerTabScheme()
 ```
 */
@available(iOS 14.0, *)
public final class InformerTabScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of InformerTab
    public var backgroundColor: AColor

    /// The thumb color of InformerTab
    public var thumbColor = ControlParameter<AColor>()

    /// The border color of InformerTab
    public var borderColor = ControlParameter<AColor>()

    /// The title color of InformerTab
    public var titleColor = ControlParameter<AColor>()

    /// The title font color of InformerTab
    public var titleFont = ControlParameter<AFont>()

    /// The subtitle color of InformerTab
    public var subtitleColor = ControlParameter<AColor>()

    /// The subtitle font color of InformerTab
    public var subtitleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundBasic

        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal)

        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)

        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .selected)

        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .selected)

        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

}
