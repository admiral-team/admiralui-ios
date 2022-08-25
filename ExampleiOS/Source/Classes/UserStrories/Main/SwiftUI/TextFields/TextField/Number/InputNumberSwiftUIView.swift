//
//  SliderTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 13.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InputNumberSwiftUIView: View {
    
    @State private var isEnabledControlsState: Int = 0
    @State private var startValue: Double = 0
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Number") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                InputNumber(
                    titleText: .constant("Optional value"),
                    value: $startValue,
                    minimumValue: .constant(0.0),
                    maximumValue: .constant(20000))
                    .disabled(isEnabledControlsState != 0)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Number")
    }
    
}
