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

@available(iOS 14.0.0, *)
public class AppThemeSchemeProvider<S>: ObservableObject where S: AppThemeScheme {
    @Published public private(set) var scheme: S

    private let manager = SwiftUIThemeManager.shared
    private var subscribers: Set<AnyCancellable> = []
    
    public init(manager: SwiftUIThemeManager = .shared) {
        self.scheme = S(theme: manager.theme)
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


