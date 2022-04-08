//
//  ThemeSwitchSwiftUIView.swift
//  ExampleiOS
//
//  Created on 09.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ThemeSwitchSwiftUIView: View {
    
    @State var sizeView: CGSize = CGSize(width: 56.0, height: 56.0)
    
    private let storage = AppThemeUserDefaultsStorage()

    public var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ThemeSwitchViewRepresentable(sizeView: $sizeView)
                        .frame(width: sizeView.width,
                               height: sizeView.height)
                }
            }
            .frame(width: geo.size.width)
        }
        .padding(.horizontal, LayoutGrid.module)
        .padding(.vertical, LayoutGrid.doubleModule)
    }

}
