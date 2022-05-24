//
//  ActionBarSwiftUIView.swift
//  ExampleiOS
//
//  Created on 24.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ActionBarSwiftUIView: View {

    // MARK: - Private properties

    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Actionbar") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                    HStack {
                        Text("Default")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding(.horizontal, LayoutGrid.doubleModule)
                    ActionCellView(
                        cellView: ListCell(
                            leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image) ) },
                            centerView: {
                                TitleMoreDetailTextMessageListView(title: "Card", detaile: "50 000.00 ₽")
                            },
                            trailingView: {
                                SubtitleWithImageListView(
                                    subtitle: "Swipe",
                                    image: AdmiralUIResources.AssetSymbol.System.Outline.arrowLeft.image,
                                    renderingMode: .template
                                )
                            },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 0 },
                                    set: { _, _ in self.selectedIndex = selectedIndex == 0 ? nil : 0 }
                                )
                        ),
                        actions: [
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.moreOutline.image),
                                imageStyle: .accent,
                                handler: {}),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowUpOutline.image),
                                imageStyle: .primary,
                                handler: {}),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowDownOutline.image),
                                imageStyle: .primary,
                                handler: {}),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.union.image),
                                imageStyle: .accent,
                                handler: {}),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.closeOutline.image),
                                imageStyle: .error,
                                handler: {})
                        ],
                        style: .default
                    )
                        .disabled(isEnabledControlsState != 0)
                    HStack {
                        Text("Secondary")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                        Spacer()
                    }
                    .padding(.horizontal, LayoutGrid.doubleModule)
                    ActionCellView(
                        cellView: ListCell(
                            leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image) ) },
                            centerView: { TitleMoreDetailTextMessageListView(title: "Card", detaile: "50 000.00 ₽") },
                            trailingView: { SubtitleWithImageListView(
                                subtitle: "Swipe",
                                image: AdmiralUIResources.AssetSymbol.System.Outline.arrowLeft.image,
                                renderingMode: .template)
                            },
                            isSelected:
                                Binding(
                                    get: { self.selectedIndex == 0 },
                                    set: { _, _ in self.selectedIndex = selectedIndex == 0 ? nil : 0 }
                                )
                        ),
                        actions: [
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.mail.image),
                                imageStyle: .accent,
                                style: .secondary,
                                text: "Text",
                                handler: {}
                            ),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.shape.image),
                                imageStyle: .attention,
                                style: .secondary,
                                text: "Text",
                                handler: {}
                            ),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.union.image),
                                imageStyle: .success,
                                style: .secondary,
                                text: "Text",
                                handler: {}
                            )
                        ],
                        style: .secondary
                    )
                    .disabled(isEnabledControlsState != 0)
                }
            }
        }
    }
}
