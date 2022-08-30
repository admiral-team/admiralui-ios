//
//  ArrowSegmentSliderCustomThemeObserver.swift
//  AdmiralSwiftUI
//
//  Created on 28.04.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources
/**
 ArrowSegmentSliderScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - ArrowSegmentSliderScheme() - Initialize default ArrowSegmentSliderScheme with default themezation
 - ArrowSegmentSliderScheme(
    imageTintColor: AColor
   )
 # Example to create ArrowSegmentSliderScheme:
 # Code
 ```
let scheme = ArrowSegmentSliderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public final class ArrowSegmentSliderScheme: AppThemeScheme {

    // MARK: - Properties

    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        imageTintColor = theme.colors.backgroundAdditionalOne
    }

    public init(imageTintColor: AColor) {
        self.imageTintColor = imageTintColor
    }

}
