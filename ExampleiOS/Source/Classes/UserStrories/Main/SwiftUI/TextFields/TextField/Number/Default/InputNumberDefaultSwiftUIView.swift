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
struct InputNumberDefaultSwiftUIView: View {

    @State private var isEnabledControlsState: Int = 0
    @State private var startValue: Double = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Default") {
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
                    maximumValue: .constant(20000),
                    style: .default,
                    placeholder: "0",
                    formatter: BlocFormatter(format: { text in
                        if (text ?? "").count > 5 { return "20000" }
                        return text
                    })
                )
                .disabled(isEnabledControlsState != 0)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Default")
    }

}
