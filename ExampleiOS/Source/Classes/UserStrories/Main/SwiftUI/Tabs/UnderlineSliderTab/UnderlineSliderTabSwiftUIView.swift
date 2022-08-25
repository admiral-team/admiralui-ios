//
//  UnderlineSliderTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct UnderlineSliderTabSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isStaticControlsState: Int = 0
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    private let underlineTabItems = [UnderlineTabItem(title: "One", badgeStyle: .default),
                                     UnderlineTabItem(title: "Two", badgeStyle: .default),
                                     UnderlineTabItem(title: "Three", badgeStyle: .additional),
                                     UnderlineTabItem(title: "Four", badgeStyle: nil)]
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Underline Slider Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Three controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: ["One", "Two", "Three"],
                                selection: $isTwoItemControlsState,
                                offset: .constant(16.0)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)

                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Slider controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"],
                                selection: $isThreeItemControlsState,
                                offset: .constant(16.0)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)

                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Notifications")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: underlineTabItems,
                                selection: $isStaticControlsState,
                                offset: .constant(16.0)
                            )
                            .disabled(isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
