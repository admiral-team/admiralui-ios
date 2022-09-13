//
//  CalendarHorizontalHeaderViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarHorizontalHeaderViewScheme: AppThemeScheme {
    
    public var buttonColor = ControlParameter<AColor>()
    public var backgroundColor: AColor

    /// Month year button scheme.
    public var monthYearButtonScheme: MonthYearButtonScheme
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonColor.set(parameter: theme.colors.textAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        buttonColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)

        monthYearButtonScheme = MonthYearButtonScheme(theme: theme)
    }
    
}
