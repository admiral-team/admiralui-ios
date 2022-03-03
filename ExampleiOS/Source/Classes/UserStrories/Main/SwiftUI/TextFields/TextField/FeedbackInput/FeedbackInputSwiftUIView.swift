//
//  FeedbackInputSwiftUIView.swift
//  ExampleiOS
//
//  Created on 01.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct FeedbackInputSwiftUIView: View {
    
    @State private var cursorPosition: Int = 0
    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Feedback") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical) {
                HStack {
                  Spacer()
                }
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: 32.0)
                FeedbackInputControl(cursorPosition: $cursorPosition)
                    .disabled(isEnabledControlsState != 0)
                Spacer()
            }
            .padding()
        }
    }
    
}
