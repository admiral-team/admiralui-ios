//
//  DropDownSwiftUIView.swift
//  ExampleiOS
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct DropDownSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = DropDownSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 0.0) {
                    ForEach(viewModel.items, id: \.self) { item in
                        switch item {
                        case .titleButtonDropDown(let title, let buttonTitle):
                            TitleButtonDropDown(
                                title: title,
                                buttonTitle: buttonTitle,
                                buttonAction: {})
                        case .buttonDropDown(let buttonTitle, let headerType):
                            ButtonDropDown(
                                buttonTitle: buttonTitle,
                                dropDownHeaderType: headerType,
                                buttonAction: {}
                            )
                        }
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
