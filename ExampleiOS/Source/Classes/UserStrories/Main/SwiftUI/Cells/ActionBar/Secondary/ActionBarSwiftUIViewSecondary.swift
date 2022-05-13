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

    @StateObject private var viewModel = ActionBarSwiftUISecondaryViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
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
                                    get: { viewModel.selectedIndex == 0 },
                                    set: { _, _ in viewModel.selectedIndex = viewModel.selectedIndex == 0 ? nil : 0 }
                                )
                        ),
                        actions: viewModel.actions,
                        style: .secondary
                    )
                    .disabled(viewModel.isEnabledControlsState != 0)
                }
            }
        }
    }

}
