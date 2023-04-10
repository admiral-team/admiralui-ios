//
//  StatusHistoryStatusViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistoryStatusViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistoryStatusViewScheme() - Initialize default StatusHistoryStatusViewScheme with default themezation
Example to create StatusHistoryStatusViewScheme:
Code
 ```
let scheme = StatusHistoryStatusViewScheme()
 ```
 */
public struct StatusHistoryStatusViewScheme: AppThemeScheme {

    /// Text font.
    public var textFont: AFont

    /// Text color.
    public var textColor = StatusHistoryStatusViewParameters<AColor>()

    /// Image tint color.
    public var imageTintColor = StatusHistoryStatusViewParameters<AColor>()
    
    public init(theme: AppTheme = .default) {
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

/// A container for setting value for difference state.
public struct StatusHistoryStatusViewParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - status: Status history.
    public mutating func set(parameter: P?, for status: StatusHistory) {
        let key = paramKey(status: status)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - status: Status history.
    /// - Returns: Any value.
    public func parameter(for status: StatusHistory) -> P? {
        let key = paramKey(status: status)
        let defaultKey = paramKey(status: .hold)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(status: StatusHistory) -> String {
        return "\(status.rawValue)"
    }
    
}
