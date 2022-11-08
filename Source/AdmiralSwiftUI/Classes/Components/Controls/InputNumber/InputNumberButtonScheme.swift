//
//  InputNumberButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created by on 13.10.2022.
//  
//
import AdmiralTheme
/**
 InputNumberButtonScheme - the visual scheme of InputNumberButtonStyle.
 You can create a by specifying the following parameters in init:
 - InputNumberButtonScheme() - Initialize default InputNumberButtonScheme with default themezation
 # Example to create InputNumberButtonScheme:
 ```
let scheme = InputNumberButtonScheme()
 ```
 */
@available(iOS 14.0, *)
public final class InputNumberButtonScheme: AppThemeScheme {

    /// The background color
    public var backgroundColor = InputNumberButtonParameters<AColor>()

    /// The tint color
    public var tintColor = InputNumberButtonParameters<AColor>()

    /// The border color
    public var borderColor = InputNumberButtonParameters<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .default)
        tintColor.set(parameter: theme.colors.textSecondary, for: .highlighted, style: .default)
        tintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled, style: .default)

        tintColor.set(parameter: theme.colors.elementAccent, for: .normal, style: .secondary)
        tintColor.set(
            parameter: theme.colors.elementAccent.withAlpha(alpha), for: .highlighted, style: .secondary
        )
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: .secondary)

        tintColor.set(parameter: theme.colors.elementAccent, for: .normal, style: .input)
        tintColor.set(parameter: theme.colors.elementAccentPressed, for: .normal, style: .input)
        tintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: .input)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted, style: .default)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled, style: .default)

        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal, style: .secondary)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted, style: .secondary)
        backgroundColor.set(parameter: theme.colors.backgroundBasic.withAlpha(alpha), for: .disabled, style: .secondary)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal, style: .input)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted, style: .input)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled, style: .input)

        borderColor.set(parameter: theme.colors.elementAccent, for: .normal, style: .secondary)
        borderColor.set(parameter: theme.colors.elementAccentPressed, for: .highlighted, style: .secondary)
        borderColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled, style: .secondary)
    }

}

public struct InputNumberButtonParameters<P> {
    public var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, for state: ControlState, style: InputNumberStyle) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    public func parameter(for state: ControlState, style: InputNumberStyle) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: style)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(state: ControlState, style: InputNumberStyle) -> String {
        return "\(state.rawValue).\(style.rawValue)"
    }

}
