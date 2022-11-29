//
//  CardViewScheme.swift
//  AdmiralUI
//
//  Created on 25.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 CardViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CardViewScheme() - Initialize default CardViewScheme with default themezation
Example to create CardViewScheme:
Code
 ```
let scheme = CardViewScheme()
 ```
 */
public struct CardViewScheme: AppThemeScheme {

    /// Top label text color.
    public var topLabelTextColor: AColor

    /// Name label text color.
    public var nameLabelTextColor: AColor

    /// Amount label text color.
    public var amountLabelTextColor: AColor

    /// Status label text color.
    public var statusLabelTextColors = CardViewSchemeParameter<AColor>()

    /// Status image view color.
    public var statusImageViewColors = CardViewSchemeParameter<AColor>()

    /// Background color.
    public var backgroundColor: AColor

    /// Status background view colors.
    public var statusBackGroundViewColors = CardViewSchemeParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColor: AColor

    /// Top label font.
    public var topLabelFont: UIFont

    /// Name label font.
    public var nameLabelFont: UIFont

    /// Amount label font.
    public var amountLabelFont: UIFont

    /// Status label font.
    public var statusLabelFont: UIFont

    /// Subtitle label font.
    public var subtitleLabelFont: UIFont
    
    public init(theme: AppTheme = .default) {
        topLabelFont = theme.fonts.caption1.uiFont
        nameLabelFont = theme.fonts.headline.uiFont
        amountLabelFont = theme.fonts.title1.uiFont
        statusLabelFont = theme.fonts.subhead2.uiFont
        subtitleLabelFont = theme.fonts.subhead3.uiFont
        
        topLabelTextColor = theme.colors.textStaticWhite
        nameLabelTextColor = theme.colors.textStaticWhite
        amountLabelTextColor = theme.colors.textStaticWhite
        backgroundColor = theme.colors.textStaticWhite
        subtitleLabelTextColor = theme.colors.textStaticWhite
        
        // No Status
        statusBackGroundViewColors.set(parameter: theme.colors.textStaticWhite, style: .noStatus)
        statusLabelTextColors.set(parameter: theme.colors.textStaticWhite, style: .noStatus)
        statusImageViewColors.set(parameter: theme.colors.textStaticWhite, style: .noStatus)
        
        // Default
        statusBackGroundViewColors.set(parameter: theme.colors.textPrimary.withAlpha(0.7), style: .default)
        statusLabelTextColors.set(parameter: theme.colors.textStaticWhite, style: .default)
        statusImageViewColors.set(parameter: theme.colors.textStaticWhite, style: .default)
       
        // Attention
        statusBackGroundViewColors.set(parameter: theme.colors.textPrimary.withAlpha(0.7), style: .attention)
        statusLabelTextColors.set(parameter: theme.colors.textAttention, style: .attention)
        statusImageViewColors.set(parameter: theme.colors.elementAttention, style: .attention)
        
        // Error
        statusBackGroundViewColors.set(parameter: theme.colors.textPrimary.withAlpha(0.7), style: .error)
        statusLabelTextColors.set(parameter: theme.colors.textError, style: .error)
        statusImageViewColors.set(parameter: theme.colors.textError, style: .error)
    }
    
}

/// A container for setting value for difference state.
public struct CardViewSchemeParameter<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - style: Card status style.
    public mutating func set(parameter: P?, style: CardStatusStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - style: Card status style.
    /// - Returns: Any value.
    public func parameter(style: CardStatusStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: .default)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(style: CardStatusStyle) -> String {
        return "\(style.rawValue)"
    }

}
