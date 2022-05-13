//
//  View+AnyView.swift
//  AdmiralSwiftUI
//
//  Created on 19.04.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
