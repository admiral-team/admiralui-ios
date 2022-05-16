//
//  InputRangeTextFieldSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InputRangeTextFieldSwiftUIView: View {
    
    @State private var text: String? = "100"
    
    @State private var contentFrom: String? = "100"
    @State private var contentTo: String? = "300"
    
    @State private var controlsState: Int = 0
    @State private var state: TextInputState = .normal
    @State private var isResponder = false
    @State private var isResponderTo = false
    @State private var isResponderFrom = false
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Slider") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                StandardTab(
                    items: ["Default", "Error", "Disabled"],
                    selection: $controlsState)
                    .onChange(of: controlsState, perform: { value in
                    self.state = TextInputState(rawValue: value) ?? .normal
                })
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                HStack {
                    Text("Standard")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                InputRangeTextField(
                    $text,
                    placeholder: "Placeholder",
                    name: "Optional label",
                    state: $state,
                    info: .constant("Additional text"),
                    leadingText: .constant("$"),
                    sliderValue: 100,
                    minValue: 100,
                    maxValue: 1000,
                    isResponder: $isResponder
                )
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                HStack {
                    Text("Double")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                }
                Spacer()
                    .frame(height: LayoutGrid.quadrupleModule)
                DoubleInputRangeTextField(
                    $contentFrom,
                    contentTo: $contentTo,
                    placeholderFrom: "PlaceholderFrom",
                    placeholderTo: "PlaceholderTo",
                    name: "Optional label",
                    state: $state,
                    info: .constant("Additional text"),
                    sliderValueFrom: 100,
                    sliderValueTo: 300,
                    minValue: 100,
                    maxValue: 1000,
                    leadingText: .constant("₽"),
                    trailingText: .constant("₽"),
                    isResponderFrom: $isResponderFrom,
                    isResponderTo: $isResponderTo
                )
                Spacer()
            }
            .padding()
            .onTapGesture {
                isResponder = false
                isResponderFrom = false
                isResponderTo = false
            }
        }

    }
    
}
