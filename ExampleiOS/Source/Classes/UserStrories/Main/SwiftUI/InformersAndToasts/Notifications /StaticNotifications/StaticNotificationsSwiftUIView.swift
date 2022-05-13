//
//  StaticNotificationsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct StaticNotificationsSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = StaticNotificationsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 3)
                    ForEach(viewModel.items, id: \.id) { item in
                        buildItem(scheme: scheme, item: item)
                    }
                }
                .padding(.horizontal, LayoutGrid.doubleModule)
                .padding(.bottom, LayoutGrid.doubleModule * 6)
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(
        scheme: SwiftUIContentViewScheme,
        item: StaticNotificationsSwiftUIViewModel.NotificationItem
    ) -> some View {
        HStack {
            Text(item.title)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .font(scheme.textFont.swiftUIFont)
            Spacer()
        }
        Spacer()
            .frame(height: LayoutGrid.doubleModule)
        ToastView(
            title: item.text,
            linkText: item.linkText,
            linkAction: {},
            imageType: item.imageType,
            imageColorType: item.imageType,
            closeAction: {},
            type: .default)
        ToastView(
            title: item.text,
            linkText: item.linkText,
            linkAction: {},
            imageType: item.imageType,
            imageColorType: item.imageType,
            closeAction: {},
            type: item.type
        )
        Spacer()
            .frame(height: LayoutGrid.doubleModule * 2)
    }
    
}
