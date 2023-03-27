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
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
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
                                    text: "One",
                                    accessibilityId: "TwoControlsFirst"
                                ),
                                IconTabModel(
                                    image: Image(uiImage: Asset.IconTabs.card.image),
                                    text: "Two",
                                    accessibilityId: "TwoControlsSecond"
                                )
                            ],
                            selection: $isTwoItemControlsState
                        )
                        .disabled(isEnabledControlsState != 0)
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
                                        text: "One",
                                        accessibilityId: "ThreeControlsFirst"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.card.image),
                                        text: "Two",
                                        accessibilityId: "ThreeControlsSecond"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Three",
                                        accessibilityId: "ThreeControlsThird"
                                    )
                                ],
                                selection: $isThreeItemControlsState
                            )
                            .disabled(isEnabledControlsState != 0)
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
                                        text: "One",
                                        accessibilityId: "EmbeddedInScrollViewFirst"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.card.image),
                                        text: "Two",
                                        accessibilityId: "EmbeddedInScrollViewSecond"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Three",
                                        accessibilityId: "EmbeddedInScrollViewThird"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Four",
                                        accessibilityId: "EmbeddedInScrollViewFourth"
                                    ),
                                    IconTabModel(
                                        image: Image(uiImage: Asset.IconTabs.account.image),
                                        text: "Five",
                                        accessibilityId: "EmbeddedInScrollViewFifth"
                                    )
                                ],
                                selection: $isFourItemControlsState
                            )
                            .disabled(isEnabledControlsState != 0)
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
