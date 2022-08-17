//
//  StandardTabStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.05.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public final class StandardTabScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The backgorund color of StandardTab
    public var backgroundColor: AColor

    /// The thumb color of StandardTab
    public var thumbColor = ControlParameter<AColor>()

    /// The border color of StandardTab
    public var borderColor = ControlParameter<AColor>()

    /// The title color of StandardTab
    public var titleColor = ControlParameter<AColor>()

    /// The title font of StandardTab
    public var titleFont = ControlParameter<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor = theme.colors.backgroundBasic.withAlpha(0.0)
        
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleFont.set(parameter: theme.fonts.subhead3, for: .normal)
        
        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)

        
        titleFont.set(parameter: theme.fonts.subhead2, for: .selected)
        
        titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .selected)
        
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
    
}
