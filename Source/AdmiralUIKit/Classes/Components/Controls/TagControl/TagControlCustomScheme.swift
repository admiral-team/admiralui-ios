//
//  TagControlCustomScheme.swift
//  AdmiralUI
//
//  Created on 03.02.2021.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TagControlCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TagControlCustomScheme() - Initialize default TagControlCustomScheme with default themezation
Example to create TagControlCustomScheme:
Code
 ```
let scheme = TagControlCustomScheme()
 ```
 */
public struct TagControlCustomScheme: AppThemeScheme {

    /// Font.
    public var font: AFont

    /// Text color.
    public var textColor = TagParameters<AColor>()

    /// Background color.
    public var backgroundColor = TagParameters<AColor>()

    /// View tint color.
    public var viewTintColor = TagParameters<AColor>()

    /// Link title font.
    public var linkTitleFont: AFont

    /// Link title font adidtional.
    public var linkTitleFontAdidtional: AFont

    /// Leading trailing views alpha.
    public var leadingTrailingViewsAlpha = ControlParameter<CGFloat>()

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        font = theme.fonts.body1
        linkTitleFont = theme.fonts.body2
        linkTitleFontAdidtional = theme.fonts.subhead3
        leadingTrailingViewsAlpha.set(parameter: 1.0, for: .normal)
        leadingTrailingViewsAlpha.set(parameter: alpha, for: .disabled)
        
        // None
        textColor.set(parameter: theme.colors.textAccent, for: .normal, style: .none)
        viewTintColor.set(parameter: theme.colors.elementAccent, for: .normal, style: .none)
        backgroundColor.set(parameter: AColor.clear, for: .normal, style: .none)
        
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted, style: .none)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled, style: .none)
        viewTintColor.set(parameter: theme.colors.elementAccent, for: .disabled, style: .none)
        viewTintColor.set(parameter: theme.colors.elementAccentPressed, for: .highlighted, style: .none)
        backgroundColor.set(parameter: AColor.clear, for: .selected, style: .none)
        
        // Default
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .default)
        viewTintColor.set(parameter: theme.colors.textAccent, for: .normal, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .normal, style: .default)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted, style: .default)
        
        viewTintColor.set(parameter: theme.colors.elementAccent, for: .highlighted, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundSelectedPressed, for: .selected, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundSelectedPressed, for: .highlighted, style: .default)
        
        viewTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: .default)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .default)
        
        // Additional
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .additional)
        viewTintColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal, style: .additional)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted, style: .additional)
        viewTintColor.set(parameter: theme.colors.textSecondary, for: .highlighted, style: .additional)
        backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .selected, style: .additional)
        backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .highlighted, style: .additional)
        
        viewTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled, style: .additional)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .additional)
        
        // Success
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .success)
        viewTintColor.set(parameter: theme.colors.textSuccess, for: .normal, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, for: .normal, style: .success)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted, style: .success)
        viewTintColor.set(parameter: theme.colors.elementSuccess, for: .highlighted, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSuccessPressed, for: .selected, style: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSuccessPressed, for: .highlighted, style: .success)
        
        viewTintColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), for: .disabled, style: .success)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .success)
        
        // Error
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .error)
        viewTintColor.set(parameter: theme.colors.textError, for: .normal, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundError, for: .normal, style: .error)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted, style: .error)
        viewTintColor.set(parameter: theme.colors.textError, for: .highlighted, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundErrorPressed, for: .selected, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundErrorPressed, for: .highlighted, style: .error)
        
        viewTintColor.set(parameter: theme.colors.elementError.withAlpha(alpha), for: .disabled, style: .error)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .error)
        
        // Attention
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .attention)
        viewTintColor.set(parameter: theme.colors.textAttention, for: .normal, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAttention, for: .normal, style: .attention)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted, style: .attention)
        viewTintColor.set(parameter: theme.colors.elementAttention, for: .highlighted, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAttentionPressed, for: .selected, style: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundAttentionPressed, for: .highlighted, style: .attention)
        
        viewTintColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), for: .disabled, style: .attention)
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled, style: .attention)
    }
}

/// A container for setting value for difference state.
public struct TagParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style tag view.
    public mutating func set(parameter: P?, for state: UIControl.State, style: TagStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style tag view.
    /// - Returns: Any value.
    public func parameter(for state: UIControl.State, style: TagStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, style: TagStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }
    
}

