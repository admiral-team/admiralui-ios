//
//  SmallInformersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 24.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SmallInformersSwiftUIView: View {
    
    private enum Constants {
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
        static let titleText: String = "Text Informer"
        static let labelHorizontalPadding: CGFloat = 16.0
    }
    
    // MARK: - Private Properties

    @StateObject private var viewModel = SmallInformersSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
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
    private func buildItem(scheme: SwiftUIContentViewScheme, item: SmallInformersSwiftUIViewModel.SmallInformerItem) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
            Text(item.title)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
                .padding(.horizontal, Constants.labelHorizontalPadding)
            SmallInformerStack {
                SmallInformer(
                    title: item.style == .default ? Constants.description : Constants.titleText,
                    informerStyle: item.style,
                    arrowDirection: item.arrowDirection
                )
                .disabled(viewModel.isEnabledControlsState != 0)
            }
        }
        Spacer()
            .frame(height: LayoutGrid.quadrupleModule)
    }
    
}

@available(iOS 14.0.0, *)
private struct SmallInformerStack<Content: View>: View {

    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer().frame(width: 16.0)
                content()
                Spacer()
            }
        }
    }
}
