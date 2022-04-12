//
//  ZeroScreenSwiftUIView.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 12.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ZeroScreenSwiftUIView: View {
    
    private enum Constants {
        static let title = "Title Center"
        static let subTitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        static let buttonTitle = "Хорошо"
    }
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: "ZeroScreen",
            isShowThemeSwitchSwiftUIView: true
        ) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                ZeroScreenView(image: Image(Asset.Onboarding.one.name),
                               title: Constants.title,
                               subtitle: Constants.subTitle,
                               buttonTitle: Constants.buttonTitle,
                               isLoadingButton: .constant(false),
                               buttonAction: {})
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
