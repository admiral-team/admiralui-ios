//
//  ToolBarSwiftUIView.swift
//  ExampleiOS
//
//  Created on 31.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ToolBarSwiftUIView: View {
    
    // MARK: - Private Properties

    @StateObject private var viewModel = ToolBarSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            VStack {
                InputNumber(
                    titleText: .constant("Количество пунктов"),
                    value: $viewModel.startValue,
                    minimumValue: .constant(1.0),
                    maximumValue: .constant(4.0))
                    .onChange(of: viewModel.startValue, perform: { value in
                        let sliceItems = Array(viewModel.items[0...(Int(value) - 1)])
                        viewModel.sliceItemArray = sliceItems
                        viewModel.toolbarType = viewModel.sliceItemArray.count > 1 ? .vertical : .horizontal
                    })
                    .padding(LayoutGrid.doubleModule)
                Spacer().frame(height: 16.0)
                ToolBar(
                    items: $viewModel.sliceItemArray,
                    type: $viewModel.toolbarType,
                    selectedIndex: $viewModel.selectedIndex,
                    onTap: { index in
                        print(index)
                    })
                Spacer()
            }
        }
    }
    
}
