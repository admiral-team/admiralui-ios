//
//  CalendarDaysViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CalendarViewCellColorScheme: AppThemeScheme {
    
    public var backgroundColors = CalendarParameters<AColor>()
    public var textColors = CalendarParameters<AColor>()
    public var selectedBackgroundColors = CalendarParameters<AColor>()
    public var borderColors = CalendarParameters<AColor>()
    public var titleLabelFont: AFont
    public var dayPointColor: AColor

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        titleLabelFont = theme.fonts.body1
        
        dayPointColor = theme.colors.elementAccent
        
        selectedBackgroundColors.set(parameter: theme.colors.backgroundBasic, for: .normal)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundAccent, for: .tailSelected)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundSelected, for: .selected)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundBasic, for: .currentDate)
        
        textColors.set(parameter: theme.colors.textPrimary, for: .normal)
        textColors.set(parameter: theme.colors.textPrimary, for: .currentDate)
        textColors.set(parameter: theme.colors.textPrimary, for: .selected)
        textColors.set(parameter: theme.colors.textStaticWhite, for: .tailSelected)
        textColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .inactive)
        
        borderColors.set(parameter: theme.colors.backgroundBasic, for: .normal)
        borderColors.set(parameter: theme.colors.textPrimary, for: .currentDate)
        borderColors.set(parameter: theme.colors.backgroundBasic, for: .selected)
        borderColors.set(parameter: theme.colors.backgroundBasic, for: .tailSelected)
        
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .currentDate)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .selected)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .tailSelected)
    }
    
}

public typealias CalendarParameters<T> = ParameterBox<CalendarCellState, T>

extension CalendarCellState: DefaultRepresentable {
    public static var defaultValue: CalendarCellState { return .normal }
}
