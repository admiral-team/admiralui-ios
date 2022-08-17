//
//  CheckControlStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public typealias CheckControlParameters<P> = DoubleParameterBox<ControlState, CheckControlState, P>

@available(iOS 14.0.0, *)
public struct CheckControlScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The tint color of CheckControl
    public var tintColor = CheckControlParameters<AColor>()

    /// The text color of CheckControl
    public var textColor = ControlParameter<AColor>()

    /// The text font of  CheckControl
    public var textFont: AFont

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
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
