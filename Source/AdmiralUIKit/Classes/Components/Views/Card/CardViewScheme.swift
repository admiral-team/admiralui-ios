//
//  CardViewScheme.swift
//  AdmiralUI
//
//  Created on 25.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CardViewScheme {

    var topLabelTextColor: AColor
    var nameLabelTextColor: AColor
    var amountLabelTextColor: AColor
    var statusLabelTextColors = CardViewSchemeParameter<AColor>()
    var statusImageViewColors = CardViewSchemeParameter<AColor>()
    var backgroundColor: AColor
    var statusBackGroundViewColors = CardViewSchemeParameter<AColor>()
    var subtitleLabelTextColor: AColor
    
    var topLabelFont: UIFont
    var nameLabelFont: UIFont
    var amountLabelFont: UIFont
    var statusLabelFont: UIFont
    var subtitleLabelFont: UIFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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

struct CardViewSchemeParameter<P> {
    
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, style: CardStatusStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }
    
    func parameter(style: CardStatusStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: .default)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(style: CardStatusStyle) -> String {
        return "\(style.rawValue)"
    }

}
