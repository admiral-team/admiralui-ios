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
    
    @State private var controlsState: Int = 0
    @State private var firstText: String? = "Text"
    @State private var secondText: String? = "Text"
    
    @State private var thirdText: String? = "Text"
    @State private var fourText: String? = "Text"
    @State private var state: TextInputState = .normal
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Double") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                    Spacer()
                }
                OutlineSliderTab(items: ["Default", "Error", "Disabled", "Read Only"], selection: $controlsState)
                    .onChange(of: controlsState, perform: { value in
                        self.state = TextInputState(rawValue: value) ?? .normal
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
                        firstTextField: StandardTextField($firstText, placeholder: "Placeholder", name: "Optional Label", state: $state),
                        secondTextField: StandardTextField($secondText, placeholder: "Placeholder", name: "Optional Label", state: $state),
                        alignment: .ratio(ration: 0.5),
                        info: "Info",
                        infoNumberOfLines: 1,
                        state: $state)
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
                        $thirdText,
                        placeholder: "Placeholder",
                        name: "Optional Label",
                        state: $state,
                        info: .constant("Info"),
                        infoNumberOfLines: 3),
                    secondTextField: StandardTextField(
                        $fourText,
                        placeholder: "Placeholder",
                        name: "Optional Label",
                        state: $state,
                        info: .constant("Info"),
                        infoNumberOfLines: 3),
                    alignment: .ratio(ration: 0.7),
                    state: $state)
                Spacer()
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .padding()
        }
    }
    
    private func someText() -> String {
        var text = ""
        for index in 0..<1000 {
            text += "\(index)"
        }
        return text
    }
    
}
