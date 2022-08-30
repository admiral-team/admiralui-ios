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
 - CalendarViewCellColorScheme(
     titleLabelFont: AFont,
     dayPointColor: AColor,
     selectedColorNormal: AColor,
     selectedColorTailSelected: AColor,
     selectedColor: AColor,
     selectedColorCurentDate: AColor,
     textColorNormal: AColor,
     textColorCurrentDate: AColor,
     textColorSelected: AColor,
     textColorTailSelected: AColor,
     textColorInactive: AColor,
     borderColorNormal: AColor,
     borderColorCurrentDate: AColor,
     borderColorSelected: AColor,
     borderColorTailSelected: AColor,
     backgroundColorNormal: AColor,
     backgroundColorCurrentDate: AColor,
     backgroundColorSelected: AColor,
     backgroundColorTailSelected: AColor
 )
 # Example to create CalendarViewCellColorScheme:
 # Code
 ```
 let scheme = CalendarViewCellColorScheme()
 ```
 */
public struct CalendarViewCellColorScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of  CalendarViewCell
    public var backgroundColors = CalendarParameters<AColor>()

    /// The text background color of  CalendarViewCell
    public var textColors = CalendarParameters<AColor>()

    /// The selected color of  CalendarViewCell
    public var selectedBackgroundColors = CalendarParameters<AColor>()

    /// The border color of  CalendarViewCell
    public var borderColors = CalendarParameters<AColor>()

    /// The title label color of  CalendarViewCell
    public var titleLabelFont: AFont

    /// The day point color of  CalendarViewCell
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

    public init(
        titleLabelFont: AFont,
        dayPointColor: AColor,
        selectedColorNormal: AColor,
        selectedColorTailSelected: AColor,
        selectedColor: AColor,
        selectedColorCurentDate: AColor,
        textColorNormal: AColor,
        textColorCurrentDate: AColor,
        textColorSelected: AColor,
        textColorTailSelected: AColor,
        textColorInactive: AColor,
        borderColorNormal: AColor,
        borderColorCurrentDate: AColor,
        borderColorSelected: AColor,
        borderColorTailSelected: AColor,
        backgroundColorNormal: AColor,
        backgroundColorCurrentDate: AColor,
        backgroundColorSelected: AColor,
        backgroundColorTailSelected: AColor
    ) {
        self.titleLabelFont = titleLabelFont
        self.dayPointColor = dayPointColor

        selectedBackgroundColors.set(parameter: selectedColorNormal, for: .normal)
        selectedBackgroundColors.set(parameter: selectedColorTailSelected, for: .tailSelected)
        selectedBackgroundColors.set(parameter: selectedColor, for: .selected)
        selectedBackgroundColors.set(parameter: selectedColorCurentDate, for: .currentDate)

        textColors.set(parameter: textColorNormal, for: .normal)
        textColors.set(parameter: textColorCurrentDate, for: .currentDate)
        textColors.set(parameter: textColorSelected, for: .selected)
        textColors.set(parameter: textColorTailSelected, for: .tailSelected)
        textColors.set(parameter: textColorInactive, for: .inactive)

        borderColors.set(parameter: borderColorNormal, for: .normal)
        borderColors.set(parameter: borderColorCurrentDate, for: .currentDate)
        borderColors.set(parameter: borderColorSelected, for: .selected)
        borderColors.set(parameter: borderColorTailSelected, for: .tailSelected)

        backgroundColors.set(parameter: backgroundColorNormal, for: .normal)
        backgroundColors.set(parameter: backgroundColorCurrentDate, for: .currentDate)
        backgroundColors.set(parameter: backgroundColorSelected, for: .selected)
        backgroundColors.set(parameter: backgroundColorTailSelected, for: .tailSelected)
    }

}

public typealias CalendarParameters<T> = ParameterBox<CalendarCellState, T>

extension CalendarCellState: DefaultRepresentable {
    public static var defaultValue: CalendarCellState { return .normal }
}
