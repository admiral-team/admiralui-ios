//
//  SeveralPinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct SeveralPinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The border color of SeveralPinButton
    public var borderColor: AColor

    /// The background color of SeveralPinButton
    public var backgroundColor: AColor

    /// The text color of SeveralPinButton
    public var textColor: AColor

    /// The shadow color of SeveralPinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
        borderColor = theme.colors.backgroundAccent
        shadowColor = theme.colors.backgroundShadow
    }
    
}
