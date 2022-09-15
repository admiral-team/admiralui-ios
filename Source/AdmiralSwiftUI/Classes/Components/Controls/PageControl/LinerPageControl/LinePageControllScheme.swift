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
 # Example to create PageControlViewScheme:
 # Code
 ```
let scheme = PageControlViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PageControlViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The control parameter to set background color for PageControlView
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }

}
