//
//  StandardTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 14.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct StandardTextFieldSwiftUIView: View {
    
    enum Constants {
        static let textViewId = "textView"
    }

    // MARK: - Private Properties

    @StateObject private var viewModel = StandardTextFieldSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        OutlineSliderTab(
                            items: viewModel.tabItems,
                            selection: $viewModel.controlsState)
                            .onChange(of: viewModel.controlsState, perform: { [weak viewModel] value in
                                viewModel?.state = TextInputState(rawValue: value) ?? .normal
                            })
                        VStack(alignment: .leading, spacing: 0.0) {
                            Spacer()
                                .frame(height: LayoutGrid.quadrupleModule)
                            Text("Basic")
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                            StandardTextField(
                                value: $viewModel.formatText,
                                accessibilityIdentifier: "testTextField",
                                formatter: BlocFormatter(format: { text in
                                    return text?.replacingOccurrences(of: "=)", with: "🙂")
                                }),
                                contentType: .default,
                                canPerformActionPaste: false,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $viewModel.state,
                                info: .constant("Additional text"),
                                infoNumberOfLines: nil,
                                isResponder: $viewModel.isResponderTextField,
                                onSubmit: {
                                    viewModel.isResponderSecureTextField = true
                                })
                                .id("standartTextField")
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                        }
                        VStack(alignment: .leading, spacing: 0.0) {
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                            Text("Masked")
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                            SwiftUI.Button("", action: {})
                            SecurityTextField(
                                $viewModel.secureText,
                                contentType: .default,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $viewModel.state,
                                info: .constant("Additional text"),
                                isResponder: $viewModel.isResponderSecureTextField,
                                onSubmit: {
                                    scrollView.scrollTo("textView")
                                    DispatchQueue.main.async {
                                        viewModel.isResponderTextView = true
                                    }
                                })
                                .id("securityTextField")
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                        }
                        VStack(alignment: .leading, spacing: 0.0) {
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                            Text("Multiline")
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            Spacer()
                                .frame(height: LayoutGrid.quadrupleModule)
                            TextView(
                                value: $viewModel.viewText,
                                formatter: BlocFormatter(format: { text in
                                    return text?.replacingOccurrences(of: "=)", with: "🙂")
                                }),
                                contentType: .default,
                                canPerformActionPaste: false,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $viewModel.state,
                                info: .constant("Additional text"),
                                infoNumberOfLines: 3,
                                isResponder: $viewModel.isResponderTextView,
                                onSubmit: {
                                    viewModel.isResponderTextView = false
                                })
                        }
                        .id(Constants.textViewId)
                        Spacer()
                    }
                    .padding(.bottom, LayoutGrid.doubleModule * 4)
                }
                .padding()
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            }
        }
    }
    
}
