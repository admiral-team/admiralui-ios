//
//  CalendarDayLabel.swift
//  AdmiralUI
//
//  Created on 04.02.2021.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

class CalendarDayLabel: UILabel, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        setDynamicFont(font: theme.fonts.subhead2.uiFont,
                       textStyle: theme.fonts.subhead2.textStyle,
                       adjustsFontForContentSize: Appearance.isAccessabilitySupportEnabled)
        textColor = theme.colors.textSecondary.uiColor
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        
        textAlignment = .center
        isAccessibilityElement = false
    }
    
}
