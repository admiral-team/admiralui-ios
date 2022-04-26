//
//  PrimaryTitleBaseCellSwiftUI.swift
//  ExampleiOS
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct PrimaryTitleBaseCellSwiftUI: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Primary") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ListCell(
                        centerView: { TitleWithImageListView(
                            title: "Title",
                            image: Image(uiImage: Asset.arrowDown.image),
                            renderingMode: .template) 
                        },
                        trailingView: { ButtonListView(text: "Button", action: {}) })
                        .disabled(isEnabledControlsState != 0)
                }
            }
        }
    }
    
}
