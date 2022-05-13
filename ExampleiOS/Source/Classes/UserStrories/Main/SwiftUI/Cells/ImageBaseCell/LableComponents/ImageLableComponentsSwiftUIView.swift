//
//  ImageLableComponentsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ImageLableComponentsSwiftUIView: View {

    // MARK: - Type Alias

    typealias CellItems = ImageLabelComponentsSwiftUIViewModel.ImageLabelItem

    // MARK: - Private properties

    @StateObject private var viewModel = ImageLabelComponentsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0.0) {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                    .padding()
                ScrollView {
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
            leadingView: { buildLeadingView(item: item.type) },
            centerView: { TitleListView(title: item.title) },
            trailingView: { ArrowListView() },
            isSelected:
                Binding(
                    get: { viewModel.selectedIndex == index },
                    set: { _, _ in viewModel.selectedIndex = viewModel.selectedIndex == index ? nil : index }
                ))
            .disabled(viewModel.isEnabledControlsState != 0)
    }

    @ViewBuilder
    private func buildLeadingView(item: CellItems.CellTypeList) -> some View {
        switch item {
        case .imageCardListView(let image):
            ImageCardListView(cardImage: image)
        case .imageListView(let image):
            ImageListView(image: image)
        case .imageNameListView(let title):
            ImageNameListView(text: title)
        case .imageBackgroundListView(let image):
            ImageBackgroundListView(image: image, renderingMode: .template)
        }
    }
    
}
