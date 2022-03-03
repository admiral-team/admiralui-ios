//
//  ProgressViewScheme.swift
//  AdmiralUIKit
//
//  Created on 27.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ProgressViewScheme: AppThemeScheme {

    // MARK: - Properties

    public var backgroundColor = ProgressViewSchemeParameters<AColor>()
    public var iconColor = ProgressViewSchemeParameters<AColor>()
    public var circularTrackViewScheme = CircularTrackViewScheme()
    
    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .accent)

        iconColor.set(parameter: theme.colors.elementAccent, style: .accent)
        iconColor.set(parameter: theme.colors.elementStaticWhite, style: .default)

        circularTrackViewScheme = CircularTrackViewScheme(theme: theme)
    }

}

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
