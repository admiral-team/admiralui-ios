//
//  NavigationContentView.swift
//  ExampleiOS
//
//  Created on 16.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct NavigationContentView<Content>: View where Content: View {
    
    // MARK: - Internal Properties
    
    @Environment(\.manager) var manager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var isShowBackButton: Bool = true
    var isShowThemeSwitchSwiftUIView: Bool = true
    
    var content: () -> Content
    var navigationTitle: String
    var navigationBarDisplayMode: NavigationBarItem.TitleDisplayMode
    
    // MARK: - Private Properties
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<NavigationContentViewScheme>()
    
    // MARK: - Initializer
    
    init(
        navigationTitle: String,
        isShowBackButton: Bool = true,
        isShowThemeSwitchSwiftUIView: Bool = true,
        navigationBarDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isShowBackButton = isShowBackButton
        self.isShowThemeSwitchSwiftUIView = isShowThemeSwitchSwiftUIView
        self.navigationTitle = navigationTitle
        self.content = content
        self.navigationBarDisplayMode = navigationBarDisplayMode
    }

    // MARK: - Layout

    var body: some View {
        if isShowBackButton {
            mainView()
        } else {
            mainView()
                .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Private methods
    
    private func mainView() -> some View {
        ZStack {
            content()
            if isShowThemeSwitchSwiftUIView {
                ThemeSwitchSwiftUIView()
                    .padding(.trailing, LayoutGrid.module)
            }
        }
        .navigationBarTitle(navigationTitle, displayMode: navigationBarDisplayMode)
    }

}
