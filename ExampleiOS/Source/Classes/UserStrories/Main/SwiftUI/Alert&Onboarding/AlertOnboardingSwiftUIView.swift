//
//  AlertOnboardingSwiftUIView.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct AlertOnboardingSwiftUIView: View {

    // MARK: - Properties

    @ObservedObject private var manager = Appearance.shared.swiftuiThemeManager

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
            navigationTitle: "Alert&Onboarding",
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
                ForEach(AlertOnboardingItem.allCases, id: \.self) { item in
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
    private func view(for type: AlertOnboardingItem) -> some View {
        switch type {
        case .alert:
            AlertSwiftUIView()
        case .error:
            ErrorSwiftUIView()
        case .onboarding:
            OnBoardingSwiftUIView()
        case .zeroScreen:
            ZeroScreenSwiftUIView()
        }
    }

}
