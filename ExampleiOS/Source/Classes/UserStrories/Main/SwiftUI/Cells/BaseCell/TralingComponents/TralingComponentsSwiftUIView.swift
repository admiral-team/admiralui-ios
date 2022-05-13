//
//  TralingComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 18.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TralingComponentsSwiftUIView: View {
    
    // MARK: - Type Alias

    typealias TextBaseCellItem = TrailingComponentsSwiftUIViewModel.TrailingComponentItem

    // MARK: - Private Properties

    @StateObject private var viewModel = TrailingComponentsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        buildItem(item: viewModel.items[index], scheme: scheme, index: index)
                    }
                }
                .disabled(viewModel.isEnabledControlsState != 0)
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(item: TextBaseCellItem, scheme: SwiftUIContentViewScheme, index: Int) -> some View {
        ListCell(
            centerView: {
                switch item.type {
                case .tagControl:
                    TitleListView(title: "Title").fixedSize()
                default:
                    TitleListView(title: "Title")
                }
            },
            trailingView: { buildTrailingView(item: item.type) },
            isSelected:
                Binding(
                    get: { viewModel.selectedIndex == index },
                    set: { _, _ in viewModel.selectedIndex = viewModel.selectedIndex == index ? nil : index }
                ),
            centerLayoutPriority: item.type == .tagControl ? 0.0 : 1.0,
            trailingLayoutPriority: item.type == .tagControl ? 1.0 : 0.0
        )
        .disabled(viewModel.isEnabledControlsState != 0)
    }

    @ViewBuilder
    private func buildTrailingView(item: TextBaseCellItem.CellTypeList) -> some View {
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
        case .badgeArrowListView:
            BadgeArrowListView(badgeStyle: .default, text: "99+")
        case .subtitleImageArrowListView:
            SubtitleImageArrowListView(subtitle: "19.01.2010", image: Image(uiImage: Asset.Tabs.mirLogo.image))
        case .tagControl:
            TagControl(
                title: "Text text text text text",
                tagStyle: .default,
                tapTagControl: {}
            )
        }
    }
    
}
