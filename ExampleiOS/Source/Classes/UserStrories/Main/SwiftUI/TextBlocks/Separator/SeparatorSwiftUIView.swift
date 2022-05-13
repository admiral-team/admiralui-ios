//
//  PaddingView.swift
//  ExampleiOS
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct SeparatorSwiftUIView: View {

    // MARK: - Private Properties

    @StateObject private var viewModel = SeparatorSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: LayoutGrid.tripleModule) {
                    ForEach(viewModel.items, id: \.id) { item in
                        HStack(spacing: 0.0) {
                            Text(item.title)
                                .font(scheme.textFont.swiftUIFont)
                                .foregroundColor(scheme.textColor.swiftUIColor)
                            Spacer()
                        }
                        .padding()
                        SeparatorView(paddingStyle: item.style)
                    }
                }
                .padding(.bottom, LayoutGrid.doubleModule * 4)
            }
        }
    }
    
}
