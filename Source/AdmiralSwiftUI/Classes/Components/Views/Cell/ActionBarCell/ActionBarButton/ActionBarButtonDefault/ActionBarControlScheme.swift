//
//  ActionBarControlStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ActionBarControlScheme - the visual scheme of ListCell.
 You can create a by specifying the following parameters in init:
 - ActionBarControlScheme() - Initialize default ActionBarControlScheme with default themezation
 # Example to create ActionBarControlScheme:
 # Code
 ```
 let scheme = ActionBarControlScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ActionBarControlScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The settings of ActionBarButtonStyle.
    public struct ActionBarControl {
        var backgroundColor = ControlParameter<AColor>()
        var imageViewAlpha = ControlParameter<Double>()
        var imageTintColor = ActionBarControlSchemeParameters<AColor, ActionBarItemImageStyle>()
    }

    /// The number of parametes that serve colors and fonts
    public var actionBarControl = ActionBarControl()

    /// The backgroundColor of ActionBarControl.
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        actionBarControl.backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .selected)

        actionBarControl.imageTintColor.set(parameter: theme.colors.elementAccent, style: .accent)
        actionBarControl.imageTintColor.set(parameter: theme.colors.elementError, style: .error)
        actionBarControl.imageTintColor.set(parameter: theme.colors.elementAttention, style: .attention)
        actionBarControl.imageTintColor.set(parameter: theme.colors.elementPrimary, style: .primary)
        actionBarControl.imageTintColor.set(parameter: theme.colors.elementSuccess, style: .success)

        actionBarControl.imageViewAlpha.set(parameter: 1.0, for: .normal)
        actionBarControl.imageViewAlpha.set(parameter: 0.5, for: .disabled)
        actionBarControl.imageViewAlpha.set(parameter: 0.5, for: .selected)
    }
}

@available(iOS 14.0.0, *)
public struct ActionBarControlSchemeParameters<P, S: RawRepresentable & Hashable> where S.RawValue == Int {

    var parameters: [String: P?] = [:]
    typealias style = S

    mutating func set(parameter: P?, style: style) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    func parameter(style: style) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: style) -> String {
        return "\(style.rawValue)"
    }

}
