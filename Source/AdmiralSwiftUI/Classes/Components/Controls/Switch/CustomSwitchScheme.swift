//
//  CustomSwitchStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CustomSwitchScheme: ToggleStyle, AppThemeScheme  {
    
    public var font: AFont
    public var onTintColorColor: AColor
    public var textColor: AColor
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        font = theme.fonts.body1
        onTintColorColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        Toggle(configuration)
            .foregroundColor(textColor.swiftUIColor)
            .font(font.swiftUIFont)
            .toggleStyle(SwitchToggleStyle(tint: onTintColorColor.swiftUIColor))
    }
    
}
