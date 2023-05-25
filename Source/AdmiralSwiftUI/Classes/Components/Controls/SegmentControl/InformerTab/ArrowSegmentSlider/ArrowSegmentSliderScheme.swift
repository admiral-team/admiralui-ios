//
//  ArrowSegmentSliderCustomThemeObserver.swift
//  AdmiralSwiftUI
//
//  Created on 28.04.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
/**
 ArrowSegmentSliderScheme - the visual scheme of PlatformButtonStyle.
 You can create a by specifying the following parameters in init:
 - ArrowSegmentSliderScheme() - Initialize default ArrowSegmentSliderScheme with default themezation
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

    public init(theme: AppTheme = .default) {
        imageTintColor = theme.colors.backgroundAdditionalOne
    }

}
