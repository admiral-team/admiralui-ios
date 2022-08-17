//
//  InputNumberStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public final class InputNumberScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title of InputNumber
    public var titleFont = ControlParameter<AFont>()

    /// The number font of InputNumber
    public var numberFont = ControlParameter<AFont>()

    /// The text color of InputNumber
    public var textColor = ControlParameter<AColor>()

    /// The tint color of InputNumber
    public var tintColor = ControlParameter<AColor>()

    /// The background color of InputNumber
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal)
        numberFont.set(parameter: theme.fonts.body1, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        tintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        tintColor.set(parameter: theme.colors.textSecondary, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        tintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
    }
    
}
