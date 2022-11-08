//
//  TitleHeaderScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 TitleHeaderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleHeaderScheme() - Initialize default TitleHeaderScheme with default themezation
Example to create TitleHeaderScheme:
Code
 ```
let scheme = TitleHeaderScheme()
 ```
 */
public struct TitleHeaderScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Default title font.
    public var defaultTitleFont: AFont

    /// Title font.
    public var titleFont = TitleHeaderViewParameters<AFont>()

    /// Text color.
    public var textColor = TitleHeaderViewParameters<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundBasic
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: nil)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        defaultTitleFont = theme.fonts.body1
    }
}

/// A container for setting value for difference state.
public struct TitleHeaderViewParameters<P> {

    /// Parameters with generic values.
    public var parameters: [String: P?] = [:]

    /// Setting value for state.
    /// - Parameters:
    ///   - parameter: Any value. For Example text color
    ///   - state: State.
    ///   - style: Style header view.
    public mutating func set(parameter: P?, for state: UIControl.State, style: HeaderStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }

    /// Getting parameter
    /// - Parameters:
    ///   - state: State.
    ///   - style: Style paragraph view.
    /// - Returns: Any value.
    public func parameter(for state: UIControl.State, style: HeaderStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: UIControl.State, style: HeaderStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
