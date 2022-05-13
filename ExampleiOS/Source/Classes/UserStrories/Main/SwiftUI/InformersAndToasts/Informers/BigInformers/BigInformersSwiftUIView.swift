//
//  BigInformersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 18.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BigInformersSwiftUIView: View {

    // MARK: - Contants

    private enum Constants {
        static let titleText: String = "Headline"
        static let subtitleText: String = "At breakpoint boundaries, mini units divide the screen into a fixed master."
        static let linkText: String = "Link text"
        static let labelHorizontalPadding: CGFloat = 16.0
    }

    // MARK: - Private Properties

    @StateObject private var viewModel = BigInformersSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                    .padding()
                Spacer()
                    .frame(height: 36.0)
                VStack(alignment: .leading) {
                    ForEach(viewModel.items, id: \.id) { item in
                        buildItem(scheme: scheme, item: item)
                    }
                }
                Spacer()
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(scheme: SwiftUIContentViewScheme, item: BigInformersSwiftUIViewModel.BigInformerItem) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
            Text(item.title)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
                .padding(.horizontal, Constants.labelHorizontalPadding)
            VStack(alignment: .leading) {
                BigInformer(
                    title: Constants.titleText,
                    subtitle: Constants.subtitleText,
                    link: Constants.linkText,
                    informerStyle: item.style,
                    onDetail: { print("link tapped") }
                )
                .disabled(viewModel.isEnabledControlsState != 0)
                Spacer()
            }
        }
        Spacer()
            .frame(height: LayoutGrid.quadrupleModule)
    }
    
}
