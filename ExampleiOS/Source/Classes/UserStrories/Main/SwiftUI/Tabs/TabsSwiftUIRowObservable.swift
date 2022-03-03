//
//  TabsSwiftUIRowObservable.swift
//  ExampleiOS
//
//  Created by ADyatkov on 20.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import Combine

@available(iOS 13.0, *)
final class TabsSwiftUIRowObservable: ObservableObject, AnyAppThemable {
    
    var backgroundColor: AColor
    
    var titleColor: AColor
    var titleFont: AFont
    
    convenience init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        
        titleFont = theme.fonts.body1
        titleColor = theme.colors.textPrimary
        
        autoManage()
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        
        titleFont = theme.fonts.body1
        titleColor = theme.colors.textPrimary
    }
    
}
