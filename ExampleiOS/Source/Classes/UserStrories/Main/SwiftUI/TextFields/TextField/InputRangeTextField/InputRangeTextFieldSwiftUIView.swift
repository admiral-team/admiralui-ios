//
//  InputRangeTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InputRangeTextFieldSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = InputRangeTextFieldSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                StandardTab(
                    items: viewModel.tabItems,
                    selection: $viewModel.controlsState)
                    .onChange(of: viewModel.controlsState, perform: { [weak viewModel] value in
                        viewModel?.state = TextInputState(rawValue: value) ?? .normal
                    })
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                HStack {
                    Text("Standard")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                InputRangeTextField(
                    $viewModel.text,
                    placeholder: "Placeholder",
                    name: "Optional label",
                    state: $viewModel.state,
                    info: .constant("Additional text"),
                    sliderValue: 100,
                    minValue: 100,
                    maxValue: 1000,
                    isResponder: $viewModel.isResponder
                )
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                HStack {
                    Text("Double")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                DoubleInputRangeTextField(
                    $viewModel.contentFrom,
                    contentTo: $viewModel.contentTo,
                    placeholderFrom: "PlaceholderFrom",
                    placeholderTo: "PlaceholderTo",
                    name: "Optional label",
                    state: $viewModel.state,
                    info: .constant("Additional text"),
                    sliderValueFrom: 100,
                    sliderValueTo: 300,
                    minValue: 100,
                    maxValue: 1000,
                    leadingText: .constant("₽"),
                    trailingText: .constant("₽"),
                    isResponderFrom: $viewModel.isResponderFrom,
                    isResponderTo: $viewModel.isResponderTo
                )
                Spacer()
            }
            .padding()
            .onTapGesture {
                viewModel.isResponder = false
                viewModel.isResponderFrom = false
                viewModel.isResponderTo = false
            }
        }
    }
    
}
