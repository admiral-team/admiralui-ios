//
//  CheckBoxSwiftUIView.swift
//  ExampleiOS
//
//  Created on 19.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct CheckBoxSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = CheckBoxSwiftUIViewModel()
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
                        .frame(height: LayoutGrid.doubleModule)
                    ForEach(0..<viewModel.items.count, id: \.self) { sectionIndex in
                        checkBoxSection(
                            sectionIndex: sectionIndex,
                            checkBoxItem: viewModel.items[sectionIndex],
                            scheme: scheme
                        )
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func checkBoxSection(
        sectionIndex: Int,
        checkBoxItem: CheckBoxSwiftUIViewModel.CheckBoxSection,
        scheme: SwiftUIContentViewScheme
    ) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
            Text(checkBoxItem.title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            ForEach(0..<checkBoxItem.checkBoxs.count, id: \.self) { checkBoxIndex in
                let item = checkBoxItem.checkBoxs[checkBoxIndex]
                CheckBox(
                    isSelected: Binding<Bool>(
                        get: { item.isSelected },
                        set: { _ in
                            viewModel.selectedIndex = (sectionIndex, checkBoxIndex)
                        }
                    ),
                    text: item.text,
                    checkState: item.checkState
                )
                .disabled(viewModel.isEnabledControlsState != 0)
            }
            Spacer()
        }
        Spacer()
            .frame(height: LayoutGrid.halfModule * 6)
    }

}
