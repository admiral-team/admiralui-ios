//
//  PrimaryLinkControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 10.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PrimaryLinkControlScheme - the visual scheme of PrimaryLinkControlStyle.
 You can create a by specifying the following parameters in init:
 - PrimaryLinkControlScheme() - Initialize default PrimaryLinkControlScheme with default themezation
 - PrimaryLinkControlScheme(
     fontMediumDisabled: AFont - the font with medium style and disabled state,
     fontMeduimEnabled: AFont -  the font with medium style and disabled state,,
     fontDefaultDisabled: AFont -  the font with medium style and disabled state,,
     fontDefaultEnabled: AFont  the font with medium style and disabled state,,
     textColorNormal: AColor - the normal text color
     textColorHighlighted: AColor - the color of text with highlighted state,
     textColorDisabled: AColor -  the color of text with disabled state,
 )

 Example to create PrimaryLinkControlScheme:
 Code
 ```
 let scheme = PrimaryLinkControlScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PrimaryLinkControlScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The font color of PrimaryLinkControl
    public var font = PrimaryLinkControlSchemeParameters<AFont>()

    /// The text color of PrimaryLinkControl
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(
        fontMediumDisabled: AFont,
        fontMeduimEnabled: AFont,
        fontDefaultDisabled: AFont,
        fontDefaultEnabled: AFont,
        textColorNormal: AColor,
        textColorHighlighted: AColor,
        textColorDisabled: AColor
    ) {
        font.set(parameter: fontMediumDisabled, style: .medium, isEnabled: false)
        font.set(parameter: fontMeduimEnabled, style: .medium, isEnabled: true)

        font.set(parameter: fontDefaultDisabled, style: .default, isEnabled: false)
        font.set(parameter: fontDefaultEnabled, style: .default, isEnabled: true)

        textColor.set(parameter: textColorNormal, for: .normal)
        textColor.set(parameter: textColorHighlighted, for: .highlighted)
        textColor.set(parameter: textColorDisabled, for: .disabled)
    }

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        self.init(
            fontMediumDisabled: theme.fonts.subhead3,
            fontMeduimEnabled: theme.fonts.subhead3,
            fontDefaultDisabled: theme.fonts.body2,
            fontDefaultEnabled: theme.fonts.body2,
            textColorNormal: theme.colors.backgroundAccent,
            textColorHighlighted: theme.colors.backgroundAccentPressed,
            textColorDisabled: theme.colors.backgroundAccent.withAlpha(alpha)
        )
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
