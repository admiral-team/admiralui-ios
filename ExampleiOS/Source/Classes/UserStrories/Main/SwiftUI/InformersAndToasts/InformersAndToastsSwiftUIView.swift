//
//  InformersAndToastsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct InformersAndToastsSwiftUIView: View {

    // MARK: - Type Alias
    
    typealias InformersItem = InformersAndToastSwiftUIViewModel.InformersAndToastsSwiftUItem

    // MARK: - Private Properties

    @StateObject private var viewModel = InformersAndToastSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    @State private var scheme: SwiftUIContentViewScheme?

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
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

    // MARK: - Private Properties

    @ViewBuilder
    private func view(for type: InformersItem) -> some View {
        switch type {
        case .informers:
            InformersSwiftUIView()
        case .notifications:
            NotificationsSwiftUIView()
        }
    }
    
}
