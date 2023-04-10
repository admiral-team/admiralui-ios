//
//  TitleWithImageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 TitleWithImageListViewScheme - the visual scheme of TitleSubtitleButtonListView.
 You can create a by specifying the following parameters in init:
 - TitleWithImageListViewScheme() - Initialize default TitleWithImageListViewScheme with default themezation
 # Example to create TitleWithImageListViewScheme:
 # Code
 ```
 let scheme = TitleWithImageListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct TitleWithImageListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var viewBackgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets title label text color with state
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageTintColor = ControlParameter<AColor>()

    /// The  parameter that sets image view alpha with state
    public var imageViewAlpha = ControlParameter<Double>()

    /// The  parameter that sets title font with state
    public var titleFont = TitleWithImageListViewParameters<AFont>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        viewBackgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        viewBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleLabelTextColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
        
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
    }
}

public struct TitleWithImageListViewParameters<P> {
    var parameters: [String: P?] = [:]
    
    mutating func set(parameter: P?, for state: ControlState, style: TitleWithImageListStyle?) {
        let key = paramKey(state: state, style: style)
        parameters[key] = parameter
    }
    
    func parameter(for state: ControlState, style: TitleWithImageListStyle?) -> P? {
        let key = paramKey(state: state, style: style)
        let defaultKey = paramKey(state: .normal, style: nil)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(state: ControlState, style: TitleWithImageListStyle?) -> String {
        return "\(state.rawValue).\(style?.rawValue ?? "")"
    }
    
}
