//
//  ScrollOffsetPreferenceKey.swift
//  AdmiralSwiftUI
//
//  Created on 24.04.2021.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
