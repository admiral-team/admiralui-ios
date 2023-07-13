//
//  View+AnyView.swift
//  AdmiralSwiftUI
//
//  Created on 19.04.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
