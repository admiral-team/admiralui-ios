//
//  RectAwareViewModifier.swift
//  AdmiralSwiftUI
//
//  Created on 23.04.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
struct BackgroundRectGeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            return Color
                .clear
                .preference(key: RectPreferenceKey.self, value: geometry.frame(in: .global))
        }
    }
}

@available(iOS 14.0.0, *)
struct RectAwareViewModifier: ViewModifier {

    @Binding private var viewRect: CGRect

    init(viewRect: Binding<CGRect>) {
        self._viewRect = viewRect
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            return content
                .background(BackgroundRectGeometryReader())
                .onPreferenceChange(
                    RectPreferenceKey.self,
                    perform: {
                        if self.viewRect != $0 {
                            self.viewRect = $0
                        }
                    }
                )
                .eraseToAnyView()
        } else {
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
}
