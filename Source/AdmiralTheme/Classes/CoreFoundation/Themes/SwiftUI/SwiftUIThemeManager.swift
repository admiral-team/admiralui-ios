//
//  SwiftUIThemeManager.swift
//  AdmiralSwiftUI
//
//  Created on 20.05.2021.
//

import SwiftUI
import Combine

@available(iOS 14.0.0, *)
public final class SwiftUIThemeManager: ObservableObject {

    public static let `shared` = SwiftUIThemeManager()
    @Published public var theme = AppTheme.light
    
    public init() {}
    
    public init(theme: AppTheme) {
        self.theme = theme
    }
}

@available(iOS 14.0.0, *)
public struct ObjectEnvironmentKey: EnvironmentKey {
    public static var defaultValue: SwiftUIThemeManager = SwiftUIThemeManager.shared
}

@available(iOS 14.0.0, *)
public extension EnvironmentValues {
    var manager: SwiftUIThemeManager {
        get { self[ObjectEnvironmentKey.self] }
        set { self[ObjectEnvironmentKey.self] = newValue }
    }
}

@available(iOS 14.0.0, *)
public extension View {
    func object(_ value: SwiftUIThemeManager) -> some View {
        environment(\.manager, value)
    }
}
