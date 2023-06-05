//
//  ToastNotificationsSwiftUIViewScheme.swift
//  ExampleiOS
//
//  Created on 03.09.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import Combine

@available(iOS 14.0.0, *)
public struct ToastNotificationsSwiftUIViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var titleNavigationColor: AColor
    public var textColor: AColor
    public var textFont: AFont
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        titleNavigationColor = theme.colors.textPrimary
        textColor = theme.colors.textPrimary
        textFont = theme.fonts.body2
    }
    
}
