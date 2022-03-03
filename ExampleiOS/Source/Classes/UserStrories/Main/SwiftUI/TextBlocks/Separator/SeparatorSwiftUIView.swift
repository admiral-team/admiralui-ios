//
//  PaddingView.swift
//  ExampleiOS
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SeparatorSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Padding") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: LayoutGrid.tripleModule) {
                    HStack(spacing: 0.0) {
                        Text("Long")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    SeparatorView(paddingStyle: .long)
                    
                    HStack(spacing: 0.0) {
                        Text("Short")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding()
                    
                    SeparatorView(paddingStyle: .short)
                                
                    SeparatorView(paddingStyle: .empty)
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
