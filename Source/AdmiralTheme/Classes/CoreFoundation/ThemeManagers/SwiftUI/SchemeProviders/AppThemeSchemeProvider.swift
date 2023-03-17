//
//  AppThemeSchemeProvider.swift
//  AdmiralTheme
//
//  Created on 06.09.2022.
//

import Combine
import SwiftUI

@available(iOS 14.0.0, *)
/// App theme scheme provider - is class to dynamic change scheme proceeding from theme.
public final class AppThemeSchemeProvider<S>: SchemeProvider<S> where S: AppThemeScheme {

    // MARK: - Private properties

    private let manager: SwiftUIThemeManager
    private var subscribers: Set<AnyCancellable> = []

    // MARK: - Initializer

    public init(manager: SwiftUIThemeManager = Appearance.shared.swiftuiThemeManager) {
        self.manager = manager
        super.init(scheme: S(theme: manager.theme))
        manager.objectWillChange.sink { [weak self] _ in
            self?.scheme = S(theme: manager.theme)
        }.store(in: &subscribers)
    }
}

@available(iOS 14.0.0, *)
/// App theme constant scheme provider is class to store constant scheme.
public final class AppThemeConstantSchemeProvider<S> where S: AppThemeScheme {

    // MARK: - Public Properties

    /// Scheme element. It store colors and fonts details.
    public var scheme: S

    // MARK: - Initializer

    public init(scheme: S) {
        self.scheme = scheme
    }
}
