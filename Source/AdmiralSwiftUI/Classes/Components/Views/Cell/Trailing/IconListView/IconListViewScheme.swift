//
//  IconListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 IconListViewScheme - the visual scheme of IconListView.
 You can create a by specifying the following parameters in init:
 - IconListViewScheme() - Initialize default IconListViewScheme with default themezation
 # Example to create IconListViewScheme:
 # Code
 ```
 let scheme = IconListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct IconListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageTintColor = IconListViewParameters<AColor>()

    /// The  parameter that sets image view alpha with state
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
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
