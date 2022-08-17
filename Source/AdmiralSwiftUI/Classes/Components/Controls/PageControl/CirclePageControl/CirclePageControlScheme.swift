//
//  CirclePageControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 11.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CirclePageControlScheme: AppThemeScheme {

    // MARK: - Properties

    /// The backgroundColor CirclePageControl
    public var backgroundColor = CirclePageControlSchemeParameters<AColor>()

    /// The color of image in CirclePageControl
    public var imageTintColor = CirclePageControlSchemeParameters<AColor>()

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: false, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: false, style: .additional)

        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: true, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: true, style: .additional)


        imageTintColor.set(parameter: theme.colors.textStaticWhite, for: false, style: .default)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: false, style: .additional)

        imageTintColor.set(parameter: theme.colors.backgroundAdditionalOne, for: true, style: .default)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(0.5), for: true, style: .additional)
    }

}

@available(iOS 14.0.0, *)
public struct CirclePageControlSchemeParameters<P> {
    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, for isPressing: Bool, style: CirclePageSliderStyle) {
        let key = paramKey(isPressing: isPressing, style: style)
        parameters[key] = parameter
    }

    public func parameter(for isPressing: Bool, style: CirclePageSliderStyle) -> P? {
        let key = paramKey(isPressing: isPressing, style: style)
        let defaultKey = paramKey(isPressing: isPressing, style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(isPressing: Bool, style: CirclePageSliderStyle) -> String {
        return "\(isPressing).\(style.rawValue)"
    }

}


@available(iOS 14.0.0, *)
public protocol CirclePageControlSchemeProvider {
    var scheme: CirclePageControlScheme { get }
}

@available(iOS 14.0.0, *)
extension AppThemeSchemeProvider: CirclePageControlSchemeProvider where S == CirclePageControlScheme {}
