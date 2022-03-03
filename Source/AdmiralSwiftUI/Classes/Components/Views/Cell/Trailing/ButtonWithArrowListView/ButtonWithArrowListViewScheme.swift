//
//  ButtonWithArrowListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public class ButtonWithArrowListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var button: GhostButtonWithImageScheme
    public var image: Image? {
        didSet { button.image = image }
    }
    
    required public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        button = GhostButtonWithImageScheme(theme: theme)
    }
}
