//
//  PinCodeTextViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import SwiftUI
import AdmiralTheme

@available(iOS 14.0.0, *)
public struct PinCodeTextViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var textColor: AColor
    public var textFont: AFont
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subtitle3
    }
    
}
