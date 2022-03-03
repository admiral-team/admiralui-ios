//
//  MessageInformerScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct MessageInformerScheme {
    
    var titleLabelTextColors = MessageInformerParameter<AColor>()
    var descriptionLabelTextColors = MessageInformerParameter<AColor>()
    var subtitleLabelTextColors = MessageInformerParameter<AColor>()
    var wrapViewBackgroundColors = MessageInformerParameter<AColor>()
    var backgroundColors = MessageInformerParameter<AColor>()
    var descriptionImageViewTintColors = MessageInformerParameter<AColor>()
    var descriptionImageViewAlpha = MessageInformerParameter<CGFloat>()
    
    var titleLabelFont: AFont
    var descriptionLabelFont: AFont
    var subtitleLabelFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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

struct MessageInformerParameter<P> {
    
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, isEnabled: Bool) {
        let key = paramKey(isEnabled: isEnabled)
        parameters[key] = parameter
    }
    
    func parameter(isEnabled: Bool) -> P? {
        let key = paramKey(isEnabled: isEnabled)
        let defaultKey = paramKey(isEnabled: true)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(isEnabled: Bool) -> String {
        return "\(isEnabled ? 1 : 0)"
    }

}
