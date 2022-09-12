//
//  ChatBubbleViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct ChatBubbleViewScheme: AppThemeScheme {
    
    public var textFont: AFont
    public var textColor = ChatBubbleViewParameters<AColor>()
    public var backgroundColor = ChatBubbleViewParameters<AColor>()
    
    public var errorImageColor: AColor
    
    public var nameTextFont: AFont
    public var nameTextColor: AColor

    /// Scheme for status view.
    public var chatBubbleStatusScheme: ChatBubbleStatusViewScheme
    
    public init(theme: AppTheme) {
        textColor.set(parameter: theme.colors.textPrimary, style: .left)
        textColor.set(parameter: theme.colors.textStaticWhite, style: .right)

        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, style: .left)
        backgroundColor.set(parameter: theme.colors.backgroundAccent, style: .right)
        
        errorImageColor = theme.colors.elementError
        
        textFont = theme.fonts.body1
        
        nameTextFont = theme.fonts.caption1
        nameTextColor = theme.colors.textSecondary

        chatBubbleStatusScheme = ChatBubbleStatusViewScheme(theme: theme)
    }
    
}

@available(iOS 14.0, *)
public struct ChatBubbleViewParameters<P> {
    public var parameters: [String: P?] = [:]
    
    public mutating func set(parameter: P?, style: ChatDirection) {
        let key = paramKey(style: style)
        parameters[key] = parameter
    }
    
    public func parameter(for style: ChatDirection) -> P? {
        let key = paramKey(style: style)
        let defaultKey = paramKey(style: style)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(style: ChatDirection) -> String {
        return "\(style.rawValue)"
    }
    
}
