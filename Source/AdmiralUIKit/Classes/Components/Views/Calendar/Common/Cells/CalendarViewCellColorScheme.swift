//
//  CalendarViewCellColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct CalendarViewCellColorScheme {
    
    var backgroundColors = CalendarParameters<AColor>()
    var textColors = CalendarParameters<AColor>()
    var selectedBackgroundColors = CalendarParameters<AColor>()
    var borderColors = CalendarParameters<AColor>()
    var titleLabelFont: AFont
    var pointBackgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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

struct CalendarParameters<P> {
    
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, state: CalendarCellState) {
        let key = paramKey(state: state)
        parameters[key] = parameter
    }
    
    func parameter(for state: CalendarCellState) -> P? {
        let key = paramKey(state: state)
        let defaultKey = paramKey(state: .normal)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: CalendarCellState) -> String {
        return "\(state.rawValue)"
    }

}
