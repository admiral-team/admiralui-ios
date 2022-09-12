//
//  ManualSchemeProvider.swift
//  AdmiralTheme
//
//  Created by ADyatkov on 06.09.2022.
//

import Combine
import SwiftUI

@available (iOS 14.0.0, *)
/// Manual scheme provider is class to store and update scheme.
public class ManualSchemeProvider<S>: SchemeProvider<S> where S: AppThemeScheme {

    // MARK: - Public methods

    /// Method to change scheme.
    /// - Parameter scheme: scheme element. It store colors and fonts details.
    public func update(scheme: S) {
        self.scheme = scheme
    }
    
}
