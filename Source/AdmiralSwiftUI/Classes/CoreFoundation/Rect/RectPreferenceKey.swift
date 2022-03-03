//
//  RectPreferenceKey.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//

import SwiftUI

struct RectPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
