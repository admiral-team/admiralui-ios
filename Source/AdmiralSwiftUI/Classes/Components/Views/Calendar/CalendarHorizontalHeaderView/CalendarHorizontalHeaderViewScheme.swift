//
//  CalendarHorizontalHeaderViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CalendarHorizontalHeaderViewScheme - the visual scheme of CalendarHorizontalHeaderView.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalHeaderViewScheme() - Initialize default CalendarHorizontalHeaderViewScheme with default themezation
 - CalendarHorizontalHeaderViewScheme(
     backgroundColor: AColor,
     buttonColorNormal: AColor,
     buttonColorHighlighted: AColor,
     buttonColorDisabled: AColor
 )
 # Example to create CalendarHorizontalHeaderViewScheme:
 # Code
 ```
 let scheme = CalendarHorizontalHeaderViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarHorizontalHeaderViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The button color of CalendarHorizontalHeaderView.
    public var buttonColor = ControlParameter<AColor>()

    /// The background color of CalendarHorizontalHeaderView.
    public var backgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonColor.set(parameter: theme.colors.textAccent, for: .normal)
        buttonColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        buttonColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }

    public init(
        backgroundColor: AColor,
        buttonColorNormal: AColor,
        buttonColorHighlighted: AColor,
        buttonColorDisabled: AColor
    ) {
        self.backgroundColor = backgroundColor
        buttonColor.set(parameter: buttonColorNormal, for: .normal)
        buttonColor.set(parameter: buttonColorHighlighted, for: .highlighted)
        buttonColor.set(parameter: buttonColorDisabled, for: .disabled)
    }
    
}
