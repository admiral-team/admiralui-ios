//
//  SwiftUIChatViewController.swift
//  ExampleiOS
//
//  Created on 16.08.2021.
//

import SwiftUI
import UniformTypeIdentifiers
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ChatSwiftUIView: View {

    enum NavigationBarStyle {
        case singlePage
        case fromMainPage
    }

    // MARK: - Properties

    @ObservedObject private var manager = SwiftUIThemeManager.shared
    private let navigationStyle: NavigationBarStyle

    // MARK: - Initializer

    init(navigationStyle: NavigationBarStyle) {
        self.navigationStyle = navigationStyle
    }

    // MARK: - Layout
    
    public var body: some View {
        let scheme = SwiftUIContentViewScheme(theme: manager.theme)
        contentView(scheme: scheme)
            .navigationBarColor(
                backgroundColor: scheme.backgroundColor.swiftUIColor,
                titleColor: scheme.titleNavigationColor.swiftUIColor
            )
            .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Private methods

    @ViewBuilder private func contentView(scheme: SwiftUIContentViewScheme) -> some View {
        switch navigationStyle {
        case .singlePage:
            NavigationView {
                navigationView(scheme: scheme)
            }
            .accentColor(scheme.backButtonColor.swiftUIColor)
        case .fromMainPage:
            navigationView(scheme: scheme)
        }
    }

    private func navigationView(scheme: SwiftUIContentViewScheme) -> some View {
        NavigationContentView(
            navigationTitle: "Чат",
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
                ForEach(SwiftUIChatItem.allCases, id: \.self) { item in
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
    private func view(for type: SwiftUIChatItem) -> some View {
        switch type {
        case .input:
            SwiftUIChatInputView()
        case .textMessage:
            SwiftUITextMessageView()
        case .textOperation:
            SwiftUITextOperationView()
        case .uploadingPhoto:
            SwiftUIUploadingPhotoView()
        case .uploadingFile:
            SwiftUIUploadingFileView()
        }
    }

}

@available(iOS 14.0.0, *)
class SwiftUIChatViewController: UIHostingController<ChatSwiftUIView> {
    
    init() {
        let chatSwiftUIView = ChatSwiftUIView(navigationStyle: .singlePage)
        super.init(rootView: chatSwiftUIView)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch Appearance.shared.theme.colors.style {
        case .light:
            return .darkContent
        case .dark:
            return .lightContent
        @unknown default:
            return .lightContent
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
