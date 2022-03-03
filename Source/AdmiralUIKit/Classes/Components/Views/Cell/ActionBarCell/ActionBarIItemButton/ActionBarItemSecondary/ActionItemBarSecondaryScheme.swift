//
//  ActionBarViewTwoScheme.swift
//  AdmiralUIKit
//
//  Created on 07.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The scheme of ActionBarControl.
struct ActionBarViewSecondaryScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The settings of ActionBarButtonStyle.
    struct ActionBarControl {
        var imageViewAlpha = ControlParameter<CGFloat>()
        var backgroundColor = ActionBarControlSchemeTwoParameters<AColor>()
    }

    var actionBarControl = ActionBarControl()

    /// The textColor of ActionBarControl.
    var textColor: AColor

    /// The font of text.
    var textFont: AFont

    /// The tint color of image.
    var imageTintColor: AColor

    /// An alpha component for ImageView.
    var alpha: CGFloat

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
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

public struct ActionBarControlSchemeTwoParameters<P> {

    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, style: ActionBarItemImageStyle, control: UIControl.State) {
        let key = paramKey(style: style, control: control)
        parameters[key] = parameter
    }

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
