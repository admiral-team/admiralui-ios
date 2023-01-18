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
    
    @State private var isEnabledControlsState: Int = 0
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Accordion") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 16.0)
                VStack(spacing: 0.0) {
                    TitleButtonDropDown(
                        title: "Title",
                        buttonTitle: "Button",
                        buttonAccesibilityId: "TitleButtonDropDown",
                        buttonAction: {})
                        .disabled(isEnabledControlsState != 0)
                    ButtonDropDown(
                        buttonTitle: "Button",
                        dropDownHeaderType: .down,
                        buttonAccesibilityId: "ButtonDropDown",
                        buttonAction: {})
                    .disabled(isEnabledControlsState != 0)
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
