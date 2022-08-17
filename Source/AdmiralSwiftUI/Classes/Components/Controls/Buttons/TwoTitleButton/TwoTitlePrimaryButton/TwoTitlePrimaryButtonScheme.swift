//
//  TwoTitleButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct TwoTitlePrimaryButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The left title color of TwoTitlePrimaryButton
    public var leftTitleColor = ControlParameter<AColor>()

    /// The left title color of TwoTitlePrimaryButton
    public var rightTitleColor = ControlParameter<AColor>()

    /// The left title color of TwoTitlePrimaryButton
    public var backgroundColor: AColor

    /// The left title color of TwoTitlePrimaryButton
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// The left label font
    public var leftLabelFont: AFont

    /// The right label font
    public var rightLabelFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        leftLabelFont = theme.fonts.subhead3
        rightLabelFont = theme.fonts.body1
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        
        leftTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        leftTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
        
        rightTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        rightTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }
    
}
