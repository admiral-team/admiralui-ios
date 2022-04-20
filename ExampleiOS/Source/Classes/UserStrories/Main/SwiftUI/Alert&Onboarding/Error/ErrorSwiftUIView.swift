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

    // MARK: - Private properties

    @StateObject private var viewModel = ErrorSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: viewModel.navigationTitle,
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
            text: viewModel.text,
            buttonTitle: viewModel.buttonTitle,
            isLoadingButton: $viewModel.isLoading,
            buttonAction: { viewModel.isLoading.toggle() }
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
