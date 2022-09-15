//
//  CheckControlStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 CheckControlScheme - the visual scheme of CheckControl.
 You can create a by specifying the following parameters in init:
 - CheckControlScheme() - Initialize default CheckControlScheme with default themezation
 # Example to create CheckControlScheme:
 ```
let scheme = CheckControlScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CheckControlScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The tint color
    public var tintColor = CheckControlParameters<AColor>()

    /// The text color
    public var textColor = ControlParameter<AColor>()

    /// The text font
    public var textFont: AFont

    // MARK: - Initializer
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        
        textFont = theme.fonts.body1

        tintColor.set(parameter: theme.colors.elementAccent, for: .normal, state: .normal)
        tintColor.set(parameter: theme.colors.elementError, for: .normal, state: .error)
        
        tintColor.set(parameter: theme.colors.elementAccent, for: .highlighted, state: .normal)
        tintColor.set(parameter: theme.colors.elementError, for: .highlighted, state: .error)
        
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, state: .normal)
        tintColor.set(parameter: theme.colors.elementError.withAlpha(alpha), for: .disabled, state: .error)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
    }
}

public typealias CheckControlParameters<P> = DoubleParameterBox<ControlState, CheckControlState, P>
