//
//  ActionBarSwiftUI.swift
//  ExampleiOS
//
//  Created on 08.02.2022.
//

import SwiftUI
import UniformTypeIdentifiers
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ActionBarSwiftUI: View {

    // MARK: - Type Alias

    typealias CellItems = ActionBarSwiftUIViewModel.ActionBarSwiftUIItem

    // MARK: - Private properties

    @StateObject private var viewModel = ActionBarSwiftUIViewModel()
    @ObservedObject private var manager = SwiftUIThemeManager.shared

    // MARK: - Layout

    var body: some View {
        let scheme = SwiftUIContentViewScheme(theme: manager.theme)
        navigationView(scheme: scheme)
            .navigationBarColor(
                backgroundColor: scheme.backgroundColor.swiftUIColor,
                titleColor: scheme.titleNavigationColor.swiftUIColor
            )
            .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Private methods

    private func navigationView(scheme: SwiftUIContentViewScheme) -> some View {
        NavigationContentView(
            navigationTitle: viewModel.title,
            isShowBackButton: true,
            isShowThemeSwitchSwiftUIView: true,
            navigationBarDisplayMode: .large
        ) {
            ZStack {
                scheme.backgroundColor.swiftUIColor
                    .edgesIgnoringSafeArea(.all)
                scrollView
            }
        }
    }

    private var scrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(CellItems.allCases, id: \.self) { item in
                    NavigationLink(destination: view(for: item)) {
                        ListCell(
                            centerView: { TitleListView(title: item.title) },
                            trailingView: { ArrowListView() }
                        )
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func view(for type: CellItems) -> some View {
        switch type {
        case .default:
            ActionBarSwiftUIViewDefault()
        case .secondary:
            ActionBarSwiftUIViewSecondary()
        }
    }

}
