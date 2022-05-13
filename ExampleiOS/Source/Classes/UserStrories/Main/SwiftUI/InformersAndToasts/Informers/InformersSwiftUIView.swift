//
//  InformersSwiftUIView.swift
//  ExampleiOS
//
//  Created on 18.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InformersSwiftUIView: View {
 
    // MARK: - Type Alias
    
    typealias InformersItem = InformersSwiftUIViewModel.InformersSwiftUIItem

    // MARK: - Private Properties

    @StateObject private var viewModel = InformersSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(InformersItem.allCases, id: \.self) { item in
                        // WORKAROUND: https://developer.apple.com/forums/thread/677333
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        NavigationLink(destination: view(for: item), tag: item.rawValue, selection: $viewModel.selection) {
                            ListCell(
                                centerView: { TitleListView(title: item.title) },
                                trailingView: { ArrowListView() },
                                isHighlighted: Binding(get: { viewModel.selection == item.rawValue }, set: { _ in }))
                                .frame(height: 68)
                        }
                        .onTapGesture {
                            withAnimation {
                                viewModel.selection = item.rawValue
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Layout

    @ViewBuilder
    private func view(for type: InformersItem) -> some View {
        switch type {
        case .bigInformers:
            BigInformersSwiftUIView()
        case .smallInformers:
            SmallInformersSwiftUIView()
        }
    }
    
}
