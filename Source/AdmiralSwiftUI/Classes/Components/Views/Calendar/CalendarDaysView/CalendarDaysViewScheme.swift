//
//  CalendarDaysViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 CalendarViewCellColorScheme - the visual scheme of CalendarViewCellColorView.
 You can create a by specifying the following parameters in init:
 - CalendarViewCellColorScheme() - Initialize default CalendarViewCellColorScheme with default themezation
 # Example to create CalendarViewCellColorScheme:
 # Code
 ```
 let scheme = CalendarViewCellColorScheme()
 ```
 */
public struct CalendarViewCellColorScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color that configure with style
    public var backgroundColors = CalendarParameters<AColor>()

    /// The text color that configure with style
    public var textColors = CalendarParameters<AColor>()

    /// The selected background color that configure with style
    public var selectedBackgroundColors = CalendarParameters<AColor>()

    /// The border color that configure with style
    public var borderColors = CalendarParameters<AColor>()

    /// The title label color
    public var titleLabelFont: AFont

    /// The day point color
    public var dayPointColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
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
