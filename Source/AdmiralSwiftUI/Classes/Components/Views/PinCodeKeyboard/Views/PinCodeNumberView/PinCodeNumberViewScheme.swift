//
//  PinCodeNumberViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 30.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PinCodeNumberViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PinCodeNumberView
    public var backgroundColor = ControlParameter<AColor>()

    /// The background color of PinCodeNumberView
    public var imageColor: AColor

    /// The background color of PinCodeNumberView
    public var textColor: AColor

    /// The background color of PinCodeNumberView
    public var textFont: AFont

    // MARK: - Initializer
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        
        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        textFont = theme.fonts.body2
    }
    
}
