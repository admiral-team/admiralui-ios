//
//  StandardTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 20.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct StandardTabSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Standard Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 54.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Two Controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two"], selection: $isTwoItemControlsState)
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 54.0)
                    
                    
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three Controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two", "Three"], selection: $isThreeItemControlsState)
                                .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
}
