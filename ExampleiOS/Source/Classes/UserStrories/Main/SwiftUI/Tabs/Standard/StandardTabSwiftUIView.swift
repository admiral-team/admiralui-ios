//
//  StandardTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 20.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct StandardTabSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = StandartTabSwiftUIViewModel()
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
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: 54.0)
                VStack(alignment: .leading, spacing: 54.0) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                            Text(viewModel.items[index].title)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            VStack(alignment: .leading) {
                                StandardTab(items: viewModel.items[index].items, selection: Binding<Int>(
                                    get: { 0 },
                                    set: { viewModel.items[index].selection = $0 }
                                ))
                                .disabled(viewModel.isEnabledControlsState != 0)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
}
