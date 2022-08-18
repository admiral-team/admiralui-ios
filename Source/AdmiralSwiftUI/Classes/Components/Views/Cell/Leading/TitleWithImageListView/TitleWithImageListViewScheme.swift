//
//  TitleWithImageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct TitleWithImageListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of TitleWithImageListView
    public var viewBackgroundColor = ControlParameter<AColor>()

    /// The title label text color of TitleWithImageListView
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The image tint color of TitleWithImageListView
    public var imageTintColor = ControlParameter<AColor>()

    /// The image alpha color of TitleWithImageListView
    public var imageViewAlpha = ControlParameter<Double>()

    /// The title font of TitleWithImageListView
    public var titleFont = TitleWithImageListViewParameters<AFont>()

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
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
