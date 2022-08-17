//
//  LogoTabObservable.swift
//  AdmiralUIResources
//
//  Created on 21.04.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public final class LogoTabScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of LogoTab
    public var backgroundColor: AColor

    /// The thumb color of LogoTab
    public var thumbColor = ControlParameter<AColor>()

    /// The border color of LogoTab
    public var borderColor = ControlParameter<AColor>()

    /// The alpha color of LogoTab
    public var alphaLogo = ControlParameter<Double>()

    // MARK: - Initializer
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor = theme.colors.backgroundBasic
        
        alphaLogo.set(parameter: 1.0, for: .normal)
        alphaLogo.set(parameter: 0.5, for: .disabled)
        
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
    
}
