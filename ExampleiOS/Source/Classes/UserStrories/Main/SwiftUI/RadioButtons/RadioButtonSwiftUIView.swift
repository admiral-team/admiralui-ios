//
//  RadioButtonSwiftUIView.swift
//  ExampleiOS
//
//  Created on 19.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct RadioButtonSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = RadioButtonSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    HStack {
                      Spacer()
                    }
                    StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                    Spacer()
                        .frame(height: LayoutGrid.module * 4)
                    VStack(spacing: LayoutGrid.halfModule * 4) {
                        ForEach(0..<viewModel.items.count, id: \.self) { index in
                            sectionRadioButton(
                                index: index,
                                radioButtonItem: viewModel.items[index],
                                scheme: scheme
                            )
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, LayoutGrid.doubleModule)
        }
    }

    // MARK: - Private Methods

    private func sectionRadioButton(
        index: Int,
        radioButtonItem: RadioButtonSwiftUIViewModel.RadioButtonSection,
        scheme: SwiftUIContentViewScheme
    ) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
            Text(radioButtonItem.title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            ForEach(0..<radioButtonItem.buttons.count, id: \.self) { butonIndex in
                let item = radioButtonItem.buttons[butonIndex]
                RadioControl(
                    isSelected: Binding<Bool>(
                        get: { item.isSelected },
                        set: { _ in
                            viewModel.selectedIndex = (index, butonIndex)
                        }
                    ),
                    text: item.text,
                    checkState: item.checkState
                )
                .disabled(viewModel.isEnabledControlsState != 0)
            }
            Spacer()
        }
    }
    
}
