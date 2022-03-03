//
//  ToastViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 26.07.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ToastViewScheme: AppThemeScheme {
    
    public var backgroundColor = ToastViewParameters<AColor>()
    public var textColor: AColor
    public var closeTintColor: AColor
    public var closeLinkColor: AColor
    public var imageTintColor =  ToastImageParameters<AColor>()
    
    public var titleFont: AFont
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, type: .default)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, type: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, type: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAttention, type: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundError, type: .error)
        
        imageTintColor.set(parameter: theme.colors.elementSuccess, type: .success)
        imageTintColor.set(parameter: theme.colors.elementAccent, type: .info)
        imageTintColor.set(parameter: theme.colors.elementAttention, type: .attention)
        imageTintColor.set(parameter: theme.colors.elementError, type: .error)
        
        textColor = theme.colors.textPrimary
        closeTintColor = theme.colors.elementPrimary
        closeLinkColor = theme.colors.elementAccent
        
        titleFont = theme.fonts.body2
    }
}

public struct ToastViewParameters<P> {
    
    public var parameters: [String: P?] = [:]
    
    public mutating func set(parameter: P?, type: ToastViewType) {
        let key = paramKey(type: type)
        parameters[key] = parameter
    }
    
    public func parameter(type: ToastViewType) -> P? {
        let key = paramKey(type: type)
        let defaultKey = paramKey(type: .default)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(type: ToastViewType) -> String {
        return "\(type.rawValue)"
    }
    
}

public struct ToastImageParameters<P> {
    
    public var parameters: [String: P?] = [:]
    
    public mutating func set(parameter: P?, type: ToastImageType) {
        let key = paramKey(type: type)
        parameters[key] = parameter
    }
    
    public func parameter(type: ToastImageType) -> P? {
        let key = paramKey(type: type)
        let defaultKey = paramKey(type: .info)
        
        guard let parameter = parameters[key] ?? parameters[defaultKey] else { return nil }
        return parameter
    }
    
    private func paramKey(type: ToastImageType) -> String {
        return "\(type.rawValue)"
    }
    
}
