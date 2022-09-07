//
//  ToolBarItemScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.08.2022.
//
import AdmiralTheme
import AdmiralUIResources
/**
 ToolBarItemScheme - the visual scheme of MapButtonStyle.
 You can create a by specifying the following parameters in init:
 - ToolBarItemScheme() - Initialize default ToolBarItemScheme with default themezation
 Example to create ToolBarItemScheme:
 Code
 ```
 let scheme = ToolBarItemScheme()
 ```
 */
public struct ToolBarItemScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title color
    public var titleColor = ToolbarItemParameters<AColor>()

    /// The image color
    public var imageColor = ToolbarItemParameters<AColor>()

    /// The horizontal title label font
    public var titleLabelHorizontalFont: AFont

    /// The vertical title label font
    public var titleLabelVerticalFont: AFont

    /// The border color
    public var borderColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelVerticalFont = theme.fonts.caption2
        titleLabelHorizontalFont = theme.fonts.subhead2

        borderColor = theme.colors.backgroundAccentDark

        // Normal
        titleColor.set(parameter: theme.colors.textContrast, for: .normal, type: .default)
        titleColor.set(parameter: theme.colors.textErrorDefault, for: .normal, type: .error)
        titleColor.set(parameter: theme.colors.textSuccessDefault, for: .normal, type: .success)
        titleColor.set(parameter: theme.colors.textAttentionDefault, for: .normal, type: .attention)

        imageColor.set(parameter: theme.colors.elementContrast, for: .normal, type: .default)
        imageColor.set(parameter: theme.colors.elementErrorDefault, for: .normal, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccessDefault, for: .normal, type: .success)
        imageColor.set(parameter: theme.colors.elementAttentionDefault, for: .normal, type: .attention)

        // Selected
        titleColor.set(parameter: theme.colors.textAccent, for: .selected, type: .default)
        titleColor.set(parameter: theme.colors.textError, for: .selected, type: .error)
        titleColor.set(parameter: theme.colors.textSuccess, for: .selected, type: .success)
        titleColor.set(parameter: theme.colors.textAttention, for: .selected, type: .attention)

        imageColor.set(parameter: theme.colors.elementAccent, for: .selected, type: .default)
        imageColor.set(parameter: theme.colors.elementError, for: .selected, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccess, for: .selected, type: .success)
        imageColor.set(parameter: theme.colors.elementAttention, for: .selected, type: .attention)

        // Highlighted
        titleColor.set(parameter: theme.colors.textAccent, for: .highlighted, type: .default)
        titleColor.set(parameter: theme.colors.textError, for: .highlighted, type: .error)
        titleColor.set(parameter: theme.colors.textSuccess, for: .highlighted, type: .success)
        titleColor.set(parameter: theme.colors.textAttention, for: .highlighted, type: .attention)

        imageColor.set(parameter: theme.colors.elementAccent, for: .highlighted, type: .default)
        imageColor.set(parameter: theme.colors.elementError, for: .highlighted, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccess, for: .highlighted, type: .success)
        imageColor.set(parameter: theme.colors.elementAttention, for: .highlighted, type: .attention)

        // Disabled
        titleColor.set(parameter: theme.colors.textContrast.withAlpha(alpha), for: .disabled, type: .default)
        titleColor.set(parameter: theme.colors.textErrorDefault.withAlpha(alpha), for: .disabled, type: .error)
        titleColor.set(parameter: theme.colors.textSuccessDefault.withAlpha(alpha), for: .disabled, type: .success)
        titleColor.set(parameter: theme.colors.textAttentionDefault.withAlpha(alpha), for: .disabled, type: .attention)

        imageColor.set(parameter: theme.colors.elementContrast.withAlpha(alpha), for: .disabled, type: .default)
        imageColor.set(parameter: theme.colors.elementErrorDefault.withAlpha(alpha), for: .disabled, type: .error)
        imageColor.set(parameter: theme.colors.elementSuccessDefault.withAlpha(alpha), for: .disabled, type: .success)
        imageColor.set(parameter: theme.colors.elementAttentionDefault.withAlpha(alpha), for: .disabled, type: .attention)
    }
}

public struct ToolbarItemParameters<P> {
    var parameters: [String: P?] = [:]

    public mutating func set(parameter: P?, for state: ControlState, type: ToolbarItemType) {
        let key = paramKey(state: state, type: type)
        parameters[key] = parameter
    }

    public func parameter(for state: ControlState, type: ToolbarItemType) -> P? {
        let key = paramKey(state: state, type: type)
        let defaultKey = paramKey(state: .normal, type: type)

        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }

    private func paramKey(state: ControlState, type: ToolbarItemType) -> String {
        return "\(state.rawValue).\(type.rawValue)"
    }

}
