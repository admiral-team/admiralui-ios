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
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Header"
        static let subTitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        static let buttonTitle = "Хорошо"
    }
    
    // MARK: - Private properties
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "ZeroScreen",
            isShowThemeSwitchSwiftUIView: true
        ) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                ZeroScreenView(image: Image(Asset.Zeroscreen.success.name),
                               title: Constants.title,
                               subtitle: Constants.subTitle,
                               buttonTitle: Constants.buttonTitle,
                               isLoadingButton: .constant(false),
                               buttonAction: {},
                               buttonAccessibilityId: "ZeroScreenButton")
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
