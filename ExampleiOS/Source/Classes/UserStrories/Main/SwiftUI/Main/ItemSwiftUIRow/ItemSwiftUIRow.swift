//
//  ItemSwiftUIRow.swift
//  ExampleiOS
//
//  Created on 15.04.2021.
//

import AdmiralTheme
import AdmiralSymbols
import AdmiralSwiftUI
import SwiftUI

@available(iOS 14.0.0, *)
struct ItemSwiftUIRow: View {
    
    @State private var item: SwiftUIItem
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ItemSwiftUIRowScheme>()
    
    init(item: SwiftUIItem) {
        self._item = .init(initialValue: item)
    }
    
    var body: some View {
        let scheme = schemeProvider.scheme
        HStack {
            item.image
                .foregroundColor(scheme.imageTintColor.swiftUIColor)
                .frame(width: 44.0, height: 44.0)
                .background(
                    RoundedRectangle(cornerRadius: 22.0)
                        .foregroundColor(scheme.imageBackgroundColor.swiftUIColor)
                )
            Spacer()
                .frame(width: 16.0)
            VStack(alignment: .leading, spacing: 4.0) {
                Text(item.title)
                    .font(scheme.titleFont.swiftUIFont)
                    .foregroundColor(scheme.titleColor.swiftUIColor)
                Text(item.subtitle)
                    .font(scheme.subtitleFont.swiftUIFont)
                    .foregroundColor(scheme.subtitleColor.swiftUIColor)
            }
            Spacer()
            AdmiralSymbols.AssetSymbol.System.Outline.chevronRight.swiftUIImage
                .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                .foregroundColor(scheme.arrowImageTintColor.swiftUIColor)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
