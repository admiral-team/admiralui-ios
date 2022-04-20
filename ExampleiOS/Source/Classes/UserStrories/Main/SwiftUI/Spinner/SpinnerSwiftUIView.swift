//
//  SpinnerSwiftUIView.swift
//  ExampleiOS
//
//  Created on 12.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SpinnerSwiftUIView: View {

    // MARK: - Private properties

    @StateObject private var viewModel = SpinnerSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                StandardTab(items: viewModel.tabItems, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                HStack {
                    Spacer()
                    ActivityIndicator(
                        style: .contrast,
                        size: ActivityIndicator.Size(rawValue: viewModel.isEnabledControlsState) ?? .medium
                    )
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }

}
