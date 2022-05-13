//
//  TextBaseCellSwiftUIView.swift
//  ExampleiOS
//
//  Created on 29.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TextBaseCellSwiftUIView: View {

    // MARK: - Type Alias

    typealias TextBaseCellItem = TextBaseCellSwiftUIViewModel.TextBaseCellItem

    // MARK: - Private Properties

    @StateObject private var viewModel = TextBaseCellSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                    .padding(LayoutGrid.doubleModule)
                LazyVStack(alignment: .leading, spacing: LayoutGrid.halfModule * 9) {
                    ForEach(viewModel.items, id: \.id) { item in
                        buildItem(item: item, scheme: scheme)
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(item: TextBaseCellItem, scheme: SwiftUIContentViewScheme) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
            Text(item.title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .padding(LayoutGrid.doubleModule)
            switch item.type {
            case .icon(let image):
                ListCell(
                    centerView: { TitleListView(title: item.text) },
                    trailingView: { IconListView(image: image, renderingMode: .original) })
                    .disabled(viewModel.isEnabledControlsState != 0)
            case .text:
                ListCell(
                    centerView: { TitleListView(title: item.text) })
                    .disabled(viewModel.isEnabledControlsState != 0)
            }
        }
    }

}
