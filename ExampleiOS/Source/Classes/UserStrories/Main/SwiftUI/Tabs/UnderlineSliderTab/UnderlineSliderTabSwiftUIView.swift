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
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isStaticControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
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
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                    .accessibility(identifier: "SegmentControl")
                    .padding()
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: ["One", "Two", "Three"],
                                selection: $isTwoItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                            .disabled(isEnabledControlsState != 0)
                            .accessibilityIdentifier("UnderlineTabThreeControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)

                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Slider controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"],
                                selection: $isThreeItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                            .disabled(isEnabledControlsState != 0)
                            .accessibilityIdentifier("UnderlineTabSliderControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)

                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Notifications")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: underlineTabItems,
                                selection: $isStaticControlsState,
                                offset: .constant(16.0),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                            .disabled(isEnabledControlsState != 0)
                            .accessibilityIdentifier("UnderlineTabNotifications")
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
