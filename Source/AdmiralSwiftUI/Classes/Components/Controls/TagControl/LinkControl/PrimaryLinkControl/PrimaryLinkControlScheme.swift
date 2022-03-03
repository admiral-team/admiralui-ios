//
//  PrimaryLinkControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 10.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PrimaryLinkControlScheme: AppThemeScheme {

    // MARK: - Public properties

    public var font = PrimaryLinkControlSchemeParameters<AFont>()
    public var textColor = ControlParameter<AColor>()

    // MARK: - Init/deinit

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        font.set(parameter: theme.fonts.subhead3, style: .medium, isEnabled: false)
        font.set(parameter: theme.fonts.subhead3, style: .medium, isEnabled: true)

        font.set(parameter: theme.fonts.body2, style: .default, isEnabled: false)
        font.set(parameter: theme.fonts.body2, style: .default, isEnabled: true)

        textColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        textColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
    }

}

@available(iOS 14.0.0, *)
public struct PrimaryLinkControlSchemeParameters<P> {

    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, style: LinkControlStyle, isEnabled: Bool) {
        let key = paramKey(style: style, isEnabled: isEnabled)
        parameters[key] = parameter
    }

    func parameter(style: LinkControlStyle, isEnabled: Bool) -> P? {
        let key = paramKey(style: style, isEnabled: isEnabled)
        let defaultKey = paramKey(style: style, isEnabled: isEnabled)
        guard let parameter = parameters[key] ?? parameters[defaultKey] else {
            return nil
        }
        return parameter
    }

    private func paramKey(style: LinkControlStyle, isEnabled: Bool) -> String {
        return "\(isEnabled).\(style.rawValue)"
    }

}
