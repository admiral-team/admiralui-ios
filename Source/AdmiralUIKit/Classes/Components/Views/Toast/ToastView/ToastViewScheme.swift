//
//  ToastViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.12.2021.
//

import UIKit
import AdmiralTheme

/**
 ToastViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ToastViewScheme() - Initialize default ToastViewScheme with default themezation
Example to create ToastViewScheme:
Code
 ```
let scheme = ToastViewScheme()
 ```
 */
public struct ToastViewScheme: AppThemeScheme {

    /// Title text color.
    public var titleTextColor = ToastViewParameters<AColor>()

    /// Close tint color.
    public var closeTintColor = ToastViewParameters<AColor>()

    /// Close title color.
    public var closeTitleColor = ToastViewParameters<AColor>()

    /// Background color.
    public var backgroundColor = ToastViewParameters<AColor>()

    /// Image tint color.
    public var imageTintColor =  ToastImageParameters<AColor>()

    /// Title text font.
    public var titleTextFont: AFont

    /// Close title font.
    public var closeTitleFont: AFont

    /// Count down time view scheme.
    public var countDownTimerViewScheme = CountDownTimerViewScheme()

    /// Primary link scheme.
    public var primaryLinkScheme = TagControlCustomScheme()

    public init(theme: AppTheme = .default) {
        
        let alpha = theme.colors.disabledAlpha
        
        titleTextFont = theme.fonts.body2
        closeTitleFont = theme.fonts.body2
        
        // Default Normal
        titleTextColor.set(parameter: theme.colors.textPrimary, isEnabled: true, type: .default)
        closeTintColor.set(parameter: theme.colors.elementPrimary, isEnabled: true, type: .default)
        closeTitleColor.set(parameter: theme.colors.elementAccent, isEnabled: true, type: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true, type: .default)
        imageTintColor.set(parameter: theme.colors.elementSuccess, isEnabled: true, type: .info)
        
        // Success Normal
        titleTextColor.set(parameter: theme.colors.textPrimary, isEnabled: true, type: .success)
        closeTintColor.set(parameter: theme.colors.elementPrimary, isEnabled: true, type: .success)
        closeTitleColor.set(parameter: theme.colors.elementAccent, isEnabled: true, type: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, isEnabled: true, type: .success)
        imageTintColor.set(parameter: theme.colors.elementSuccess, isEnabled: true, type: .success)
        
        // Attention Normal
        titleTextColor.set(parameter: theme.colors.textPrimary, isEnabled: true, type: .attention)
        closeTintColor.set(parameter: theme.colors.elementPrimary, isEnabled: true, type: .attention)
        closeTitleColor.set(parameter: theme.colors.elementAccent, isEnabled: true, type: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAttention, isEnabled: true, type: .attention)
        imageTintColor.set(parameter: theme.colors.elementAttention, isEnabled: true, type: .attention)
        
        // Addition Normal
        titleTextColor.set(parameter: theme.colors.textPrimary, isEnabled: true, type: .additional)
        closeTintColor.set(parameter: theme.colors.elementPrimary, isEnabled: true, type: .additional)
        closeTitleColor.set(parameter: theme.colors.elementAccent, isEnabled: true, type: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, isEnabled: true, type: .additional)
        
        // Error Normal
        titleTextColor.set(parameter: theme.colors.textPrimary, isEnabled: true, type: .error)
        closeTintColor.set(parameter: theme.colors.elementPrimary, isEnabled: true, type: .error)
        closeTitleColor.set(parameter: theme.colors.elementAccent, isEnabled: true, type: .error)
        backgroundColor.set(parameter: theme.colors.backgroundError, isEnabled: true, type: .error)
        imageTintColor.set(parameter: theme.colors.elementError, isEnabled: true, type: .error)
        
        // Default Disabled
        titleTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, type: .default)
        closeTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false, type: .default)
        closeTitleColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), isEnabled: false, type: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), isEnabled: false, type: .default)
        imageTintColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), isEnabled: false, type: .info)
        
        // Success Disabled
        titleTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, type: .success)
        closeTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false, type: .success)
        closeTitleColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), isEnabled: false, type: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess.withAlpha(alpha), isEnabled: false, type: .success)
        imageTintColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), isEnabled: false, type: .success)
        
        // Attention Disabled
        titleTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, type: .attention)
        closeTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false, type: .attention)
        closeTitleColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), isEnabled: false, type: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAttention.withAlpha(alpha), isEnabled: false, type: .attention)
        imageTintColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), isEnabled: false, type: .attention)
        
        // Addition Disabled
        titleTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, type: .additional)
        closeTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false, type: .additional)
        closeTitleColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), isEnabled: false, type: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundSelected.withAlpha(alpha), isEnabled: false, type: .additional)
        
        // Error Disabled
        titleTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), isEnabled: false, type: .error)
        closeTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false, type: .error)
        closeTitleColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), isEnabled: false, type: .error)
        backgroundColor.set(parameter: theme.colors.backgroundError.withAlpha(alpha), isEnabled: false, type: .error)
        imageTintColor.set(parameter: theme.colors.elementError.withAlpha(alpha), isEnabled: false, type: .error)

        countDownTimerViewScheme = CountDownTimerViewScheme(theme: theme)
        
        primaryLinkScheme = TagControlCustomScheme(theme: theme)
    }
    
}

/// A container for setting value for difference state.
public struct ToastViewParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - isEnabled: Enabled state.
    ///   - type: Toast view type.
    public mutating func set(parameter: P?, isEnabled: Bool, type: ToastViewType) {
        let key = paramKey(isEnabled: isEnabled, type: type)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - isEnabled: Enabled state.
    ///   - type: Toast view type.
    /// - Returns: Any value.
    public func parameter(isEnabled: Bool, type: ToastViewType) -> P? {
        let key = paramKey(isEnabled: isEnabled, type: type)
        let defaultKey = paramKey(isEnabled: true, type: .default)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool, type: ToastViewType) -> String {
        return "\(isEnabled ? 1 : 0).\(type.rawValue)"
    }
    
}

/// A container for setting value for difference state.
public struct ToastImageParameters<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - isEnabled: Enabled state.
    ///   - type: Toast view type.
    public mutating func set(parameter: P?, isEnabled: Bool, type: ToastImageType) {
        let key = paramKey(isEnabled: isEnabled, type: type)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - isEnabled: Enabled state.
    ///   - type: Toast view type.
    /// - Returns: Any value.
    public func parameter(isEnabled: Bool, type: ToastImageType) -> P? {
        let key = paramKey(isEnabled: isEnabled, type: type)
        let defaultKey = paramKey(isEnabled: true, type: .info)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool, type: ToastImageType) -> String {
        return "\(isEnabled ? 1 : 0).\(type.rawValue)"
    }
    
}

