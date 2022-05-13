//
//  OutlineSliderTabSwiftUITab.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct OutlineSliderTabSwiftUITab: View {
    
    // MARK: - Private Properties

    @StateObject private var viewModel = OutlineSliderTabSwiftUIViewModel()
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
                                OutlineSliderTab(
                                    items: viewModel.items[index].items,
                                    selection: $viewModel.items[index].selection,
                                    offset: .constant(16.0)
                                )
                                .disabled(viewModel.isEnabledControlsState != 0)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
