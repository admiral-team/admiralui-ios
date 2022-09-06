//
//  StyleProvider.swift
//  AdmiralSwiftUI
//
//  Created on 05.07.2021.
//

import Combine
import SwiftUI

@available(iOS 14.0.0, *)
public protocol AppThemeScheme {
    init(theme: AppTheme)
}

@available (iOS 14.0.0, *)
public class SchemeProvider<S>: ObservableObject {
    @Published public fileprivate(set) var scheme: S
    public init (scheme: S) {
        self.scheme = scheme
    }
}

@available (iOS 14.0.0, *)
public class ManualSchemeProvider<S>: SchemeProvider<S> {
    public func update(scheme: S) {
        self.scheme = scheme
    }
}

@available(iOS 14.0.0, *)
public class AppThemeSchemeProvider<S>: SchemeProvider<S> where S: AppThemeScheme {
    private let manager: SwiftUIThemeManager
    private var subscribers: Set<AnyCancellable> = []
    
    public init(manager: SwiftUIThemeManager = .shared) {
        self.manager = manager
        super.init(scheme: S(theme: manager.theme))
        manager.$theme.sink { [weak self] theme in
            self?.scheme = S(theme: theme)
        }.store(in: &subscribers)
    }
}

@available(iOS 14.0.0, *)
public final class AppThemeConstantSchemeProvider<S> where S: AppThemeScheme {
    public var scheme: S
    public init(scheme: S) {
        self.scheme = scheme
    }
}


