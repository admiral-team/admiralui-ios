//
//  CircularPageControlSwiftUI.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CircularPageCOntrolSwiftUI: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = CircularPageControlSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: LayoutGrid.tripleModule * 3) {
                    VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                        VStack(alignment: .leading) {
                            OutlineSliderTab(
                                items: viewModel.items,
                                selection: $viewModel.totalPages,
                                offset: .constant(LayoutGrid.doubleModule),
                                onTapAction: {
                                    viewModel.step = 0
                                }
                            )
                                .disabled(viewModel.isEnabledControlsState != 0)
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        SwiftUI.Button(action: {}, label: {})
                            .buttonStyle(
                                CirclePageControlStyle(
                                    step: $viewModel.step,
                                    totalPages: viewModel.totalPages + 1,
                                    style: .default
                                )
                            )
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }

}
