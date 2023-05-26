//
//  ThemeSwitchComponentViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.03.2021.
//

import AdmiralTheme
import UIKit

struct ThemeSwitchComponentViewCustomScheme {
    
    var font: AFont
    var backgroundColor = ThemeSwitchComponentViewParameter<AColor>()
    var textColor = ThemeSwitchComponentViewParameter<AColor>()
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        font = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textStaticWhite, for: .selected)
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
    }
}

struct ThemeSwitchComponentViewParameter<Parameter> {
    
    private var parameters: [UInt: Parameter] = [:]
    
    init() {
        //
    }
    
    mutating func set(parameter: Parameter?, for state: UIControl.State) {
        self.parameters[state.rawValue] = parameter
    }

    func parameter(for state: UIControl.State) -> Parameter? {
        if let result = parameters[state.rawValue] ?? parameters[UIControl.State.normal.rawValue] {
            return result
        } else {
            return nil
        }
    }
    
    func forEachState(_ closure: ((UIControl.State, Parameter) -> Void)) {
        parameters.forEach() { closure(UIControl.State(rawValue: $0.key), $0.value) }
    }
    
}
