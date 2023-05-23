//
//  ActionBarSwiftUIView.swift
//  ExampleiOS
//
//  Created on 24.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSymbols
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
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
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
                            leadingView: { LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image) ) },
                            centerView: {
                                TitleMoreDetailTextMessageListView(title: "Card", detaile: "50 000.00 ₽")
                            },
                            trailingView: {
                                SubtitleWithImageListView(
                                    subtitle: "Swipe",
                                    image: AdmiralSymbols.AssetSymbol.System.Outline.arrowLeft.swiftUIImage,
                                    renderingMode: .template
                                )
                                    .accessibilityElement()
                                    .accessibility(identifier: "DefaultCellSwipe")
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
                                handler: {},
                                accesibilityId: "DefaultFirstAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowUpOutline.image),
                                imageStyle: .primary,
                                handler: {},
                                accesibilityId: "DefaultSecondAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.arrowDownOutline.image),
                                imageStyle: .primary,
                                handler: {},
                                accesibilityId: "DefaultThirdAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.union.image),
                                imageStyle: .accent,
                                handler: {},
                                accesibilityId: "DefaultFourthAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.closeOutline.image),
                                imageStyle: .error,
                                handler: {},
                                accesibilityId: "DefaultFifthAction")
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
                            leadingView: { LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image) ) },
                            centerView: { TitleMoreDetailTextMessageListView(title: "Card", detaile: "50 000.00 ₽") },
                            trailingView: { SubtitleWithImageListView(
                                subtitle: "Swipe",
                                image: AdmiralSymbols.AssetSymbol.System.Outline.arrowLeft.swiftUIImage,
                                renderingMode: .template)
                                    .accessibilityElement()
                                    .accessibility(identifier: "SecondaryCellSwipe")
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
                                handler: {},
                                accesibilityId: "SecondaryFirstAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.union.image),
                                imageStyle: .success,
                                style: .secondary,
                                text: "Text",
                                handler: {},
                                accesibilityId: "SecondarySecondAction"),
                            ActionItemBarAction(
                                image: Image(uiImage: Asset.ActionBar.shape.image),
                                imageStyle: .attention,
                                style: .secondary,
                                text: "Text",
                                handler: {},
                                accesibilityId: "SecondaryThirdAction")
                        ],
                        style: .secondary
                    )
                    .disabled(isEnabledControlsState != 0)
                }
            }
        }
    }
}
