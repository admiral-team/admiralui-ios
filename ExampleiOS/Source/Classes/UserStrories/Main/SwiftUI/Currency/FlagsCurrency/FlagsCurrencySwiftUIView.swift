//
//  FlagsCurrencySwiftUIView.swift
//  ExampleiOS
//
//  Created on 02.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct FlagsCurrencySwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Flags") {
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
                        currencyText: "Валюта",
                        buyText: "Купить",
                        sellText: "Продать")
                        .frame(height: LayoutGrid.halfModule * 14)
                    CurrencyView(currencyText: "USD", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.usa.image))
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "EUR", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.european.image))
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "GBP", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.britain.image))
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "CNY", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.china.image))
                        .frame(height: LayoutGrid.halfModule * 10)
                })
                .padding(LayoutGrid.doubleModule)
                Spacer()
            }
        }
    }
    
}
