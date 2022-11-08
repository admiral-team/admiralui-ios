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
    @StateObject private var viewModel = InputNumberDefaultViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Default") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                VStack(spacing: 40) {
                    ForEach(0..<viewModel.items.count, id: \.self) { itemIndex in
                        HStack() {
                            Text(viewModel.items[itemIndex].title)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            Spacer()
                        }
                        InputNumber(
                            titleText: .constant("Optional value"),
                            value: Binding<Double>(
                                get: { return viewModel.items[itemIndex].currentValue },
                                set: {
                                    viewModel.items[itemIndex].currentValue = $0
                                }
                            ),
                            minimumValue: .constant(viewModel.items[itemIndex].minimunValue),
                            maximumValue: .constant(viewModel.items[itemIndex].maximumValue),
                            style: .default,
                            placeholder: "0",
                            formatter: BlocFormatter(format: { text in
                                if (text ?? "").count > 5 { return "20000" }
                                return text
                            })
                        )
                        .disabled(isEnabledControlsState != 0)
                    }
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule * 2)
            }
            .padding()
        }
        .navigationTitle("Number")
    }

}
