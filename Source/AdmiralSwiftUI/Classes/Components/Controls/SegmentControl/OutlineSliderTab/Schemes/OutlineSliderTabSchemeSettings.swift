//
//  OutlineSliderTabSchemeStruct.swift
//  AdmiralSwiftUI
//
//  Created by on 02.09.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 OutlineSliderTabScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - OutlineSliderTabScheme() - Initialize default OutlineSliderTabScheme with default themezation
 - OutlineSliderTabScheme(
    backgroundColor: AColor - the background color of OutlineSliderTabView ,
    borderSettings: BorderSettings - the visual settings of border in OutlineSliderTabView ,
    thumbSettings: ThumbSettings - the visual settings of thumb in OutlineSliderTabView,
    titleSettings: TitleSettings - the visual settings of title in OutlineSliderTabView
   )
 # Example to create OutlineSliderTabScheme:
 # Code
 ```
let scheme = OutlineSliderTabScheme()
 ```
 */
@available(iOS 14.0, *)
/// Outline slider tab scheme.
public final class OutlineSliderTabSchemeStruct: AppThemeScheme {

    /// The visual settings for Border
    public struct BorderSettings {
        /// The color of normal state
        let normalColor: AColor

        /// The color of disabled state
        let disabledColor: AColor
    }

    /// The visual settings for Thumb
    public struct ThumbSettings {
        /// The color of selected state
        let selectedColor: AColor

        /// The color of disabled state
        let disabledColor: AColor
    }

    /// The visual settings for Title
    public struct TitleSettings {
        /// The color of normal state
        let normalColor: AColor

        /// The color of disabled state
        let disabledColor: AColor

        /// The color of selected state
        let selectedColor: AColor

        /// The font for normal state
        let normalFont: AFont

        /// The font of selected state
        let selectedFont: AFont
    }

    // MARK: - Public Properties

    /// Background color.
    public var backgroundColor: AColor

    /// Thumb color.
    public var thumbColor = ControlParameter<AColor>()

    /// Border color.
    public var borderColor = ControlParameter<AColor>()

    /// Title item color.
    public var titleColor = ControlParameter<AColor>()

    /// Title item font.
    public var titleFont = ControlParameter<AFont>()


    // MARK: - Initializer

    public convenience init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        self.init(
            backgroundColor: theme.colors.backgroundBasic,
            borderSettings: .init(
                normalColor: theme.colors.elementAdditional,
                disabledColor: theme.colors.elementAdditional.withAlpha(alpha)
            ),
            thumbSettings: .init(
                selectedColor: theme.colors.elementAccent,
                disabledColor: theme.colors.elementAccent.withAlpha(alpha)
            ),
            titleSettings: .init(
                normalColor: theme.colors.textPrimary,
                disabledColor: theme.colors.textSecondary,
                selectedColor: theme.colors.textSecondary,
                normalFont: theme.fonts.subhead3,
                selectedFont: theme.fonts.subhead2
            )
        )
    }

    public init(
        backgroundColor: AColor,
        borderSettings: BorderSettings,
        thumbSettings: ThumbSettings,
        titleSettings: TitleSettings
    ) {
        self.backgroundColor = backgroundColor
        titleColor.set(parameter: titleSettings.normalColor, for: .normal)
        titleColor.set(parameter: titleSettings.disabledColor, for: .disabled)
        titleColor.set(parameter: titleSettings.selectedColor, for: .selected)

        titleFont.set(parameter: titleSettings.normalFont, for: .normal)
        titleFont.set(parameter: titleSettings.selectedFont, for: .selected)

        borderColor.set(parameter: borderSettings.normalColor, for: .normal)
        borderColor.set(parameter: borderSettings.disabledColor, for: .disabled)

        thumbColor.set(parameter: thumbSettings.selectedColor, for: .selected)
        thumbColor.set(parameter: thumbSettings.disabledColor, for: .disabled)
    }

}
