//
//  IconTabs.swift
//  ExampleiOS
//
//  Created on 17.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct IconTabsSwiftUI: View {
    
    enum Constants {
        static let tabFormatAccessibilityValue = "%@. Page %i of %i"
    }

    @State private var isEnabledControlsState: Int = 0
    @State private var isTwoItemControlsState: Int = 0
    @State private var isThreeItemControlsState: Int = 0
    @State private var isFourItemControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Icon Tabs") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"],
                            selection: $isEnabledControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue)
                    .accessibility(identifier: "SegmentControl")
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Two controls")
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .font(scheme.textFont.swiftUIFont)
                        IconTab(
                            models: [
                                IconTabModel(
                                    image: Image(uiImage: Asset.IconTabs.mobile.image),
                                    text: "One"
                                ),
                                IconTabModel(
                                    image: Image(uiImage: Asset.IconTabs.card.image),
                                    text: "Two"
                                )
                            ],
                            selection: $isTwoItemControlsState,
                            tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                        )
                        .disabled(isEnabledControlsState != 0)
                        .accessibilityIdentifier("IconTabTwoControls")
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Three controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            IconTab(
                                models: [
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.mobile.image),
                                        text: "One"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.card.image),
                                        text: "Two"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Three"
                                    )
                                ],
                                selection: $isThreeItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                            .disabled(isEnabledControlsState != 0)
                            .accessibilityIdentifier("IconTabThreeControls")
                    }
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        Text("Embedded in ScrollView")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        ScrollView(.horizontal) {
                            IconTab(
                                models: [
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.mobile.image),
                                        text: "One"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.card.image),
                                        text: "Two"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Three"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Four"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Five"
                                    )
                                ],
                                selection: $isFourItemControlsState,
                                tabAccessibilityValueFormatString: Constants.tabFormatAccessibilityValue
                            )
                            .disabled(isEnabledControlsState != 0)
                            .accessibilityIdentifier("IconTabEmbeddedInScrollView")
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
