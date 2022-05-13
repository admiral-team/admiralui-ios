//
//  LogoTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 21.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LogoTabSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = LogoTabsSwiftUIViewModel()
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
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.halfModule * 6) {
                            Text(viewModel.items[index].title)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            VStack(alignment: .leading) {
                                LogoTab(
                                    images: viewModel.items[index].items,
                                    selection: $viewModel.items[index].selection
                                )
                                .disabled(viewModel.isEnabledControlsState != 0)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
    
}
