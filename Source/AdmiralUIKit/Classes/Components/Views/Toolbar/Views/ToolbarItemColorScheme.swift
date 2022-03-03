//
//  ToolbarColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct ToolbarItemColorScheme {
    
    public var titleColor = ToolbarItemParameters<AColor>()
    public var imageColor = ToolbarItemParameters<AColor>()
 
    public var titleLabelFontVertical: UIFont
    public var titleLabelFontHorizontal: UIFont

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        titleLabelFontVertical = theme.fonts.caption2.uiFont
        titleLabelFontHorizontal = theme.fonts.subhead2.uiFont
        
        // Normal
        titleColor.set(parameter: theme.colors.textContrast, for: .normal, type: .default)
        titleColor.set(parameter: theme.colors.textErrorDefault, for: .normal, type: .error)
        titleColor.set(parameter: theme.colors.textSuccessDefault, for: .normal, type: .success)
        titleColor.set(parameter: theme.colors.textAttentionDefault, for: .normal, type: .attention)
        
        imageColor.set(parameter: theme.colors.elementContrast, for: .normal, type: .default)
        imageColor.set(parameter: theme.colors.elementErrorDefault, for: .normal, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccessDefault, for: .normal, type: .success)
        imageColor.set(parameter: theme.colors.elementAttentionDefault, for: .normal, type: .attention)

        // Selected
        titleColor.set(parameter: theme.colors.textAccent, for: .selected, type: .default)
        titleColor.set(parameter: theme.colors.textError, for: .selected, type: .error)
        titleColor.set(parameter: theme.colors.textSuccess, for: .selected, type: .success)
        titleColor.set(parameter: theme.colors.textAttention, for: .selected, type: .attention)
        
        imageColor.set(parameter: theme.colors.elementAccent, for: .selected, type: .default)
        imageColor.set(parameter: theme.colors.elementError, for: .selected, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccess, for: .selected, type: .success)
        imageColor.set(parameter: theme.colors.elementAttention, for: .selected, type: .attention)
        
        // Highlighted
        titleColor.set(parameter: theme.colors.textAccent, for: [.highlighted, .selected], type: .default)
        titleColor.set(parameter: theme.colors.textError, for: [.highlighted, .selected], type: .error)
        titleColor.set(parameter: theme.colors.textSuccess, for: [.highlighted, .selected], type: .success)
        titleColor.set(parameter: theme.colors.textAttention, for: [.highlighted, .selected], type: .attention)
        
        imageColor.set(parameter: theme.colors.elementAccent, for: [.highlighted, .selected], type: .default)
        imageColor.set(parameter: theme.colors.elementError, for: [.highlighted, .selected], type: .error)
        imageColor.set(parameter: theme.colors.elementSuccess, for: [.highlighted, .selected], type: .success)
        imageColor.set(parameter: theme.colors.elementAttention, for: [.highlighted, .selected], type: .attention)
        
        // Disabled
        titleColor.set(parameter: theme.colors.textContrast.withAlpha(alpha), for: .disabled, type: .default)
        titleColor.set(parameter: theme.colors.textErrorDefault.withAlpha(alpha), for: .disabled, type: .error)
        titleColor.set(parameter: theme.colors.textSuccessDefault.withAlpha(alpha), for: .disabled, type: .success)
        titleColor.set(parameter: theme.colors.textAttentionDefault.withAlpha(alpha), for: .disabled, type: .attention)
        
        imageColor.set(parameter: theme.colors.elementContrast.withAlpha(alpha), for: .disabled, type: .default)
        imageColor.set(parameter: theme.colors.elementErrorDefault.withAlpha(alpha), for: .disabled, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccessDefault.withAlpha(alpha), for: .disabled, type: .success)
        imageColor.set(parameter: theme.colors.elementAttentionDefault.withAlpha(alpha), for: .disabled, type: .attention)
    }
    
}

public struct ToolbarItemParameters<P> {
    var parameters: [String: P?] = [:]
    
    public mutating func set(parameter: P?, for state: UIControl.State, type: ToolbarItemType) {
        let key = paramKey(state: state, type: type)
        parameters[key] = parameter
    }
    
    public func parameter(for state: UIControl.State, type: ToolbarItemType) -> P? {
        let key = paramKey(state: state, type: type)
        let defaultKey = paramKey(state: .normal, type: type)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, type: ToolbarItemType) -> String {
        return "\(state.rawValue).\(type.rawValue)"
    }
    
}

