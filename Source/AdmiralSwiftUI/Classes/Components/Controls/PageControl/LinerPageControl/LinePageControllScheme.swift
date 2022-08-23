//
//  LinePageControllScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PageControlViewScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - PageControlViewScheme() - Initialize default PageControlViewScheme with default themezation
 - PageControlViewScheme(
    normalColor: AColor - the normal background color of PageControlView ,
    selectedColor: AColor - the selected background color of PageControlView
   )
 # Example to create PageControlViewScheme:
 # Code
 ```
let scheme = PageControlViewScheme()
let customScheme = PageControlViewScheme(
    normalColor: AppTheme.default.colors.extra17,
    selectedColor: AppTheme.default.colors.backgroundAccentPressed
)
 ```
 */
@available(iOS 14.0.0, *)
public struct PageControlViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The control parameter to set background color for PageControlView
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(
        normalColor: AColor,
        selectedColor: AColor
    ) {
        backgroundColor.set(parameter: normalColor, for: .normal)
        backgroundColor.set(parameter: selectedColor, for: .selected)
    }

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }

}
