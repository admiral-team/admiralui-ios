//
//  ButtonsView.swift
//  ExampleiOS
//
//  Created on 17.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ButtonsSwiftUIView: View {
    
    // MARK: - Private properties

    @StateObject private var viewModel = ButtonsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: viewModel.tabs, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                VStack(alignment: .leading) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        buildItem(scheme: scheme, item: viewModel.items[index], sectionIndex: index)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
            .padding()
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func buildItem(
        scheme: SwiftUIContentViewScheme,
        item: ButtonsSwiftUIViewModel.ButtonsStorage,
        sectionIndex: Int
    ) -> some View {
        VStack(alignment: .leading, spacing: item.type == .ghost ? 32.0 : LayoutGrid.doubleModule) {
            Text(item.title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            switch item.type {
            case .primary:
                TwoTitlePrimaryButton(leftText: "08.06.20 — 14.08.20", rightText: "Выбрать", action: {})
                    .frame(height: LayoutGrid.doubleModule * 3)
                    .disabled(viewModel.isEnabledControlsState != 0)
                ForEach(0..<item.items.count, id: \.self) { index in
                    SwiftUI.Button(item.items[index].title, action: {
                        viewModel.items[sectionIndex].items[index].isLoading.toggle()
                    })
                        .buttonStyle(PrimaryButtonStyle(isLoading: $viewModel.items[sectionIndex].items[index].isLoading, sizeType: item.items[index].size))
                        .disabled(viewModel.isEnabledControlsState != 0)
                }
            case .secondary:
                ForEach(0..<item.items.count, id: \.self) { index in
                    SwiftUI.Button(item.items[index].title, action: {
                        viewModel.items[sectionIndex].items[index].isLoading.toggle()
                    })
                        .buttonStyle(SecondaryButtonStyle(isLoading: $viewModel.items[sectionIndex].items[index].isLoading, sizeType: item.items[index].size))
                        .disabled(viewModel.isEnabledControlsState != 0)
                }
            case .ghost:
                TwoTitleGhostButton(
                    leftText: "Выбрать все карты",
                    rightText: "Готово",
                    leftAction: {},
                    rightAction: {})
                    .frame(height: LayoutGrid.doubleModule * 3)
                    .disabled(viewModel.isEnabledControlsState != 0)
                ForEach(0..<item.items.count, id: \.self) { index in
                    SwiftUI.Button(item.items[index].title, action: {
                        viewModel.items[sectionIndex].items[index].isLoading.toggle()
                    })
                        .buttonStyle(GhostButtonStyle(isLoading: $viewModel.items[sectionIndex].items[index].isLoading, sizeType: item.items[index].size))
                        .disabled(viewModel.isEnabledControlsState != 0)
                }
            case .rules:
                CheckboxTextbuttonView(
                    title: "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных",
                    isSelected: $viewModel.items[sectionIndex].isSelected,
                    subtitleButtonTitle: "Открыть список документов",
                    subtitleButtonAction: {}
                )
                .disabled(viewModel.isEnabledControlsState != 0)
            }
            Spacer()
                .frame(height: 56.0)
        }
    }
    
}
