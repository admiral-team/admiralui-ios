//
//  PinCodeNumberViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 30.08.2021.
//

import SwiftUI
import AdmiralTheme

@available(iOS 14.0.0, *)
public struct PinCodeNumberViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageColor: AColor
    public var textColor: AColor
    public var textFont: SwiftUI.Font
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        
        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        // TODO: - Fix font
        textFont = SwiftUI.Font.system(size: 36.0)
    }
    
}
