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

    // MARK: - Published Properties

    @Published public private(set) var scheme: S

    // MARK: - Private Properties

    private let manager = Appearance.shared.swiftuiThemeManager
    private var subscribers: Set<AnyCancellable> = []

    // MARK: - Initializer

    public init(manager: SwiftUIThemeManager = Appearance.shared.swiftuiThemeManager) {
        self.scheme = S(theme: manager.theme)
        manager.$theme.sink { [weak self] theme in
            self?.scheme = S(theme: theme)
        }.store(in: &subscribers)
    }
}

@available(iOS 14.0.0, *)
public final class SwiftUIConstantSchemeProvider<S> where S: AppThemeScheme {

    // MARK: - Public Properties

    public var scheme: S

    // MARK: - Initializer

    public init(scheme: S) {
        self.scheme = scheme
    }
}

