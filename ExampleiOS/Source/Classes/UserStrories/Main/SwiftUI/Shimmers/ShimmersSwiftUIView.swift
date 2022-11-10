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
                LazyVStack(alignment: .leading, spacing: 0) {
                    ListCell(leadingView: {
                        LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                    }, centerView: {
                        TitleMoreDetailTextMessageListView(
                            title: "Зарплатная карта",
                            detaile: "66 800.00 ₽")
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                            .shimmer(isActive: true)
                    })
                    ListCell(leadingView: {
                        LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                            .shimmer(isActive: true)
                    }, centerView: {
                        VStack(alignment: .leading, spacing: LayoutGrid.halfModule) {
                            TitleMoreDetailTextMessageListView(
                                title: "Зарплатная карта")
                            Rectangle()
                                .cornerRadius(LayoutGrid.halfModule)
                                .shimmer(isActive: true)
                                .frame(width: 108, height: 16.0)
                        }
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                    })
                    ListCell(leadingView: {
                        LeadingCardListView(cardImage: Image(uiImage: Asset.Card.visa.image))
                    }, centerView: {
                        TitleMoreDetailTextMessageListView(
                            title: "Зарплатная карта",
                            detaile: "66 800.00 ₽")
                    }, trailingView: {
                        IconListView(image: Image(uiImage: Asset.Card.visaLabel.image))
                            .cornerRadius(LayoutGrid.halfModule)
                    })
                    Rectangle()
                        .cornerRadius(LayoutGrid.halfModule)
                        .shimmer(isActive: true)
                        .frame(height: 64.0)
                        .padding([.horizontal], LayoutGrid.tripleModule)
                    Spacer()
                }
            }
        }
        .environmentObject(ShimmerConfig(
                            bgColor: scheme.backgroundShimmerColor.swiftUIColor,
                            shimmerColor: scheme.shimmerColor.swiftUIColor))
    }
}
