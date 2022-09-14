//
//  SwiftUIThemeManager.swift
//  AdmiralSwiftUI
//
//  Created on 20.05.2021.
//

import SwiftUI
import Combine

public final class SwiftUIThemeManager: ObservableObject {

    // MARK: - Published Properties

    @Published public var theme = AppTheme.light

    // MARK: - Initializer

    public init() {}

    public init(theme: AppTheme) {
        self.theme = theme
    }
}

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
