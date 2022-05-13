//
//  BaseCellSwiftUIView.swift
//  ExampleiOS
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct BaseCellSwiftUIView: View {

    // MARK: - Type Alias

    typealias CellItems = BaseCellSwiftUIViewModel.BaseCellSwiftUIItem

    // MARK: - Private properties

    @StateObject private var viewModel = BaseCellSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(CellItems.allCases, id: \.self) { item in
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
                            withAnimation { [weak viewModel] in
                                viewModel?.selection = item.rawValue
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    @ViewBuilder
    private func view(for type: CellItems) -> some View {
        switch type {
        case .leading:
            LeadingComponentsSwiftUIView()
        case .traling:
            TralingComponentsSwiftUIView()
        }
    }
    
}
