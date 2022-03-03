//
//  ThemeSwitchViewRepresentable.swift
//  ExampleiOS
//
//  Created on 08.07.2021.
//

import AdmiralTheme
import AdmiralSwiftUI
import SwiftUI

@available(iOS 14.0, *)
final class ThemeSwitchViewRepresentable: UIViewRepresentable {

    @Binding var sizeView: CGSize
    @ObservedObject var manager = SwiftUIThemeManager.shared
    
    init(sizeView: Binding<CGSize>) {
        self._sizeView = sizeView
    }

    func makeUIView(context: Context) -> ThemeSwitchView {
        let themeSwitchView = ThemeSwitchView()
        themeSwitchView.apply(theme: manager.theme)
        return themeSwitchView
    }

    func updateUIView(_ uiView: ThemeSwitchView, context: Context) {
        uiView.apply(theme: manager.theme)
        uiView.sizeChange = { [weak self] size in
            self?.sizeView = size
        }
    }
    
}
