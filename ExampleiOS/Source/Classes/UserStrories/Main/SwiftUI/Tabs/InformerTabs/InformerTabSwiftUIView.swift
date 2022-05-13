//
//  InformerTabSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InformerTabSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = InformerTabSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Spacer()
                }
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                    .padding(.horizontal, LayoutGrid.doubleModule)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading, spacing: LayoutGrid.module * 3) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
                            Text(viewModel.items[index].text)
                                .padding(.horizontal, LayoutGrid.doubleModule)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                                .font(scheme.textFont.swiftUIFont)
                            VStack(alignment: .leading) {
                                InformerTab(
                                    items: viewModel.items[index].items,
                                    customView: AnyView(InfoSwiftUIView(
                                        title: .constant(viewModel.items[index].title),
                                        subtitle: .constant(viewModel.items[index].subtitle),
                                        description: .constant(viewModel.items[index].description))),
                                    selection: $viewModel.items[index].selection,
                                    offsetSegment: .constant(16.0))
                                    .disabled(viewModel.isEnabledControlsState != 0)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
}
