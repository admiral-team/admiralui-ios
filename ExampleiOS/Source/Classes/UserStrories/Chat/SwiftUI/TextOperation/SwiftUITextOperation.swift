//
//  TextOperationView.swift
//  ExampleiOS
//
//  Created on 13.12.2021.
//

import SwiftUI
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SwiftUITextOperationView: View {
    
    // MARK: - Private properties
    
    @StateObject private var viewModel = SwiftUITextOperationViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Text Operation",
            navigationBarDisplayMode: .large
        ) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: LayoutGrid.module * 5) {
                    ForEach((0..<viewModel.items.count), id: \.self) { index in
                        if viewModel.items[index].direction == .left {
                            VStack {
                                buildRow(
                                    item: viewModel.items[index],
                                    scheme: scheme,
                                    index: index
                                )
                                Spacer()
                            }
                        } else {
                            VStack {
                                Spacer()
                                buildRow(
                                    item: viewModel.items[index],
                                    scheme: scheme,
                                    index: index
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, LayoutGrid.doubleModule)
            }
        }
        .actionSheet(isPresented: $viewModel.showActionSheet) { () -> ActionSheet in
            showActionSheet(scheme: scheme)
        }
    }

    // MARK: - Private methods 

    private func showActionSheet(scheme: SwiftUIContentViewScheme) -> ActionSheet {
        ActionSheet(
            title: Text(""),
            message: Text(""),
            buttons: [
                .default(Text("Повторить отправку").font(scheme.textFont.swiftUIFont), action: {
                    viewModel.action = .reload
                }),
                .default(Text("Удалить").font(scheme.textFont.swiftUIFont), action: {
                    viewModel.action = .remove
                }),
                .cancel(Text("Отмена").font(scheme.textFont.swiftUIFont), action: {})
            ]
        )
    }

    private func buildRow(
        item: SwiftUITextOperationViewModel.TextOperationItem,
        scheme: SwiftUIContentViewScheme,
        index: Int
    ) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule + (LayoutGrid.module / 2)) {
            Text(item.rowTitle)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            TextOperationView(
                style: item.style,
                chatStatus: item.chatStatus,
                direction: item.direction,
                time: item.time,
                title: item.title,
                description: item.description,
                errorAction: {
                    viewModel.showActionSheet = true
                    viewModel.selectedIndex = index
                }
            )
        }
    }
    
}
