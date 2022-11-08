//
//  TimePickerStateService.swift
//  AdmiralUI
//
//  Created on 16.03.2021.
//

import Foundation

enum TimePickerEditingSide: Int {
    case left
    case right
    case none
}

enum TimePickerEditingMode: Int {
    case scroll
    case sides
    case all
}

enum TimePickerWheelEditingMode: Int {
    case scroll
    case textEdit
}

typealias TimePickerState = (TimePickerEditingSide, TimePickerEditingMode, TimePickerWheelEditingMode, isSelected: Bool)

/// Time picker state.
public enum TimePickerStates: Int {
    case defaultState
    case scrollEditing
    case scrollLeftEditing
    case scrollRightEditing
    case allEdititngScrollRightEditing
    case allEditingScrollLeftEditing
    case allEditingScroll
    case allEditingTextField
    case leftEditingTextFieldScroll
    case leftEditingTextFieldTextEdit
    case rightEditingTextFieldTextScroll
    case rightEditingTextFieldTextEdit
}

struct TimePickerStateMachine {

    var state = TimePickerStateParameters<TimePickerStates>()
    
    init() { // swiftlint:disable:this function_body_length
        state.set(
            parameter: .defaultState,
            timePickerEditingSide: .none,
            timePickerEditingMode: .scroll,
            timePickerWheelEditingMode: .scroll,
            isSelected: false)
        state.set(
            parameter: .scrollEditing,
            timePickerEditingSide: .none,
            timePickerEditingMode: .scroll,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .scrollLeftEditing,
            timePickerEditingSide: .left,
            timePickerEditingMode: .scroll,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .scrollRightEditing,
            timePickerEditingSide: .right,
            timePickerEditingMode: .scroll,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .allEditingScroll,
            timePickerEditingSide: .none,
            timePickerEditingMode: .all,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .allEditingScrollLeftEditing,
            timePickerEditingSide: .left,
            timePickerEditingMode: .all,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .allEdititngScrollRightEditing,
            timePickerEditingSide: .right,
            timePickerEditingMode: .all,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .allEditingTextField,
            timePickerEditingSide: .none,
            timePickerEditingMode: .all,
            timePickerWheelEditingMode: .textEdit,
            isSelected: true)
        state.set(
            parameter: .leftEditingTextFieldScroll,
            timePickerEditingSide: .left,
            timePickerEditingMode: .sides,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .leftEditingTextFieldTextEdit,
            timePickerEditingSide: .left,
            timePickerEditingMode: .sides,
            timePickerWheelEditingMode: .textEdit,
            isSelected: true)
        state.set(
            parameter: .rightEditingTextFieldTextScroll,
            timePickerEditingSide: .right,
            timePickerEditingMode: .sides,
            timePickerWheelEditingMode: .scroll,
            isSelected: true)
        state.set(
            parameter: .rightEditingTextFieldTextEdit,
            timePickerEditingSide: .right,
            timePickerEditingMode: .sides,
            timePickerWheelEditingMode: .textEdit,
            isSelected: true)
    }
    
}

struct TimePickerStateParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(
        parameter: P?,
        timePickerEditingSide: TimePickerEditingSide,
        timePickerEditingMode: TimePickerEditingMode,
        timePickerWheelEditingMode: TimePickerWheelEditingMode,
        isSelected: Bool) {
        let key = paramKey(
            timePickerEditingSide: timePickerEditingSide,
            timePickerEditingMode: timePickerEditingMode,
            timePickerWheelEditingMode: timePickerWheelEditingMode,
            isSelected: isSelected)
        parameters[key] = parameter
    }
    
    func parameter(
        timePickerEditingSide: TimePickerEditingSide,
        timePickerEditingMode: TimePickerEditingMode,
        timePickerWheelEditingMode: TimePickerWheelEditingMode,
        isSelected: Bool) -> P? {
        let key = paramKey(
            timePickerEditingSide: timePickerEditingSide,
            timePickerEditingMode: timePickerEditingMode,
            timePickerWheelEditingMode: timePickerWheelEditingMode,
            isSelected: isSelected)
        let defaultKey = paramKey(
            timePickerEditingSide: .none,
            timePickerEditingMode: .scroll,
            timePickerWheelEditingMode: .scroll,
            isSelected: false)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(
        timePickerEditingSide: TimePickerEditingSide,
        timePickerEditingMode: TimePickerEditingMode,
        timePickerWheelEditingMode: TimePickerWheelEditingMode,
        isSelected: Bool) -> String {
        return "\(timePickerEditingSide.rawValue).\(timePickerEditingMode.rawValue).\(timePickerWheelEditingMode.rawValue).\(isSelected ? 1 : 0)"
    }
    
}
