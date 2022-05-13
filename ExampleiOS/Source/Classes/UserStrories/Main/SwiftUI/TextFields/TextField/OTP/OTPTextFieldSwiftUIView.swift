//
//  OTPTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 25.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct OTPTextFieldSwiftUIView: View {

    // MARK: - Constants

    enum Constant {
        static let maxSymbols = 20
    }

    // MARK: - Private Properties

    @StateObject private var viewModel = OTPTextFieldSwiftUIViewModel()
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
                OTPTextField(
                    value: $viewModel.text,
                    formatter: BlocFormatter(format: { [weak viewModel] text in
                        if let text = text, text.count > Constant.maxSymbols {
                            return viewModel?.text
                        }
                        return text
                    }),
                    contentType: .numberPad,
                    placeholder: "СМС-код",
                    state: $viewModel.state,
                    info: .constant("Additional text"),
                    isResponder: $viewModel.isResponder,
                    onCursorPosition: { startIndex, currentIndex, text in
                        guard text.count <= Constant.maxSymbols else { return startIndex }
                        return currentIndex
                    })
                    .frame(width: LayoutGrid.module * 35)
                Spacer()
            }
            .onTapGesture { viewModel.isResponder = false }
            .padding()
        }
    }
    
}
