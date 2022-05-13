//
//  SecondaryTitleBaseCellSwiftUI.swift
//  ExampleiOS
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SecondaryTitleBaseCellSwiftUI: View {
    
    // MARK: - Private properties

    @StateObject private var viewModel = SecondaryTitleBaseCellSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ListCell(
                        centerView: { SecondaryTitleListView(title: "Title") },
                        trailingView: { ButtonWithArrowListView(text: "Button", action: {}) })
                        .disabled(viewModel.isEnabledControlsState != 0)
                }
            }
        }
    }
    
}
