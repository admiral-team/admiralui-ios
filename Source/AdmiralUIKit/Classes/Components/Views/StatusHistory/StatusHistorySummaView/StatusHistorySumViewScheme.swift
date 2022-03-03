//
//  StatusHistorySumViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct StatusHistorySumViewScheme {
    
    var sumTextColor = StatusHistorySummaViewParameters<AColor>()
    var sumTextFont = StatusHistorySummaViewParameters<UIFont>()
    
    var crossOutTextColor = StatusHistorySummaViewParameters<AColor>()
    var crossOutTextFont = StatusHistorySummaViewParameters<UIFont>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        sumTextColor.set(
            parameter: theme.colors.textAccent,
            for: .increase,
            type: .standard)
        sumTextColor.set(
            parameter: theme.colors.textPrimary,
            for: .decrease,
            type: .standard)
        sumTextColor.set(
            parameter: theme.colors.textAccent,
            for: .increase,
            type: .small)
        sumTextColor.set(
            parameter: theme.colors.textPrimary,
            for: .decrease,
            type: .small)
        
        sumTextFont.set(
            parameter: theme.fonts.largeTitle1.uiFont,
            for: .increase,
            type: .standard)
        sumTextFont.set(
            parameter: theme.fonts.title1.uiFont,
            for: .increase,
            type: .small)
        sumTextFont.set(
            parameter: theme.fonts.largeTitle1.uiFont,
            for: .decrease,
            type: .standard)
        sumTextFont.set(
            parameter: theme.fonts.title1.uiFont,
            for: .decrease,
            type: .small)
        
        crossOutTextColor.set(
            parameter: theme.colors.textSecondary,
            for: .decrease,
            type: .standard)
        crossOutTextColor.set(
            parameter: theme.colors.textSecondary,
            for: .decrease,
            type: .small)
        crossOutTextColor.set(
            parameter: theme.colors.textSecondary,
            for: .increase,
            type: .standard)
        crossOutTextColor.set(
            parameter: theme.colors.textSecondary,
            for: .increase,
            type: .small)
        
        crossOutTextFont.set(
            parameter: theme.fonts.body1.uiFont,
            for: .decrease,
            type: .standard)
        crossOutTextFont.set(
            parameter: theme.fonts.body1.uiFont,
            for: .increase,
            type: .standard)
        crossOutTextFont.set(
            parameter: theme.fonts.body1.uiFont,
            for: .decrease,
            type: .small)
        crossOutTextFont.set(
            parameter: theme.fonts.body1.uiFont,
            for: .increase,
            type: .small)
    }
}

struct StatusHistorySummaViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: StatusHistorySumType, type: StatusHistoryViewType) {
        let key = paramKey(state: state, type: type)
        parameters[key] = parameter
    }
    
    func parameter(for state: StatusHistorySumType, type: StatusHistoryViewType) -> P? {
        let key = paramKey(state: state, type: type)
        let defaultKey = paramKey(state: .decrease, type: .standard)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: StatusHistorySumType, type: StatusHistoryViewType) -> String {
        return "\(state.rawValue).\(type.rawValue)"
    }
    
}
