//
//  LinkSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LinkSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Link") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 0.0) {
                    LinkView(
                        buttonTitle: "Подробнее на сайте банка",
                        buttonAction: {})
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
