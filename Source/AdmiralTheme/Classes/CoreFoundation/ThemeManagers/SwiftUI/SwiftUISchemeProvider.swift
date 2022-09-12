//
//  StyleProvider.swift
//  AdmiralSwiftUI
//
//  Created on 05.07.2021.
//

import Combine
import SwiftUI

@available (iOS 14.0.0, *)
/// Scheme provider is classs to store scheme.
public class SchemeProvider<S>: ObservableObject where S: AppThemeScheme {

    // MARK: - Public Properties

    /// Scheme element. It store colors and fonts details.
    @Published public internal(set) var scheme: S

    // MARK: - Public Methods

    /// Get scheme provider.
    /// - Parameter scheme: Scheme element. It store colors and fonts details.
    /// - Returns: Scheme provider.
    public static func constant(scheme: S) -> SchemeProvider<S> {
        return SchemeProvider<S>(scheme: scheme)
    }

    // MARK: - Initializer

    public init(scheme: S) {
        self.scheme = scheme
    }

}
