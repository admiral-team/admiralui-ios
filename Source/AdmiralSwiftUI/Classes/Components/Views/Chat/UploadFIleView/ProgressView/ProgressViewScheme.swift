//
//  ProgressViewScheme.swift
//  AdmiralUIResources
//
//  Created on 02.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
import CoreGraphics

@available(iOS 14.0, *)
public struct ProgressViewScheme: AppThemeScheme {

    // MARK: - Properties

    public var backgroundColor = ProgressViewSchemeParameters<AColor>()
    public var circleColor = ProgressViewSchemeParameters<AColor>()
    public var iconColor = ProgressViewSchemeParameters<AColor>()

    // MARK: - Init/deinit

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .accent)

        iconColor.set(parameter: theme.colors.elementAccent, style: .accent)
        iconColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        iconColor.set(parameter: theme.colors.elementStaticWhite, style: .staticWhite)

        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .staticWhite)
        circleColor.set(parameter: theme.colors.backgroundAccent, style: .accent)
    }

}

@available(iOS 14.0.0, *)
public struct ProgressViewSchemeParameters<P> {
    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, style: ProgressViewStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    func parameter(style: ProgressViewStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: ProgressViewStyle) -> String {
        return "\(style.rawValue)"
    }

}
