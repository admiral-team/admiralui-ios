//
//  LinkSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct LinkSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = LinkSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: .zero) {
                    ForEach(viewModel.items, id: \.self) { item in
                        switch item {
                        case .link(let buttonTitle):
                            LinkView(buttonTitle: buttonTitle, buttonAction: {})
                        }
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
