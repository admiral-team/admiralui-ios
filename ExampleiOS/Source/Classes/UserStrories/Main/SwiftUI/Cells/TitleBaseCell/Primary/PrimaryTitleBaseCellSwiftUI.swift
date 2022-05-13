//
//  PrimaryTitleBaseCellSwiftUI.swift
//  ExampleiOS
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct PrimaryTitleBaseCellSwiftUI: View {

    // MARK: - Private properties

    @StateObject private var viewModel = PrimaryTitleBaseCellViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ListCell(
                            centerView: { TitleWithImageListView(
                                title: "Title",
                                image: Image(uiImage: Asset.arrowDown.image),
                                renderingMode: .template)
                            },
                            trailingView: { ButtonListView(text: "Button", action: {}) })
                            .disabled(viewModel.isEnabledControlsState != 0)
                    }
                }
            }
        }
    }
}
