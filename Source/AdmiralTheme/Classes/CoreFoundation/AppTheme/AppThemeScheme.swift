//
//  AppThemeScheme.swift
//  AdmiralTheme
//
//  Created on 06.09.2022.
//

import Combine
import SwiftUI

@available(iOS 14.0.0, *)
/// App theme scheme interface.
public protocol AppThemeScheme {
    init(theme: AppTheme)
}
