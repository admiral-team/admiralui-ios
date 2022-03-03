//
//  StatusHistoryStatusViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct StatusHistoryStatusViewScheme {
    
    var textFont: AFont
    var textColor = StatusHistoryStatusViewParameters<AColor>()
    var imageTintColor = StatusHistoryStatusViewParameters<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        textFont = theme.fonts.subhead2
        
        textColor.set(parameter: theme.colors.textSecondary, for: .hold)
        textColor.set(parameter: theme.colors.textSuccess, for: .done)
        textColor.set(parameter: theme.colors.textAttention, for: .review)
        textColor.set(parameter: theme.colors.textError, for: .error)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .hold)
        imageTintColor.set(parameter: theme.colors.elementSuccess, for: .done)
        imageTintColor.set(parameter: theme.colors.elementAttention, for: .review)
        imageTintColor.set(parameter: theme.colors.elementError, for: .error)
    }
}

struct StatusHistoryStatusViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for status: StatusHistory) {
        let key = paramKey(status: status)
        parameters[key] = parameter
    }
    
    func parameter(for status: StatusHistory) -> P? {
        let key = paramKey(status: status)
        let defaultKey = paramKey(status: .hold)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(status: StatusHistory) -> String {
        return "\(status.rawValue)"
    }
    
}
