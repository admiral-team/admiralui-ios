//
//  ActionBarSwiftUITwo.swift
//  ExampleiOS
//
//  Created on 08.02.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ActionBarSwiftUIViewSecondary: View {

    // MARK: - Private properties

    @State private var selectedIndex: Int?
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Actionbar - Type secondary") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
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
                                image: Image(uiImage: Asset.ActionBar.moreOutline.image),
                                imageTintColor: .white,
                                backgroundColor: .red,
                                style: .secondary,
                                text: "Text",
                                handler: {}
                            ),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowUpOutline.image),
                                imageStyle: .success,
                                style: .secondary,
                                text: "Text",
                                handler: {}
                            ),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowDownOutline.image),
                                imageStyle: .accent,
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
