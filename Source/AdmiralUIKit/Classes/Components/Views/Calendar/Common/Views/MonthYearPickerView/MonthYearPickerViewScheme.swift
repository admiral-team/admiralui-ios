//
//  MonthYearPickerViewScheme.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 MonthYearPickerViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - MonthYearPickerViewScheme() - Initialize default MonthYearPickerViewScheme with default themezation
Example to create MonthYearPickerViewScheme:
Code
 ```
let scheme = MonthYearPickerViewScheme()
 ```
 */
public struct MonthYearPickerViewScheme: AppThemeScheme {

    /// Text color.
    public var textColor: AColor

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textPrimary
    }
    
}
