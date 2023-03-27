//
//  SwiftUIThemeManager.swift
//  AdmiralSwiftUI
//
//  Created on 20.05.2021.
//

import SwiftUI
import Combine

public final class SwiftUIThemeManager {

    // MARK: - Published Properties
    public var theme: AppTheme = AppTheme.default {
        willSet {
            if #available(iOS 13.0, *) {
                objectWillChange.send()
            }
        }
    }

    // MARK: - Initializer
    public init() {}

    @available(iOS 13.0, *)
    public init(theme: AppTheme) {
        self.theme = theme
    }
}

@available(iOS 13.0, *)
extension SwiftUIThemeManager: ObservableObject {}

@available(iOS 13.0, *)
public struct ObjectEnvironmentKey: EnvironmentKey {
    public static var defaultValue: SwiftUIThemeManager = Appearance.shared.swiftuiThemeManager
}

@available(iOS 13.0, *)
public extension EnvironmentValues {
    var manager: SwiftUIThemeManager {
        get { self[ObjectEnvironmentKey.self] }
        set { self[ObjectEnvironmentKey.self] = newValue }
    }
}

@available(iOS 13.0, *)
public extension View {
    func object(_ value: SwiftUIThemeManager) -> some View {
        environment(\.manager, value)
    }
}
