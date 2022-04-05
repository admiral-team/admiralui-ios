//
//  BadgesSwiftUIView.swift
//  ExampleiOS
//
//  Created on 06.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct BadgesSwiftUIView: View {

    // MARK: - Properties

    @ObservedObject private var manager = SwiftUIThemeManager.shared

    // MARK: - Layout

    public var body: some View {
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
            navigationTitle: "Badges",
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
                ForEach(BadgesItem.allCases, id: \.self) { item in
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
    private func view(for type: BadgesItem) -> some View {
        switch type {
        case .small:
            SmallBadgesSwiftUIView()
        case .normal:
            NormalBadgesSwiftUIView()
        }
    }

}
