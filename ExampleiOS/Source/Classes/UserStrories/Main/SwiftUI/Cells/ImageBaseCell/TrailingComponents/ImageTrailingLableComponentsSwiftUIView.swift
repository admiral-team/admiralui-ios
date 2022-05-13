//
//  ImageTrailingLableComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ImageTrailingLableComponentsSwiftUIView: View {
    
    // MARK: - Type Alias

    typealias CellItems = ImageTrailingLabelComponentsViewModel.TrailingComponentItem

    // MARK: - Private properties

    @StateObject private var viewModel = ImageTrailingLabelComponentsViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        buildItem(item: viewModel.items[index], scheme: scheme, index: index)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(item: CellItems, scheme: SwiftUIContentViewScheme, index: Int) -> some View {
        ListCell(
            leadingView: { ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image)) },
            centerView: { TitleListView(title: "Title") },
            trailingView: { buildTrailingView(item: item.type) },
            isSelected:
                Binding(
                    get: { viewModel.selectedIndex == index },
                    set: { _, _ in viewModel.selectedIndex = viewModel.selectedIndex == index ? nil : index }
                ))
            .disabled(viewModel.isEnabledControlsState != 0)
    }

    @ViewBuilder
    private func buildTrailingView(item: CellItems.CellTypeList) -> some View {
        switch item {
        case .title:
            ArrowListView()
        case .radioButton:
            RadioButtonListView(isControlSelected: $viewModel.isRadioButtonListViewControlSelected)
        case .checkBoxListView:
            CheckBoxListView(isControlSelected: $viewModel.isCheckBoxViewControlSelected)
        case .switchListView:
            SwitchListView(isSwitchSelected: $viewModel.isSwitchSelected)
        case .iconListView:
            IconListView(image: Image(uiImage: Asset.Card.imageCard.image))
        case .cardListView:
            CardListView(image: Image(uiImage: Asset.Card.visa.image))
        case .datePercentListView:
            DatePercentListView(date: "Date", percent: "Text")
        case .imageWithSubtitleListView:
            ImageWithSubtitleListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image))
        case .subtitleWithImageListView:
            SubtitleWithImageListView(subtitle: "Subtitle", image: Image(uiImage: Asset.Tabs.mirLogo.image))
        }
    }
    
}
