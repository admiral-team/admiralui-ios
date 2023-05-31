//
//  MessageInformerScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import UIKit
import AdmiralTheme

/**
 MessageInformerScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - MessageInformerScheme() - Initialize default MessageInformerScheme with default themezation
Example to create MessageInformerScheme:
Code
 ```
let scheme = MessageInformerScheme()
 ```
 */
public struct MessageInformerScheme: AppThemeScheme {

    /// Title label text color.
    public var titleLabelTextColors = MessageInformerParameter<AColor>()

    /// Description label text color.
    public var descriptionLabelTextColors = MessageInformerParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColors = MessageInformerParameter<AColor>()

    /// Wrap view background color.
    public var wrapViewBackgroundColors = MessageInformerParameter<AColor>()

    /// Background color.
    public var backgroundColors = MessageInformerParameter<AColor>()

    /// Description image view tint color.
    public var descriptionImageViewTintColors = MessageInformerParameter<AColor>()

    /// Description image view alpha.
    public var descriptionImageViewAlpha = MessageInformerParameter<CGFloat>()

    /// Title label font.
    public var titleLabelFont: AFont

    /// Description label font.
    public var descriptionLabelFont: AFont

    /// Subtitle label font.
    public var subtitleLabelFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.headline
        descriptionLabelFont = theme.fonts.largeTitle2
        subtitleLabelFont = theme.fonts.subhead4
        
        // Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true)
        descriptionLabelTextColors.set(parameter: theme.colors.textAccent, isEnabled: true)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, isEnabled: true)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: true)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: true)
        descriptionImageViewTintColors.set(parameter: theme.colors.elementPrimary, isEnabled: true)
        descriptionImageViewAlpha.set(parameter: 1, isEnabled: true)

        // Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false)
        descriptionLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), isEnabled: false)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, isEnabled: false)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, isEnabled: false)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, isEnabled: false)
        descriptionImageViewTintColors.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), isEnabled: false)
        descriptionImageViewAlpha.set(parameter: 0.5, isEnabled: false)
    }
    
}

/// A container for setting value for difference state.
public struct MessageInformerParameter<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - isEnabled: Enabled state.
    public mutating func set(parameter: P?, isEnabled: Bool) {
        let key = paramKey(isEnabled: isEnabled)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    /// - isEnabled: Enabled state.
    /// - Returns: Any value.
    public func parameter(isEnabled: Bool) -> P? {
        let key = paramKey(isEnabled: isEnabled)
        let defaultKey = paramKey(isEnabled: true)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool) -> String {
        return "\(isEnabled ? 1 : 0)"
    }

}
