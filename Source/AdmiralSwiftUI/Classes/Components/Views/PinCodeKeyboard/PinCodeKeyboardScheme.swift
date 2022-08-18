//
//  PinCodeKeyboardScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PinCodeKeyboardScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of PinCodeKeyboard
    public var backgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }

}
