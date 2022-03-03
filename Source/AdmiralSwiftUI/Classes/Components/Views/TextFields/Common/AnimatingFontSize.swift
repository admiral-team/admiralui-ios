//
//  AnimatingFontSize.swift
//  AdmiralSwiftUI
//
//  Created on 01.10.2021.
//

import SwiftUI

@available(iOS 14.0, *)
struct AnimatingFontSize: AnimatableModifier {
    
    var fontSize: CGFloat
    var fontName: String

    var animatableData: CGFloat {
        get { fontSize }
        set { fontSize = newValue }
    }

    func body(content: Self.Content) -> some View {
        content
            .font(Font.custom(fontName, fixedSize: fontSize))
    }
}
