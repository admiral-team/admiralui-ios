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
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Icons") {
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
                    trailingView: { ButtonListView(text: "Button",
                                                   accesibilityId: "IconsButton",
                                                   action: {}) 
                    })
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: 0.0, content: {
                    CurrencyHeaderView(
                        currencyText: "Валюта",
                        buyText: "Купить",
                        sellText: "Продать",
                        isTextSpacingEnabled: true
                    )
                    .frame(height: LayoutGrid.halfModule * 14)
                    CurrencyView(currencyText: "USD", buyText: "8,65", sellText: "8,88", firstCellType: .arrowUp, secondCellType: .arrowUp)
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "EUR", buyText: "168,65", sellText: "167,88", firstCellType: .arrowUp, secondCellType: .arrowUp)
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "GBP", buyText: "18,65", sellText: "18,88", firstCellType: .arrowUp, secondCellType: .arrowUp)
                        .frame(height: LayoutGrid.halfModule * 10)
                    CurrencyView(currencyText: "CNY", buyText: "0,65", sellText: "0,88", firstCellType: .arrowUp, secondCellType: .arrowUp)
                        .frame(height: LayoutGrid.halfModule * 10)
                })
                .padding(LayoutGrid.doubleModule)
                Spacer()
            }
        }
    }
    
}
