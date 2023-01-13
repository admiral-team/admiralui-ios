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
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @State private var isFiveItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Standard Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                    .accessibility(identifier: "SegmentControl")
                Spacer()
                    .frame(height: 54.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two"],
                                        selection: $isTwoItemControlsState,
                                        tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                                .disabled(isEnabledControlsState != 0)
                                .accessibility(identifier: "StandardTabTwoControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 54.0)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two", "Three"],
                                        selection: $isThreeItemControlsState,
                                        tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                                .disabled(isEnabledControlsState != 0)
                                .accessibility(identifier: "StandardTabThreeControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 54.0)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Four controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two", "Three", "Four"],
                                        selection: $isFourItemControlsState,
                                        tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                                .disabled(isEnabledControlsState != 0)
                                .accessibility(identifier: "StandardTabFourControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: 54.0)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Five controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        VStack(alignment: .leading) {
                            StandardTab(items: ["One", "Two", "Three", "Four", "Five"],
                                        selection: $isFiveItemControlsState,
                                        tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                                .disabled(isEnabledControlsState != 0)
                                .accessibility(identifier: "StandardTabFiveControls")
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
