//
//  ZeroScreenSwiftUIView.swift
//  ExampleiOS
//
//  Created on 12.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ZeroScreenSwiftUIView: View {

    // MARK: - Private properties

    @StateObject private var viewModel = ZeroScreenSwiftUIViewModel()
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
                ZeroScreenView(
                    image: Image(Asset.Onboarding.one.name),
                    title: viewModel.title,
                    subtitle: viewModel.subTitle,
                    buttonTitle: viewModel.buttonTitle,
                    isLoadingButton: $viewModel.isLoadingButton,
                    buttonAction: {}
                )
            }
            .background(scheme.backgroundColor.swiftUIColor)
        }
    }
    
}

@available(iOS 14.0.0, *)
struct ZeroScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroScreenSwiftUIView()
    }
}
