//
//  TimePickerCustomTheme.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 TimePickerCustomTheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TimePickerCustomTheme() - Initialize default TimePickerCustomTheme with default themezation
Example to create TimePickerCustomTheme:
Code
 ```
let scheme = TimePickerCustomTheme()
 ```
 */
public struct TimePickerCustomTheme: AppThemeScheme {

    /// Border color.
    var borderColor = ControlParameter<AColor>()

    /// Background color.
    var backgroundColor: AColor

    /// Left text color.
    var leftTextColor = TimePickerTextParameter<AColor>()

    /// Right text color.
    var rightTextColor = TimePickerTextParameter<AColor>()

    /// Separator color.
    var separatorColor = TimePickerTextParameter<AColor>()

    /// Wheel text color
    var wheelTextColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
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

/// A container for setting value for difference state.
public struct TimePickerTextParameter<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: Time picker state.
    ///   - controlState: Control state.
    public mutating func set(parameter: P?, for state: TimePickerStates, controlState: UIControl.State) {
        let key = paramKey(state: state, controlState: controlState)
        parameters[key] = parameter
    }

    /// Getting parameter.
    /// - Parameters:
    ///   - state: Time picker state.
    ///   - controlState: Control state.
    /// - Returns: Any value.
    public func parameter(for state: TimePickerStates, controlState: UIControl.State) -> P? {
        let key = paramKey(state: state, controlState: controlState)
        let defaultKey = paramKey(state: .defaultState, controlState: .normal)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: TimePickerStates, controlState: UIControl.State) -> String {
        return "\(state.rawValue).\(controlState.rawValue)"
    }
    
}
