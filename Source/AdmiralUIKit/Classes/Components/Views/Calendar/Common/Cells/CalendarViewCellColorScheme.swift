//
//  CalendarViewCellColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 CalendarViewCellColorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarViewCellColorScheme() - Initialize default CalendarViewCellColorScheme with default themezation
Example to create CalendarViewCellColorScheme:
Code
 ```
let scheme = CalendarViewCellColorScheme()
 ```
 */
public struct CalendarViewCellColorScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColors = CalendarParameters<AColor>()

    /// Text color.
    public var textColors = CalendarParameters<AColor>()

    /// Selected background color.
    public var selectedBackgroundColors = CalendarParameters<AColor>()

    /// Border color.
    public var borderColors = CalendarParameters<AColor>()

    /// Title label font.
    public var titleLabelFont: AFont

    /// Point background color.
    public var pointBackgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        
        pointBackgroundColor = theme.colors.elementAccent
        
        selectedBackgroundColors.set(parameter: theme.colors.backgroundBasic, state: .normal)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundAccent, state: .tailSelected)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundSelected, state: .selected)
        selectedBackgroundColors.set(parameter: theme.colors.backgroundBasic, state: .currentDate)
        
        textColors.set(parameter: theme.colors.textPrimary, state: .normal)
        textColors.set(parameter: theme.colors.textPrimary, state: .currentDate)
        textColors.set(parameter: theme.colors.textPrimary, state: .selected)
        textColors.set(parameter: theme.colors.textStaticWhite, state: .tailSelected)
        textColors.set(parameter: theme.colors.textPrimary.withAlpha(alpha), state: .disabled)
        
        borderColors.set(parameter: theme.colors.backgroundBasic, state: .normal)
        borderColors.set(parameter: theme.colors.textPrimary, state: .currentDate)
        borderColors.set(parameter: theme.colors.backgroundBasic, state: .selected)
        borderColors.set(parameter: theme.colors.backgroundBasic, state: .tailSelected)
        
        backgroundColors.set(parameter: theme.colors.backgroundBasic, state: .normal)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, state: .currentDate)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, state: .selected)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, state: .tailSelected)
    }
    
}

/// A container for setting value for difference state.
public struct CalendarParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color.
    ///   - state: Calendar cell state.
    public mutating func set(parameter: P?, state: CalendarCellState) {
        let key = paramKey(state: state)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: Calendar cell state.
    /// - Returns: Any value.
    public func parameter(for state: CalendarCellState) -> P? {
        let key = paramKey(state: state)
        let defaultKey = paramKey(state: .normal)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: CalendarCellState) -> String {
        return "\(state.rawValue)"
    }

}
