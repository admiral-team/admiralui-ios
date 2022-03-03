//
//  ToastViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.12.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ToastViewScheme {

    var titleTextColor: AColor
    var titleTextFont: AFont
    
    var backgroundColor = ToastViewParameters<AColor>()
    var imageTintColor =  ToastImageParameters<AColor>()
    
    var closeTintColor: AColor
    var closeTitleColor: AColor
    var closeTitleFont: AFont
    
    var countDownTimerViewScheme = CountDownTimerViewScheme()
    
    var primaryLinkScheme = TagControlCustomScheme()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleTextColor = theme.colors.textPrimary
        titleTextFont = theme.fonts.body2
        
        closeTintColor = theme.colors.elementPrimary
        closeTitleColor = theme.colors.elementAccent
        closeTitleFont = theme.fonts.body2
        
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, type: .default)
        backgroundColor.set(parameter: theme.colors.backgroundSuccess, type: .success)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, type: .additional)
        backgroundColor.set(parameter: theme.colors.backgroundAttention, type: .attention)
        backgroundColor.set(parameter: theme.colors.backgroundError, type: .error)
        
        imageTintColor.set(parameter: theme.colors.elementSuccess, type: .success)
        imageTintColor.set(parameter: theme.colors.elementAccent, type: .info)
        imageTintColor.set(parameter: theme.colors.elementAttention, type: .attention)
        imageTintColor.set(parameter: theme.colors.elementError, type: .error)
        
        countDownTimerViewScheme = CountDownTimerViewScheme(theme: theme)
        
        primaryLinkScheme = TagControlCustomScheme(theme: theme)
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

