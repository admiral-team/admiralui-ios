//
//  StatusHistorySumViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistorySumViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistorySumViewScheme() - Initialize default StatusHistorySumViewScheme with default themezation
Example to create StatusHistorySumViewScheme:
Code
 ```
let scheme = StatusHistorySumViewScheme()
 ```
 */
public struct StatusHistorySumViewScheme: AppThemeScheme {

    /// Sum text color.
    public var sumTextColor = StatusHistorySummaViewParameters<AColor>()

    /// Sum text font.
    public var sumTextFont = StatusHistorySummaViewParameters<UIFont>()

    /// Cross out text color.
    public var crossOutTextColor = StatusHistorySummaViewParameters<AColor>()

    /// Cross out text font.
    public var crossOutTextFont = StatusHistorySummaViewParameters<UIFont>()
    
    public init(theme: AppTheme = .default) {
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


/// A container for setting value for difference state.
public struct StatusHistorySummaViewParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: Status history sum type.
    ///   - type: Status history view type.
    public mutating func set(parameter: P?, for state: StatusHistorySumType, type: StatusHistoryViewType) {
        let key = paramKey(state: state, type: type)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - state: Status history sum type.
    ///   - type: Status history view type.
    /// - Returns: Any value.
    public func parameter(for state: StatusHistorySumType, type: StatusHistoryViewType) -> P? {
        let key = paramKey(state: state, type: type)
        let defaultKey = paramKey(state: .decrease, type: .standard)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: StatusHistorySumType, type: StatusHistoryViewType) -> String {
        return "\(state.rawValue).\(type.rawValue)"
    }
    
}
