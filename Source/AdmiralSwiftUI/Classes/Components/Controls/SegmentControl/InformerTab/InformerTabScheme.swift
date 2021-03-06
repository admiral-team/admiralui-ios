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

@available(iOS 14.0, *)
public final class InformerTabScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var thumbColor = ControlParameter<AColor>()
    public var borderColor = ControlParameter<AColor>()
    public var titleColor = ControlParameter<AColor>()
    public var titleFont = ControlParameter<AFont>()
    public var subtitleColor = ControlParameter<AColor>()
    public var subtitleFont = ControlParameter<AFont>()
    
    public init(theme: AppTheme) {
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
