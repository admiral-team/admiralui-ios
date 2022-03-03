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
    
    public var imageTintColor: AColor
    
    public init(theme: AppTheme) {
        imageTintColor = theme.colors.backgroundAdditionalOne
    }
    
}
