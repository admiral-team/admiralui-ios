//
//  ActionItemBarDefaultControlScheme.swift
//  AdmiralUIKit
//
//  Created on 14.02.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The scheme of
struct ActionItemBarDefaultControlScheme {

    // MARK: - Public properties

    /// The backgroundColor of ActionItemBarDefaultControl.
    var backgroundColor = ControlParameter<AColor>()

    /// The image alpha of ActionItemBarDefaultControl.
    var imageViewAlpha = ControlParameter<CGFloat>()

    /// The image tint color of ActionItemBarDefaultControl.
    var imageTintColor = ActionBarControlSchemeParameters<AColor>()

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundBasic.withAlpha(alpha), for: .selected)
        backgroundColor.set(parameter: theme.colors.backgroundBasic.withAlpha(alpha), for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic.withAlpha(alpha), for: .disabled)

        imageTintColor.set(parameter: theme.colors.elementAccent, style: .accent, control: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccentPressed, style: .accent, control: .selected)
        imageTintColor.set(parameter: theme.colors.elementAccentPressed, style: .accent, control: .highlighted)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), style: .accent, control: .disabled)

        imageTintColor.set(parameter: theme.colors.elementError, style: .error, control: .normal)
        imageTintColor.set(parameter: theme.colors.elementErrorPressed, style: .error, control: .selected)
        imageTintColor.set(parameter: theme.colors.elementErrorPressed, style: .error, control: .highlighted)
        imageTintColor.set(parameter: theme.colors.elementError.withAlpha(alpha), style: .error, control: .disabled)

        imageTintColor.set(parameter: theme.colors.elementAttention, style: .attention, control: .normal)
        imageTintColor.set(parameter: theme.colors.elementAttentionPressed, style: .attention, control: .selected)
        imageTintColor.set(parameter: theme.colors.elementAttentionPressed, style: .attention, control: .highlighted)
        imageTintColor.set(parameter: theme.colors.elementAttention.withAlpha(alpha), style: .attention, control: .disabled)

        imageTintColor.set(parameter: theme.colors.elementPrimary, style: .primary, control: .normal)
        imageTintColor.set(parameter: theme.colors.elementPrimaryPressed, style: .primary, control: .selected)
        imageTintColor.set(parameter: theme.colors.elementPrimaryPressed, style: .primary, control: .highlighted)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), style: .primary, control: .disabled)

        imageTintColor.set(parameter: theme.colors.elementSuccess, style: .success, control: .normal)
        imageTintColor.set(parameter: theme.colors.elementSuccessPressed, style: .success, control: .selected)
        imageTintColor.set(parameter: theme.colors.elementSuccessPressed, style: .success, control: .highlighted)
        imageTintColor.set(parameter: theme.colors.elementSuccess.withAlpha(alpha), style: .success, control: .disabled)

        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
        imageViewAlpha.set(parameter: 0.5, for: [.selected, .disabled])
    }
}

struct ActionBarControlSchemeParameters<P> {

    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, style: ActionBarItemImageStyle, control: UIControl.State) {
        let key = paramKey(style: style, control: control)
        parameters[key] = parameter
    }

    func parameter(for style: ActionBarItemImageStyle, control: UIControl.State) -> P? {
        let key = paramKey(style: style, control: control)
        let defaultKey = paramKey(style: style, control: control)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    func paramKey(style: ActionBarItemImageStyle, control: UIControl.State) -> String {
        return "\(style.rawValue).\(control.rawValue)"
    }

}
