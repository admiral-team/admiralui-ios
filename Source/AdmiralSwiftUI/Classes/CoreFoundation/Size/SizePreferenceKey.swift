//
//  SizePreferenceKey.swift
//  AdmiralSwiftUI
//
//  Created on 19.04.2021.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let next = nextValue()
        value.width = value.width.rounded()
        if next == .zero {
            return
        }
        value = next
    }
}
