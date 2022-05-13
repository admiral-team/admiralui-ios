//
//  UnderlineSliderTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct UnderlineSliderTabSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = UnderLineSliderTabsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                    .padding()
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: LayoutGrid.module * 3) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                            Text(viewModel.items[index].title)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                                .padding()
                            VStack(alignment: .leading) {
                                UnderlineTab(
                                    items: viewModel.items[index].items,
                                    selection: $viewModel.items[index].selection,
                                    offset: .constant(16.0)
                                )
                                .disabled(viewModel.isEnabledControlsState != 0)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 24.0)
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        Text("Static Controls")
                            .font(scheme.textFont.swiftUIFont)
                            .foregroundColor(scheme.textColor.swiftUIColor)
                            .padding()
                        VStack(alignment: .leading) {
                            UnderlineTab(
                                items: ["One", "Two", "Three", "Four"],
                                selection: $viewModel.isStaticControlsState,
                                isStaticTabs: .constant(true)
                            )
                            .disabled(viewModel.isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
