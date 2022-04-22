//
//  ShimmersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 25.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ShimmersSwiftUIView: View {
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ShimmersSwiftUIViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Shimmers") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ListCell(leadingView: {
                        ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                            .shimmer(isActive: true)
                    }, centerView: {
                        TitleMoreDetailTextMessageListView(
                            title: "Card",
                            detaile: "50 000.00 ₽")
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                    })
                    ListCell(leadingView: {
                        ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                    }, centerView: {
                        TitleMoreDetailTextMessageListView(
                            title: "Card",
                            detaile: "50 000.00 ₽")
                            .shimmer(isActive: true)
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                    })
                    ListCell(leadingView: {
                        ImageCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                    }, centerView: {
                        TitleMoreDetailTextMessageListView(
                            title: "Card",
                            detaile: "50 000.00 ₽")
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                            .cornerRadius(LayoutGrid.halfModule)
                            .shimmer(isActive: true)
                    })
                    Rectangle()
                        .cornerRadius(LayoutGrid.halfModule)
                        .shimmer(isActive: true)
                        .frame(height: 64.0)
                        .padding()
                    Spacer()
                }
            }
        }
        .environmentObject(ShimmerConfig(
                            bgColor: scheme.backgroundShimmerColor.swiftUIColor,
                            shimmerColor: scheme.shimmerColor.swiftUIColor))
    }
}
