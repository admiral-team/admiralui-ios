//
//  OutlineSliderTabSwiftUITab.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct OutlineSliderTabSwiftUITab: View {

    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }
    
    // MARK: - Private Properties
    
    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    private let outlineSliderTabItems = [OutlineSliderTabItem(title: "One", badgeStyle: nil),
                                         OutlineSliderTabItem(title: "Two", badgeStyle: nil),
                                         OutlineSliderTabItem(title: "Three", badgeStyle: nil)]

    private let outlineSliderTabNotifications = [
        OutlineSliderTabItem(title: "One", badgeStyle: .default),
        OutlineSliderTabItem(title: "Two", badgeStyle: .default),
        OutlineSliderTabItem(title: "Three", badgeStyle: .additional),
        OutlineSliderTabItem(title: "Four", badgeStyle: nil)
    ]
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Outline Slider Tabs") {
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
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                            .padding()
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: outlineSliderTabItems,
                                selection: $isTwoItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("OutlineSliderTabThreeControls")
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
                            OutlineSliderTab(
                                items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"],
                                selection: $isThreeItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("OutlineSliderTabElevenControls")
                            Spacer()
                        }
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Notifications")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: outlineSliderTabNotifications,
                                selection: $isFourItemControlsState,
                                offset: .constant(LayoutGrid.doubleModule),
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                                .disabled(isEnabledControlsState != 0)
                                .accessibilityIdentifier("OutlineSliderTabNotifications")
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
