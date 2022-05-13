//
//  PinCodeTextFieldView.swift
//  ExampleiOS
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct PinCodeTextFieldView: View {
    
    // MARK: - Private Properties

    @StateObject private var viewModel = PinCodeTextFieldSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        let rightImage = viewModel.selectedNumber.isEmpty ? viewModel.rightButtonImage : Image(uiImage: Asset.PinCode.deleteButton.image)
        NavigationContentView(navigationTitle: viewModel.title, isShowThemeSwitchSwiftUIView: false) {
            scheme.backgroundColor.swiftUIColor
            VStack {
                HStack {
                  Spacer()
                }
                StandardTab(
                    items: viewModel.tabItems,
                    selection: $viewModel.controlsState)
                    .onChange(of: viewModel.controlsState, perform: { [weak viewModel] value in
                    viewModel?.status = CodeInputControl.Status(rawValue: value) ?? .normal
                })
                    .padding(LayoutGrid.doubleModule)
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                InputNumber(
                    titleText: .constant("Количество знаков"),
                    value: $viewModel.maxCountNumbers,
                    minimumValue: .constant(1.0),
                    maximumValue: .constant(10.0))
                    .padding(LayoutGrid.doubleModule)
                Spacer()
                CodeInputControl(text: $viewModel.selectedNumber, itemsCount: Int(viewModel.maxCountNumbers), status: viewModel.status)
                Spacer(minLength: 100.0)
                PinCodeKeyboard(
                    leftButtonTitle: viewModel.leftButtonTitle,
                    rightButtonImage: rightImage,
                    didTapNumber: { number in
                        guard viewModel.selectedNumber.count < Int(viewModel.maxCountNumbers) else { return }
                        viewModel.selectedNumber += String(number)
                    },
                    didTapLeftButton: {
                        print("Tap on left button")
                    },
                    didTapRightButton: {
                        guard !viewModel.selectedNumber.isEmpty else { return }
                        if viewModel.selectedNumber.count > Int(viewModel.maxCountNumbers) {
                            for _ in Int(viewModel.maxCountNumbers) ..< viewModel.selectedNumber.count {
                                viewModel.selectedNumber.removeLast()
                            }
                        }
                        viewModel.selectedNumber.removeLast()
                    })
            }
        }
    }

}

@available(iOS 14.0.0, *)
struct PinCodeTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeTextFieldView()
    }
}
