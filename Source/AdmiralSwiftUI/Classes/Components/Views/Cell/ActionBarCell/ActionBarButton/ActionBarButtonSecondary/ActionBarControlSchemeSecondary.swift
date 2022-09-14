//
//  ActionBarControlSchemeTwoTwo.swift
//  AdmiralSwiftUI
//
//  Created on 08.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ActionBarControlSchemeTwo - the visual scheme of ListCell.
 You can create a by specifying the following parameters in init:
 - ActionBarControlSchemeTwo() - Initialize default ActionBarControlSchemeTwo with default themezation
 # Example to create ActionBarControlSchemeTwo:
 # Code
 ```
 let scheme = ActionBarControlSchemeTwo()
 ```
 */
@available(iOS 14.0.0, *)
public struct ActionBarControlSchemeSecondary: AppThemeScheme {

    // MARK: - Public properties

    /// The settings of ActionBarButtonStyle.
    public struct ActionBarControl {
        var imageViewAlpha = ControlParameter<Double>()
        var backgroundColor = ActionBarControlSchemeTwoTwoParameters<AColor>()
    }

    public var actionBarControl = ActionBarControl()

    /// The textColor of ActionBarControl.
    public var textColor: AColor

    /// The font of text.
    public var textFont: AFont

    /// The tint color of image.
    public var imageTintColor: AColor

    /// The alpha of custom color.
    public let alpha: Double

    // MARK: - Initializer

    public init(theme: AppTheme) {
        textColor = theme.colors.textStaticWhite
        textFont = theme.fonts.caption1
        imageTintColor = theme.colors.elementStaticWhite

        alpha = theme.colors.disabledAlpha

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent, style: .accent, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .disabled)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementError, style: .error, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementErrorPressed.withAlpha(alpha), style: .error, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementErrorPressed.withAlpha(alpha), style: .error, control: .disabled)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention, style: .attention, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .disabled)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary, style: .primary, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .disabled)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess, style: .success, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .disabled)

        actionBarControl.imageViewAlpha.set(parameter: 1.0, for: .normal)
        actionBarControl.imageViewAlpha.set(parameter: 0.5, for: .disabled)
        actionBarControl.imageViewAlpha.set(parameter: 0.5, for: .selected)
    }
}

@available(iOS 14.0, *)
public struct ActionBarControlSchemeTwoTwoParameters<P> {

    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, style: ActionBarItemImageStyle, control: ControlState) {
        let key = paramKey(style: style, control: control)
        parameters[key] = parameter
    }

    public func parameter(for style: ActionBarItemImageStyle, control: ControlState) -> P? {
        let key = paramKey(style: style, control: control)
        let defaultKey = paramKey(style: style, control: control)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ActionBarItemImageStyle, control: ControlState) -> String {
        return "\(style.rawValue).\(control.rawValue)"
    }

}
