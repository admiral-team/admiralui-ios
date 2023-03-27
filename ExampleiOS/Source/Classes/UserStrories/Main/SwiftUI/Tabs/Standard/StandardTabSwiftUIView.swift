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
                StandardTab(items: [StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")],
                            selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 54.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        VStack(alignment: .leading) {
                            StandardTab(items: [
                                StandartTabItem(text: "One", accessibilityId: "TwoControlsFirst"),
                                StandartTabItem(text: "Two", accessibilityId: "TwoControlsSecond")],
                                        selection: $isTwoItemControlsState)
                                .disabled(isEnabledControlsState != 0)
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
                            StandardTab(items: [
                                StandartTabItem(text: "One", accessibilityId: "ThreeControlsFirst"),
                                StandartTabItem(text: "Two", accessibilityId: "ThreeControlsSecond"),
                                StandartTabItem(text: "Three", accessibilityId: "ThreeControlsThird")],
                                        selection: $isThreeItemControlsState)
                                .disabled(isEnabledControlsState != 0)
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
                            StandardTab(items: [
                                StandartTabItem(text: "One", accessibilityId: "FourControlsFirst"),
                                StandartTabItem(text: "Two", accessibilityId: "FourControlsSecond"),
                                StandartTabItem(text: "Three", accessibilityId: "FourControlsThird"),
                                StandartTabItem(text: "Four", accessibilityId: "FourControlsFourth")],
                                        selection: $isFourItemControlsState)
                                .disabled(isEnabledControlsState != 0)
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
                            StandardTab(items: [
                                StandartTabItem(text: "One", accessibilityId: "FiveControlsFirst"),
                                StandartTabItem(text: "Two", accessibilityId: "FiveControlsSecond"),
                                StandartTabItem(text: "Three", accessibilityId: "FiveControlsThird"),
                                StandartTabItem(text: "Four", accessibilityId: "FiveControlsFourth"),
                                StandartTabItem(text: "Five", accessibilityId: "FiveControlsFifth")],
                                        selection: $isFiveItemControlsState)
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
