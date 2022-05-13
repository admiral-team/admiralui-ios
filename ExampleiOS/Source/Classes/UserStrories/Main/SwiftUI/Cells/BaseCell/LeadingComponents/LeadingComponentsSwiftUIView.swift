//
//  LeadingComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LeadingComponentsSwiftUIView: View {

    // MARK: - Type Alias

    typealias TextBaseCellItem = LeadinComponentsSwiftUIViewModel.LeadinComponentItem

    // MARK: - Private Properties

    @StateObject private var viewModel = LeadinComponentsSwiftUIViewModel()
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
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(item: TextBaseCellItem, scheme: SwiftUIContentViewScheme, index: Int) -> some View {
        ListCell(
            centerView: { buildCenterView(item: item.type) },
            trailingView: { ArrowListView() },
            isSelected:
                Binding(
                    get: { viewModel.selectedIndex == index },
                    set: { _, _ in viewModel.selectedIndex = viewModel.selectedIndex == index ? nil : index }
                ))
            .disabled(viewModel.isEnabledControlsState != 0)
    }

    @ViewBuilder
    private func buildCenterView(item: TextBaseCellItem.CellTypeList) -> some View {
        switch item {
        case .title:
            TitleListView(title: "Title")
        case .titleSubtitle(let subTitle):
            TitleSubtitleListView(title: "Title", subtitle: subTitle)
        case .subtitle(let subTitle):
            SubtitleTitleListView(title: "Title", subtitle: subTitle)
        case .titleMoreDetail:
            TitleMoreDetailTextMessageListView(
                title: "Title",
                more: "More",
                detaile: "Detail",
                detaileMore: "More",
                subtitle: "Subtitle",
                tagText: "Percent",
                messageText: "Text message",
                infoImage: AdmiralUIResources.AssetSymbol.Service.Outline.info.image)
        case .titleSubtitleButton:
            TitleSubtitleButtonListView(
                title: "Title",
                tagSubtitle: "Subtitle",
                tagText: "Percent",
                subtitle: "Subtitle 2",
                buttonTitle: "Button",
                buttonAction: {})
        }
    }

}
