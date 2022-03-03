//
//  DropDownSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct DropDownSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Accordion") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 0.0) {
                    TitleButtonDropDown(
                        title: "Title",
                        buttonTitle: "Button",
                        buttonAction: {})
                    ButtonDropDown(
                        buttonTitle: "Button",
                                dropDownHeaderType: .down,
                        buttonAction: {})
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
