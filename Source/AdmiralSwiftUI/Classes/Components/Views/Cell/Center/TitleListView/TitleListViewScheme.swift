//
//  TitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 TitleListViewScheme - the visual scheme of TitleListView.
 You can create a by specifying the following parameters in init:
 - TitleListViewScheme() - Initialize default TitleListViewScheme with default themezation
 # Example to create TitleListViewScheme:
 # Code
 ```
 let scheme = TitleListViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TitleListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The text color
    public var textColor = TitleListViewParameters<AColor>()

    /// The title font label
    public var titleFont = TitleListViewParameters<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled, style: nil)
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: nil)
        textColor.set(parameter: theme.colors.textPrimary, for: .normal, style: .paragraph)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .headlineSecondary)
        textColor.set(parameter: theme.colors.textSecondary, for: .normal, style: .paragraphSecondary)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled, style: .paragraph)
        textColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled, style: .paragraphSecondary)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.body2, for: .normal, style: .paragraph)
        titleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .paragraphSecondary)
    }
}

public struct TitleListViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: ControlState, style: TitleListViewStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: ControlState, style: TitleListViewStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: ControlState, style: TitleListViewStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
