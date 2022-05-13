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
    
    // MARK: - Private Properties

    @StateObject private var viewModel = InputNumberSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: viewModel.tabItems, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                InputNumber(
                    titleText: .constant("Optional value"),
                    value: $viewModel.startValue,
                    minimumValue: .constant(0.0),
                    maximumValue: .constant(20000))
                    .disabled(viewModel.isEnabledControlsState != 0)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Number")
    }
    
}
