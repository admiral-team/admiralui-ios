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

    // MARK: - Private Properties

    @StateObject private var viewModel = IconTabsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                  Spacer()
                }
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.tripleModule)
                VStack(alignment: .leading, spacing: LayoutGrid.module * 3) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                            Text(viewModel.items[index].title)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            switch viewModel.items[index].type {
                            case .default:
                                IconTab(
                                    models: viewModel.items[index].items,
                                    selection: $viewModel.items[index].selection
                                )
                                .disabled(viewModel.isEnabledControlsState != 0)
                            case .scroll:
                                ScrollView(.horizontal, showsIndicators: false) {
                                    IconTab(
                                        models: viewModel.items[index].items,
                                        selection: $viewModel.items[index].selection
                                    )
                                    .disabled(viewModel.isEnabledControlsState != 0)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}
