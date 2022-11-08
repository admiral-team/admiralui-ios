//
//  InputNumberSecondarySwiftUIView.swift
//  ExampleiOS
//
//  Created by on 13.10.2022.
//  
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InputNumberSecondarySwiftUIView: View {

    @State private var isEnabledControlsState: Int = 0
    @State private var startValue: Double = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Secondary") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Number")
    }

}
