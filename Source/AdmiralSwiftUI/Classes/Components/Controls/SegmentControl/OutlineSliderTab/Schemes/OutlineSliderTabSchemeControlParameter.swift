//
//  OutlineSliderTabSchemeControlParameter.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2022.
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
     thumbColor: ControlParameter<AColor> - The control parameter for thumb,
     borderColor: ControlParameter<AColor> - The control parameter for thumb,
     titleColor: ControlParameter<AColor> - The control parameter for thumb,
     titleFont: ControlParameter<AFont> - The control parameter for thumb
   )
 # Example to create OutlineSliderTabScheme:
 # Code
 ```
let scheme = OutlineSliderTabScheme()
 ```
 */
public final class OutlineSliderTabSchemeControlParameter: AppThemeScheme {

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

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic

        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleFont.set(parameter: theme.fonts.subhead3, for: .normal)

        borderColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        borderColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)

        thumbColor.set(parameter: theme.colors.elementAccent, for: .selected)
        thumbColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)

        titleFont.set(parameter: theme.fonts.subhead2, for: .selected)

        titleColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .selected)
    }

    public init(
        backgroundColor: AColor,
        thumbColor: ControlParameter<AColor>,
        borderColor: ControlParameter<AColor>,
        titleColor: ControlParameter<AColor>,
        titleFont: ControlParameter<AFont>
    ) {
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.borderColor = borderColor
        self.titleColor = titleColor
        self.titleFont = titleFont
    }

}
