//
//  ErrorSwiftUIView.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ErrorSwiftUIView: View {

    // MARK: - Constants

    private enum Constants {
        static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        static let buttonTitle = "Хорошо"
    }

    // MARK: - Private properties

    @State private var isLoading = false
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "Error View",
            isShowThemeSwitchSwiftUIView: true
        ) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                errorView
            }
            .background(scheme.backgroundColor.swiftUIColor)
        }
    }

    // MARK: - Private methods

    private var errorView: some View {
        ErrorView(
            text: Constants.text,
            buttonTitle: Constants.buttonTitle,
            isLoadingButton: $isLoading,
            buttonAction: { isLoading.toggle() },
            buttonAccessibilityId: "ErrorViewButton"
        )
        .padding()
    }
}

@available(iOS 14.0, *)
struct ErrorSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ErrorSwiftUIView()
    }
}
