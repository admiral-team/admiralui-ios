//
//  SwiftUIContentViewObserver.swift
//  ExampleiOS
//
//  Created by ADyatkov on 15.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import Combine

@available(iOS 13.0, *)
final class SwiftUIContentViewObservable: ObservableObject, AnyAppThemable {
    
    var backgroundColor: AColor
    var textColor: AColor
    var textFont: AFont
    
    convenience init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.headline
        
        autoManage()
    }
    
    // MARK: - AppTheamable
    
    public func apply(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.headline
    }
    
}
