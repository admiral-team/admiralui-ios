//
//  BankTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 25.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BankTextFieldSwiftUIView: View {

    // MARK: - Constants

    private enum Constants {
        static let maxSymbols = 19
        static let bankCardTextFieldWidth: CGFloat = 295.0
    }
    // MARK: - Private Properties

    @StateObject private var viewModel = BankTextFieldSwiftUIViewModel()
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
                StandardTab(
                    items: viewModel.tabItems,
                    selection: $viewModel.controlsState)
                    .onChange(of: viewModel.controlsState, perform: { [weak viewModel] value in
                    viewModel?.state = TextInputState(rawValue: value) ?? .normal
                })
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                BankCardTextField(
                    value: $viewModel.text,
                    formatter: BlocFormatter(format: { value in
                        var targetCursorPosition = 0
                        return viewModel.modifyCreditCardString(text: value ?? "", cursorPosition: &targetCursorPosition)
                    }),
                    state: $viewModel.state,
                    contentType: .numberPad,
                    placeholder: "1111 2222 3333 4444",
                    info: .constant("Info"),
                    isResponder: $viewModel.isResponder,
                    onCursorPosition: { startIndex, currentIndex, text in
                        guard text.count <= Constants.maxSymbols else { return startIndex }
                        
                        var targetCursorPosition = currentIndex
                        _ = viewModel.modifyCreditCardString(text: text, cursorPosition: &targetCursorPosition)

                        return targetCursorPosition
                    })
                    .frame(width: Constants.bankCardTextFieldWidth)
                Spacer()
            }
            .onTapGesture { viewModel.isResponder = false }
            .padding()
        }
    }

}
