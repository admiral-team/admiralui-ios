//
//  TabsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 20.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct TabsSwiftUIView: View {
    
    // MARK: - Type Alias

    typealias TbasItem = TabsSwiftUIViewModel.TabsSwiftUIItem

    // MARK: - Private Properties

    @StateObject private var viewModel = TabsSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.title) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(TbasItem.allCases, id: \.self) { item in
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
    private func view(for type: TbasItem) -> some View {
        switch type {
        case .standard:
            StandardTabSwiftUIView()
        case .underlineSlider:
            UnderlineSliderTabSwiftUIView()
        case .logo:
            LogoTabSwiftUIView()
        case .outlineSlider:
            OutlineSliderTabSwiftUITab()
        case .informer:
            InformerTabSwiftUIView()
        case .icon:
            IconTabsSwiftUI()
        }
    }
    
}
