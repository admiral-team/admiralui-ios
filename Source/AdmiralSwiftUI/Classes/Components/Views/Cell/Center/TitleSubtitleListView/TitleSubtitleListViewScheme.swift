//
//  TitleSubtitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 TitleSubtitleListViewScheme - the visual scheme of TitleSubtitleListView.
 You can create a by specifying the following parameters in init:
 - TitleSubtitleListViewScheme() - Initialize default TitleSubtitleListViewScheme with default themezation
 # Example to create TitleSubtitleListViewScheme:
 # Code
 ```
 let scheme = TitleSubtitleListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct TitleSubTitleSubtitleListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The title color
    public var titleColor = ControlParameter<AColor>()

    /// The subtitle color
    public var subtitleColor = ControlParameter<AColor>()

    /// The title font label
    public var titleFont = TitleSubtitleListViewParameters<AFont>()

    /// The subtitle font label
    public var subtitleFont = TitleSubtitleListViewParameters<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headlineSecondary)
        
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: nil)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .title)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .body)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .headline)
    }
}

public struct TitleSubtitleListViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: ControlState, style: TitleSubtitleListViewStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: ControlState, style: TitleSubtitleListViewStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: ControlState, style: TitleSubtitleListViewStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
