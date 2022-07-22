//
//  ParagraphScheme.swift
//  AdmiralUIKit
//
//  Created on 18.07.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit


struct ParagraphScheme {
    var backgroundColor: AColor
    var textColor = ParagraphViewParametrs<AColor>()
    var leadingImageColor: AColor
    var titleFont = ParagraphViewParametrs<AFont>()
    var defaultTitleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .primary)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: .primary)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .secondary)
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled, style: .secondary)
        
        leadingImageColor = theme.colors.elementPrimary
        titleFont.set(parameter: theme.fonts.body2, for: .normal, style: .primary)
        titleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .secondary)
        defaultTitleFont = theme.fonts.body2
    }

}

public struct ParagraphViewParametrs<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: UIControl.State, style: ParagraphStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: UIControl.State, style: ParagraphStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, style: ParagraphStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
}
