//
//  TextOperationViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.12.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
  TextOperationViewScheme - the visual scheme of TextOperationView.
   You can create a by specifying the following parameters in init:
   - TextOperationViewScheme() - Initialize default TextOperationViewScheme with default themezation
   - TextOperationViewScheme(
         backgroundColorDefault: AColor,
         backgroundColorError: AColor,
         backgroundColorSuccess: AColor,
         titleColorDefault: AColor,
         titleColorError: AColor,
         titleColorSuccess: AColor,
         desciptionColor: AColor,
         timeColor: AColor,
         titleFont: AFont,
         desciptionFont: AFont,
         timeFont: AFont
     )
   # Example to create TextOperationViewScheme:
   # Code
   ```
  let scheme = TextOperationViewScheme()
   ```
*/
@available(iOS 14.0, *)
public struct TextOperationViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The main view background color.
    public var backgroundColor = TextOperationViewSchemeParameters<AColor>()

    /// The title  label color.
    public var titleColor = TextOperationViewSchemeParameters<AColor>()

    /// The desciption label color.
    public var desciptionColor: AColor

    /// The time label color.
    public var timeColor: AColor

    /// The title label font.
    public var titleFont: AFont

    /// The desciption label font.
    public var desciptionFont: AFont

    /// The time label font.
    public var timeFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundError, style: .error)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, style: .success)

        titleColor.set(parameter: theme.colors.textPrimary, style: .default)
        titleColor.set(parameter: theme.colors.textError, style: .error)
        titleColor.set(parameter: theme.colors.textSuccess, style: .success)

        desciptionColor = theme.colors.textPrimary
        timeColor = theme.colors.textSecondary

        titleFont = theme.fonts.subhead1
        desciptionFont = theme.fonts.subhead3
        timeFont = theme.fonts.caption1
    }

    public init(
        backgroundColorDefault: AColor,
        backgroundColorError: AColor,
        backgroundColorSuccess: AColor,
        titleColorDefault: AColor,
        titleColorError: AColor,
        titleColorSuccess: AColor,
        desciptionColor: AColor,
        timeColor: AColor,
        titleFont: AFont,
        desciptionFont: AFont,
        timeFont: AFont
    ) {
        backgroundColor.set(parameter: backgroundColorDefault, style: .default)
        backgroundColor.set(parameter: backgroundColorError, style: .error)
        backgroundColor.set(parameter: backgroundColorSuccess, style: .success)

        titleColor.set(parameter: titleColorError, style: .default)
        titleColor.set(parameter: titleColorSuccess, style: .error)
        titleColor.set(parameter: desciptionColor, style: .success)

        self.desciptionColor = desciptionColor
        self.timeColor = timeColor

        self.titleFont = titleFont
        self.desciptionFont = desciptionFont
        self.timeFont = timeFont
    }

}

@available(iOS 14.0.0, *)
public struct TextOperationViewSchemeParameters<P> {
    var parameters: [String: P?] = [:]

    mutating func set(parameter: P?, style: TextOperationViewStyle) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }

    func parameter(style: TextOperationViewStyle) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(style: TextOperationViewStyle) -> String {
        return "\(style.rawValue)"
    }

}
