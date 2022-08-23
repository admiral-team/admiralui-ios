//
//  CirclePageControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 11.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CirclePageControlScheme - the visual scheme of CirclePageControl.
 You can create a by specifying the following parameters in init:
 - CirclePageControlScheme() - Initialize default PageControlViewScheme with default themezation
 - CirclePageControlScheme(
     backroundColorNotPressedDefault: AColor - the background color of CirclePageControl when control is not pressed and default CirclePageSliderStyle,
     backroundColorNotPressedAdditional: AColor - the background color of CirclePageControl when control is not pressed and additional CirclePageSliderStyle,
     backroundColorPressedDefault: AColor - the background color of CirclePageControl when control is pressed and default CirclePageSliderStyle,
     backroundColorPressedAdditional: AColor - the background color of CirclePageControl when control is pressed and additional CirclePageSliderStyle,
     imageColorNotPressedDefault: AColor - the image tint color of CirclePageControl when control is not pressed and default CirclePageSliderStyle,
     imageColorNotPressedAdditional: AColor - the image tint color of CirclePageControl when control is not pressed and default CirclePageSliderStyle,
     imageColorPressedDefault: AColor - the image tint of CirclePageControl when control is pressed and default CirclePageSliderStyle,
     imageColorPressedAdditional: AColor - the image tint color of CirclePageControl when control is pressed and default CirclePageSliderStyle
   )

Example to create CirclePageControlScheme:
Code
 ```
let scheme = CirclePageControlScheme()
let customScheme = CirclePageControlScheme(
 backroundColorNotPressedDefault: AppTheme.default.colors.specialExtra22,
 backroundColorNotPressedAdditional: AppTheme.default.colors.specialExtra23,
 backroundColorPressedDefault: AppTheme.default.colors.specialExtra20,
 backroundColorPressedAdditional: AppTheme.default.colors.specialExtra19,
 imageColorNotPressedDefault: AppTheme.default.colors.specialExtra13,
 imageColorNotPressedAdditional: AppTheme.default.colors.specialExtra12,
 imageColorPressedDefault: AppTheme.default.colors.specialExtra10,
 imageColorPressedAdditional: AppTheme.default.colors.specialExtra11
)
 ```
 */
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

    public init(
        backroundColorNotPressedDefault: AColor,
        backroundColorNotPressedAdditional: AColor,
        backroundColorPressedDefault: AColor,
        backroundColorPressedAdditional: AColor,
        imageColorNotPressedDefault: AColor,
        imageColorNotPressedAdditional: AColor,
        imageColorPressedDefault: AColor,
        imageColorPressedAdditional: AColor
    ) {
        backgroundColor.set(parameter: backroundColorNotPressedDefault, for: false, style: .default)
        backgroundColor.set(parameter: backroundColorNotPressedAdditional, for: false, style: .additional)

        backgroundColor.set(parameter: backroundColorPressedDefault, for: true, style: .default)
        backgroundColor.set(parameter: backroundColorPressedAdditional, for: true, style: .additional)


        imageTintColor.set(parameter: imageColorNotPressedDefault, for: false, style: .default)
        imageTintColor.set(parameter: imageColorNotPressedAdditional, for: false, style: .additional)

        imageTintColor.set(parameter: imageColorPressedDefault, for: true, style: .default)
        imageTintColor.set(parameter: imageColorPressedAdditional.withAlpha(0.5), for: true, style: .additional)
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

    public init() {}

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
