//
//  IconListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct IconListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = IconListViewParameters<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: nil)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal, style: nil)
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .paragraph)
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal, style: .paragraphSecondary)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled, style: .paragraph)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled, style: .paragraphSecondary)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
}

public struct IconListViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: ControlState, style: IconListViewStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: ControlState, style: IconListViewStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: ControlState, style: IconListViewStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
