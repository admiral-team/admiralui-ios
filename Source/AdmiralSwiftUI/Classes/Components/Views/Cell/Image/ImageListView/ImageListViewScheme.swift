//
//  ImageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = ImageListViewParameters<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal, style: .primary)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: .primary)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .secondary)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled, style: .secondary)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
    }
}

public struct ImageListViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: ControlState, style: ImageListViewStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: ControlState, style: ImageListViewStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: .primary)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: ControlState, style: ImageListViewStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }
    
}
