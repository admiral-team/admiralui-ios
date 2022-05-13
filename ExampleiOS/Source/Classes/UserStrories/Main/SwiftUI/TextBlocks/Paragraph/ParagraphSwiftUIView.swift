//
//  ParagraphSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ParagraphSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = ParagraphSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                    .padding()
                VStack(spacing: LayoutGrid.quadrupleModule) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        buildItem(scheme: scheme, item: viewModel.items[index])
                    }
                }
                .disabled(viewModel.isEnabledControlsState != 0)
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(
        scheme: SwiftUIContentViewScheme,
        item: ParagraphSwiftUIViewModel.ParagraphStorage
    ) -> some View {
        HStack(spacing: LayoutGrid.quadrupleModule) {
            Text(item.title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            Spacer()
        }
        .padding()
        VStack(spacing: LayoutGrid.doubleModule) {
            ForEach(item.items, id: \.self) { paragraph in
                ParagraphView(
                    title: paragraph.title,
                    paragraphImageType: paragraph.paragraphImageType,
                    trailingImage: paragraph.trailingImage,
                    textAligment: paragraph.textAligment,
                    paragraphStyle: paragraph.paragraphStyle
                )
            }
        }
    }
    
}
