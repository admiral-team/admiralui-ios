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
struct SecondaryInputNumberView: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel: SecondaryInputViewModel = .init()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Body

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                  Spacer()
                }
                StandardTab(
                    items: ["Default", "Disabled"],
                    selection: $viewModel.isEnabledControlsState
                )
                Spacer()
                    .frame(height: LayoutGrid.tripleModule)
                VStack(spacing: LayoutGrid.doubleModule * 2) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 22) {
                            Text(viewModel.items[index].title)
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .padding(.vertical, LayoutGrid.module)
                            InputNumber(
                                titleText: .constant("Optional value"),
                                value: Binding<Double>(
                                    get: { viewModel.items[index].value },
                                    set: { viewModel.items[index].value = $0 }
                                ),
                                minimumValue: .constant(0.0),
                                maximumValue: .constant(viewModel.items[index].maximumValue),
                                style: .secondary
                            )
                            .disabled(viewModel.isEnabledControlsState != 0)
                        }
                    }
                }
                Spacer()
                    .frame(height: LayoutGrid.doubleModule * 2)
            }
            .padding()
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}
