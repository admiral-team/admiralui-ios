//
//  DoubleTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 02.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct DoubleTextFieldSwiftUIView: View {
    
    // MARK: - Private Properties

    @StateObject private var viewModel = DoubleTextFieldSwiftUIViewModel()
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
                OutlineSliderTab(items: viewModel.tabItems, selection: $viewModel.controlsState)
                    .onChange(of: viewModel.controlsState, perform: { [weak viewModel] value in
                        viewModel?.state = TextInputState(rawValue: value) ?? .normal
                    })
                Spacer()
                    .frame(height: LayoutGrid.tripleModule)
                HStack() {
                    Text("50/50")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .font(scheme.textFont.swiftUIFont)
                    Spacer()
                }
                VStack {
                    Spacer()
                        .frame(height: LayoutGrid.tripleModule)
                    DoubleTextField(
                        firstTextField: StandardTextField($viewModel.firstText, placeholder: "Placeholder", name: "Optional Label", state: $viewModel.state),
                        secondTextField: StandardTextField($viewModel.secondText, placeholder: "Placeholder", name: "Optional Label", state: $viewModel.state),
                        alignment: .ratio(ration: 0.5),
                        info: "Info",
                        infoNumberOfLines: 1,
                        state: $viewModel.state)
                    Spacer()
                        .frame(height: 80.0)
                }
                HStack() {
                    Text("70/30")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                        .font(scheme.textFont.swiftUIFont)
                    Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.tripleModule)
                DoubleTextField(
                    firstTextField: StandardTextField(
                        $viewModel.thirdText,
                        placeholder: "Placeholder",
                        name: "Optional Label",
                        state: $viewModel.state,
                        info: .constant("Info"),
                        infoNumberOfLines: 3),
                    secondTextField: StandardTextField(
                        $viewModel.fourText,
                        placeholder: "Placeholder",
                        name: "Optional Label",
                        state: $viewModel.state,
                        info: .constant("Info"),
                        infoNumberOfLines: 3),
                    alignment: .ratio(ration: 0.7),
                    state: $viewModel.state)
                Spacer()
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .padding()
        }
    }
    
}
