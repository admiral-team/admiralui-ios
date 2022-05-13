//
//  ImageBaseCellSwiftUIView.swift
//  ExampleiOS
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ImageBaseCellSwiftUIView: View {
    
    // MARK: - Type Alias

    typealias CellItems = ImageBaseCellSwiftUIViewModel.ImageBaseCellSwiftUIItem

    // MARK: - Private properties

    @StateObject private var viewModel = ImageBaseCellSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(CellItems.allCases, id: \.self) { item in
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
        case .lable:
            ImageLableComponentsSwiftUIView()
        case .leading:
            ImageLeadingLableComponentsSwiftUIView()
        case .trailing:
            ImageTrailingLableComponentsSwiftUIView()
        }
    }
    
}
