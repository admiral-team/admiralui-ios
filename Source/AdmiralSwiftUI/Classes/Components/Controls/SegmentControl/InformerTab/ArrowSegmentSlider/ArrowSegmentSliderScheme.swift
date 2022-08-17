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

@available(iOS 14.0.0, *)
public final class ArrowSegmentSliderScheme: AppThemeScheme {

    // MARK: - Properties

    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        imageTintColor = theme.colors.backgroundAdditionalOne
    }
    
}
