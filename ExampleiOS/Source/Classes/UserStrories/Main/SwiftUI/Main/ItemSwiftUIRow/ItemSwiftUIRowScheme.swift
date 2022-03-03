//
//  ItemSwiftUIRowScheme.swift
//  ExampleiOS
//
//  Created on 21.05.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources
import Combine

@available(iOS 14.0.0, *)
final public class ItemSwiftUIRowScheme: AppThemeScheme {
    
    public var titleFont: AFont
    public var subtitleFont: AFont
    
    public var titleColor: AColor
    public var subtitleColor: AColor
    
    public var imageBackgroundColor: AColor
    public var imageTintColor: AColor
    
    public var backgroundColor: AColor
    
    public var arrowImageTintColor: AColor
    
    public init(theme: AppTheme) {
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subhead4
        
        titleColor = theme.colors.textPrimary
        subtitleColor = theme.colors.textSecondary
        
        imageBackgroundColor = theme.colors.backgroundAdditionalOne
        imageTintColor = theme.colors.elementAccent
        
        arrowImageTintColor = theme.colors.elementSecondary
        
        backgroundColor = theme.colors.backgroundBasic
    }

}
