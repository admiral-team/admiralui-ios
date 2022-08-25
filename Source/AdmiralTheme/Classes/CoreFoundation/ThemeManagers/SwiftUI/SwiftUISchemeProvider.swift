//
//  StyleProvider.swift
//  AdmiralSwiftUI
//
//  Created on 05.07.2021.
//

import Combine
import SwiftUI

@available(iOS 14.0.0, *)
public class SwiftUISchemeProvider<S>: ObservableObject where S: AppThemeScheme {

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
    public var scheme: S
    public init(scheme: S) {
        self.scheme = scheme
    }
}
