//
//  ShimmersSwiftUIViewScheme.swift
//  ExampleiOS
//
//  Created on 08.07.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import Combine

@available(iOS 14.0.0, *)
public class ShimmersSwiftUIViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var backgroundShimmerColor: AColor
    public var shimmerColor: AColor
    
    required public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        backgroundShimmerColor = theme.colors.backgroundAdditionalOne
        shimmerColor = theme.colors.elementStaticWhite
    }
    
}
