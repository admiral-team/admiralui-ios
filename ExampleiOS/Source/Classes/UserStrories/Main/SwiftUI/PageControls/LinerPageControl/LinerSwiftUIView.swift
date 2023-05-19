//
//  LinerSwiftUIView.swift
//  ExampleiOS
//
//  Created on 31.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSymbols
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct LinerSwiftUIView: View {
    @State private var selectionItem = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Liner") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                
                VStack(alignment: .center, spacing: LayoutGrid.tripleModule * 3) {
                            OutlineSliderTab(
                                items: ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"],
                                selection: $selectionItem,
                                offset: .constant(LayoutGrid.doubleModule),
                                onTapAction: {}
                            )
                    getLinearPageControll()
                }
            }
        }
    }
    
    private func getLinearPageControll() -> some View {
        VStack(alignment: .center, spacing: LayoutGrid.tripleModule * 3) {
            LinerPageControll(currentPage: $selectionItem, numberOfPages: 11, displayedItems: 5)
            
            SwiftUI.Button {
                selectionItem += 1
            } label: {
                HStack {
                    Text("Next")
                    AdmiralSymbols.AssetSymbol.System.Outline.arrowRight.swiftUIImage
                }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
            .accessibility(identifier: "NextLinerPageControll")
        }
    }
}
