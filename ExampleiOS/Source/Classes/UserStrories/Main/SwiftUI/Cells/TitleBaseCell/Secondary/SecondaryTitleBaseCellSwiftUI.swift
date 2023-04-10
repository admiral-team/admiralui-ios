//
//  SecondaryTitleBaseCellSwiftUI.swift
//  ExampleiOS
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SecondaryTitleBaseCellSwiftUI: View {
    
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Secondary") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                StandardTab(items: [
                    StandartTabItem(text: "Default", accessibilityId: "SegmentControlDefault"),
                    StandartTabItem(text: "Disabled", accessibilityId: "SegmentControlDisabled")
                ],
                            selection: $isEnabledControlsState)
                    .padding()
                LazyVStack(alignment: .leading) {
                    ListCell(
                        centerView: { SecondaryTitleListView(title: "Title") },
                        trailingView: { ButtonWithArrowListView(text: "Button", action: {}) })
                        .disabled(isEnabledControlsState != 0)
                }
            }
        }
    }
    
}
