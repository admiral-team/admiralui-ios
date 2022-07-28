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
    
    @State private var formatText: String? = "Text"
    @State private var text: String? = "Text"
    @State private var secureText: String? = "Text"
    @State private var viewText: String? = "Text"
    @State private var controlsState: Int = 0
    @State private var state: TextInputState = .normal
    
    @State private var isResponderTextField: Bool = false
    @State private var isResponderSecureTextField: Bool = false
    @State private var isResponderTextView: Bool = false
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Standard") {
            scheme.backgroundColor.swiftUIColor
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        OutlineSliderTab(
                            items: ["Default", "Read Only", "Error", "Disabled"],
                            selection: $controlsState)
                            .onChange(of: controlsState, perform: { value in
                                switch value {
                                case 0:
                                    self.state = .normal
                                case 1:
                                    self.state = .readOnly
                                case 2:
                                    self.state = .error
                                case 3:
                                    self.state = .disabled
                                default:
                                    break
                                }
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
                                value: $formatText,
                                accessibilityIdentifier: "testTextField",
                                formatter: BlocFormatter(format: { text in
                                    text?.replacingOccurrences(of: "=)", with: "🙂")
                                }),
                                contentType: .default,
                                canPerformActionPaste: false,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $state,
                                info: .constant("Additional text"),
                                infoNumberOfLines: nil,
                                isResponder: $isResponderTextField,
                                onSubmit: {
                                    isResponderSecureTextField = true
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
                                $secureText,
                                contentType: .default,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $state,
                                info: .constant("Additional text"),
                                isResponder: $isResponderSecureTextField,
                                onSubmit: {
                                    scrollView.scrollTo("textView")
                                    DispatchQueue.main.async {
                                        self.isResponderTextView = true
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
                                value: $viewText,
                                formatter: BlocFormatter(format: { text in
                                    text?.replacingOccurrences(of: "=)", with: "🙂")
                                }),
                                contentType: .default,
                                canPerformActionPaste: false,
                                placeholder: "Placeholder",
                                name: "Optional label",
                                state: $state,
                                info: .constant("Additional text"),
                                infoNumberOfLines: 3,
                                isResponder: $isResponderTextView,
                                onSubmit: {
                                    isResponderTextView = false
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
