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
    
    enum Constant {
        static let maxSymbols = 20
    }
    
    @State private var text: String? = ""
    @State private var controlsState: Int = 0
    @State private var isResponder = true
    @State private var state: TextInputState = .normal
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "SMS Code") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(
                    items: ["Default", "Error", "Disabled"],
                    selection: $controlsState)
                    .onChange(of: controlsState, perform: { value in
                    self.state = TextInputState(rawValue: value) ?? .normal
                })
                Spacer()
                    .frame(height: LayoutGrid.doubleModule)
                OTPTextField(
                    value: $text,
                    formatter: BlocFormatter(format: { text in
                        if let text = text, text.count > Constant.maxSymbols {
                            return self.text
                        }
                        return text
                    }),
                    contentType: .numberPad,
                    placeholder: "СМС-код",
                    state: $state,
                    info: .constant("Additional text"),
                    isResponder: $isResponder,
                    onCursorPosition: { startIndex, currentIndex, text in
                        guard text.count <= Constant.maxSymbols else { return startIndex }
                        return currentIndex
                    })
                    .frame(width: LayoutGrid.module * 35)
                Spacer()
            }
            .onTapGesture { isResponder = false }
            .padding()
        }
    }
    
}
