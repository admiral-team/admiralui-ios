//
//  ActionBarViewTwoScheme.swift
//  AdmiralUIKit
//
//  Created on 07.02.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ActionBarViewSecondaryScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ActionBarViewSecondaryScheme() - Initialize default ActionBarViewSecondaryScheme with default themezation
Example to create ActionBarViewSecondaryScheme:
Code
 ```
let scheme = ActionBarViewSecondaryScheme()
 ```
 */
public struct ActionBarViewSecondaryScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The settings of ActionBarButtonStyle.
    public struct ActionBarControl {
        public var imageViewAlpha = ControlParameter<CGFloat>()
        public var backgroundColor = ActionBarControlSchemeTwoParameters<AColor>()
    }

    public var actionBarControl = ActionBarControl()

    /// The textColor of ActionBarControl.
    public var textColor: AColor

    /// The font of text.
    public var textFont: AFont

    /// The tint color of image.
    public var imageTintColor: AColor

    /// An alpha component for ImageView.
    public var alpha: CGFloat

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textStaticWhite
        textFont = theme.fonts.caption1
        alpha = theme.colors.disabledAlpha
        imageTintColor = theme.colors.elementStaticWhite

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent, style: .accent, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .disabled)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .highlighted)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementError, style: .error, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementErrorPressed.withAlpha(alpha), style: .error, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementErrorPressed.withAlpha(alpha), style: .error, control: .disabled)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementErrorPressed.withAlpha(alpha), style: .error, control: .highlighted)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention, style: .attention, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .disabled)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .highlighted)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary, style: .primary, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .disabled)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .highlighted)

        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess, style: .success, control: .normal)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .selected)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .disabled)
        actionBarControl.backgroundColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .highlighted)

        actionBarControl.imageViewAlpha.set(parameter: alpha, for: .disabled)
        actionBarControl.imageViewAlpha.set(parameter: alpha, for: [.selected, .disabled])
    }
}

/// A container for setting value for difference state.
public struct ActionBarControlSchemeTwoParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - style: Action bar item image style.
    ///   - control: Control state.
    public mutating func set(parameter: P?, style: ActionBarItemImageStyle, control: UIControl.State) {
        let key = paramKey(style: style, control: control)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - style: Action bar item image style.
    ///   - control: Control state.
    /// - Returns: Any value.
    public func parameter(for style: ActionBarItemImageStyle, control: UIControl.State) -> P? {
        let key = paramKey(style: style, control: control)
        let defaultKey = paramKey(style: style, control: control)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ActionBarItemImageStyle, control: UIControl.State) -> String {
        return "\(style.rawValue).\(control.rawValue)"
    }

}
