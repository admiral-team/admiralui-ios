//
//  RectAwareViewModifier.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//

import SwiftUI

@available(iOS 14.0, *)
struct RectAwareViewModifier: ViewModifier {

    @Binding private var viewRect: CGRect

    init(viewRect: Binding<CGRect>) {
        self._viewRect = viewRect
    }
    
    func body(content: Content) -> some View {

            return content
                .background(
                    GeometryReader { geometry -> Color in
                        guard self.viewRect != geometry.frame(in: .global) else {
                            return Color.clear
                        }
                        DispatchQueue.main.async {
                            self.viewRect = geometry.frame(in: .global)
                        }
                        return Color.clear
                    }
                )
                .eraseToAnyView()
        }
}
