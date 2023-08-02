//
//  InversedScrollView.swift
//  AdmiralCalendarSwiftUI
//
//  Created by on 31.07.2023.
//  
//

import SwiftUI

@available(iOS 14.0, *)
struct InversedScrollView<Content: View>: View {

    // MARK: - Properties

    @Binding var isScrollInversed: Bool
    private var content: Content

    // MARK: - Initiazer

    init(
        isScrollInversed: Binding<Bool>,
        content: () -> Content
    ) {
        self._isScrollInversed = isScrollInversed
        self.content = content()
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            content
                .frame(maxHeight: .infinity)
                .flip(isNeeded: isScrollInversed)
        }
        .flip(isNeeded: isScrollInversed)
    }
}

@available(iOS 14.0, *)
private extension View {
    @ViewBuilder
    func flip(isNeeded: Bool = true) -> some View {
        if !isNeeded { self }
        self
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}
