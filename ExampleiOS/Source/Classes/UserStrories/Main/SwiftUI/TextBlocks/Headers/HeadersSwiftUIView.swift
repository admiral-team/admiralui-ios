//
//  HeadersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct HeadersSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = HeadersSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: .zero) {
                    ForEach(viewModel.items, id: \.self) { item in
                        headerItem(item: item, scheme: scheme)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func headerItem(
        item: HeadersSwiftUIViewModel.HeaderItem,
        scheme: SwiftUIContentViewScheme
    ) -> some View {
        HStack(spacing: LayoutGrid.doubleModule) {
            Text(item.header)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            Spacer()
        }
        .padding()
        VStack(spacing: LayoutGrid.doubleModule) {
            TitleHeader(
                title: item.title,
                headerStyle: item.headerStyle
            )
            DropDownHeader(
                title: item.title,
                dropDownHeaderType: item.dropDownHeaderType,
                headerStyle: item.headerStyle
            )
            SubtitleTitleHeader(
                title: item.title,
                subtitle: item.subTitle,
                headerStyle: item.headerStyle
            )
            TitleSubtitleHeader(
                title: item.title,
                subtitle: item.subTitle,
                headerStyle: item.headerStyle
            )
            TitleArrowWithButtonHeader(
                title: item.title,
                buttonTitle: item.buttonTitle,
                buttonAction: {},
                dropDownHeaderType: item.dropDownHeaderType,
                headerStyle: item.headerStyle
            )
            TitleHeader(
                title: item.title,
                textAligment: .center,
                headerStyle: item.headerStyle
            )
        }
    }

}
