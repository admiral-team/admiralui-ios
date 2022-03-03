//
//  TimePickerCustomTheme.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct TimePickerCustomTheme {
    var borderColor = ControlParameter<AColor>()
    var backgroundColor: AColor
    var leftTextColor = TimePickerTextParameter<AColor>()
    var rightTextColor = TimePickerTextParameter<AColor>()
    var separatorColor = TimePickerTextParameter<AColor>()
    var wheelTextColor = ControlParameter<AColor>()
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundAdditionalTwo
        wheelTextColor.set(parameter: theme.colors.elementAccent, for: .normal)
        wheelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        leftTextColor.set(parameter: theme.colors.textPrimary, for: .defaultState, controlState: .normal)
        leftTextColor.set(parameter: theme.colors.textSecondary, for: .defaultState, controlState: [.disabled])
        leftTextColor.set(parameter: theme.colors.textAccent, for: .allEditingScroll, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textPrimary, for: .allEditingTextField, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .leftEditingTextFieldScroll, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textPrimary, for: .leftEditingTextFieldTextEdit, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textSecondary, for: .rightEditingTextFieldTextEdit, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textSecondary, for: .rightEditingTextFieldTextScroll, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .scrollEditing, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .scrollLeftEditing, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .scrollRightEditing, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .allEdititngScrollRightEditing, controlState: .selected)
        leftTextColor.set(parameter: theme.colors.textAccent, for: .allEditingScrollLeftEditing, controlState: .selected)
        
        rightTextColor.set(parameter: theme.colors.textPrimary, for: .defaultState, controlState: .normal)
        rightTextColor.set(parameter: theme.colors.textSecondary, for: .defaultState, controlState: [.disabled])
        rightTextColor.set(parameter: theme.colors.textAccent, for: .allEditingScroll, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textPrimary, for: .allEditingTextField, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textSecondary, for: .leftEditingTextFieldScroll, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textSecondary, for: .leftEditingTextFieldTextEdit, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textPrimary, for: .rightEditingTextFieldTextEdit, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .rightEditingTextFieldTextScroll, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .scrollEditing, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .scrollLeftEditing, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .scrollRightEditing, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .allEdititngScrollRightEditing, controlState: .selected)
        rightTextColor.set(parameter: theme.colors.textAccent, for: .allEditingScrollLeftEditing, controlState: .selected)
    
        separatorColor.set(parameter: theme.colors.textPrimary, for: .defaultState, controlState: .normal)
        separatorColor.set(parameter: theme.colors.textSecondary, for: .defaultState, controlState: [.disabled])
        separatorColor.set(parameter: theme.colors.elementAccent, for: .allEditingScroll, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .allEditingTextField, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .leftEditingTextFieldScroll, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .leftEditingTextFieldTextEdit, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .rightEditingTextFieldTextEdit, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .rightEditingTextFieldTextScroll, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .scrollEditing, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .allEdititngScrollRightEditing, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .allEditingScrollLeftEditing, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .scrollLeftEditing, controlState: .selected)
        separatorColor.set(parameter: theme.colors.textAccent, for: .scrollRightEditing, controlState: .selected)
        
        borderColor.set(parameter: AColor.clear, for: .normal)
        borderColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
        borderColor.set(parameter: AColor.clear, for: [.disabled])
    }

}

struct TimePickerTextParameter<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: TimePickerStates, controlState: UIControl.State) {
        let key = paramKey(state: state, controlState: controlState)
        parameters[key] = parameter
    }
    
    func parameter(for state: TimePickerStates, controlState: UIControl.State) -> P? {
        let key = paramKey(state: state, controlState: controlState)
        let defaultKey = paramKey(state: .defaultState, controlState: .normal)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: TimePickerStates, controlState: UIControl.State) -> String {
        return "\(state.rawValue).\(controlState.rawValue)"
    }
    
}
