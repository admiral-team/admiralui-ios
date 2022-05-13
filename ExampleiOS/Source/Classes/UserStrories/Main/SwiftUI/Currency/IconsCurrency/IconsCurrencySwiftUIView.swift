//
//  IconsCurrencySwiftUIView.swift
//  ExampleiOS
//
//  Created on 02.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct IconsCurrencySwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = IconsCurrencySwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: LayoutGrid.doubleModule * 3)
                ListCell(
                    centerView: { TitleWithImageListView(
                        title: "Курсы валют",
                        image: Image(uiImage: Asset.arrowDown.image),
                        renderingMode: .template)
                    },
                    trailingView: { ButtonListView(text: "Button", action: {}) })
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: 0.0, content: {
                    CurrencyHeaderView(
                        currencyText: viewModel.header.currencyText,
                        buyText: viewModel.header.buyText,
                        sellText: viewModel.header.sellText,
                        isTextSpacingEnabled: viewModel.header.isTextSpacingEnabled
                    )
                    .frame(height: LayoutGrid.halfModule * 14)
                    ForEach(viewModel.items, id: \.id) { item in
                        CurrencyView(
                            currencyText: item.currencyText,
                            buyText: item.buyText,
                            sellText: item.sellText,
                            firstCellType: item.firstCellType,
                            secondCellType: item.secondCellType
                        )
                        .frame(height: LayoutGrid.halfModule * 10)
                    }
                })
                .padding(LayoutGrid.doubleModule)
                Spacer()
            }
        }
    }
    
}
