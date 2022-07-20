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
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 16.0)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 16.0) {
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
                            selection: $isTwoItemControlsState
                        )
                        .disabled(isEnabledControlsState != 0)
                    }
                    Spacer()
                        .frame(height: 24.0)
                    VStack(alignment: .leading, spacing: 16.0) {
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
                                selection: $isThreeItemControlsState
                            )
                            .disabled(isEnabledControlsState != 0)
                    }
                    Spacer()
                        .frame(height: 24.0)
                    VStack(alignment: .leading, spacing: 16.0) {
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
