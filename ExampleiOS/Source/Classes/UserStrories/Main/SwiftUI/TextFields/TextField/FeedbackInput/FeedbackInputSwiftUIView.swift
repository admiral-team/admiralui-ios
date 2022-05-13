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

    // MARK: - Private Properties

    @StateObject private var viewModel = FeedbackInputSwiftUIViewViewModel()
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
                StandardTab(items: viewModel.tabItems, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.module * 4)
                FeedbackInputControl(cursorPosition: $viewModel.cursorPosition)
                    .disabled(viewModel.isEnabledControlsState != 0)
                Spacer()
            }
            .padding()
        }
    }
    
}
