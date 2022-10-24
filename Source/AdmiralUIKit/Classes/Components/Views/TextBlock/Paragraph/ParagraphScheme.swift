//
//  ParagraphScheme.swift
//  AdmiralUIKit
//
//  Created on 18.07.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 ParagraphScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ParagraphScheme() - Initialize default ParagraphScheme with default themezation
Example to create ParagraphScheme:
Code
 ```
let scheme = ParagraphScheme()
 ```
 */
public struct ParagraphScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Text color.
    public var textColor = ParagraphViewParametrs<AColor>()

    /// Leading image color.
    public var leadingImageColor: AColor

    /// Title font.
    public var titleFont = ParagraphViewParametrs<AFont>()

    /// Default font.
    public var defaultTitleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .primary)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: .primary)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .secondary)
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled, style: .secondary)
        
        leadingImageColor = theme.colors.elementPrimary
        titleFont.set(parameter: theme.fonts.body2, for: .normal, style: .primary)
        titleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .secondary)
        defaultTitleFont = theme.fonts.body2
    }

}

/// A container for setting value for difference state.
public struct ParagraphViewParametrs<P> {

    // Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style paragraph view.
    public mutating func set(parameter: P?, for state: UIControl.State, style: ParagraphStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style paragraph view.
    /// - Returns: Any value.
    public func parameter(for state: UIControl.State, style: ParagraphStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, style: ParagraphStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
}
