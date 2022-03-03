//
//  TitleHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct TitleHeaderScheme {
    
    var backgroundColor: AColor
    var defaultTitleFont: AFont
    var titleFont = TitleHeaderViewParameters<AFont>()
    var textColor = TitleHeaderViewParameters<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: nil)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        defaultTitleFont = theme.fonts.body1
    }
}

public struct TitleHeaderViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: UIControl.State, style: HeaderStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: UIControl.State, style: HeaderStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, style: HeaderStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
