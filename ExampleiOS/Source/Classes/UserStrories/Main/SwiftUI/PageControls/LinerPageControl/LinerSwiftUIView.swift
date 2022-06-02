//
//  LinerSwiftUIView.swift
//  ExampleiOS
//
//  Created on 31.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct LinerSwiftUIView: View {
    @State private var selectionItem = 0
    
    var body: some View {
        NavigationContentView(navigationTitle: "Liner") {
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
                    AdmiralUIResources.AssetSymbol.System.Outline.arrowRight.image
                }
            }
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
        }
    }
}
