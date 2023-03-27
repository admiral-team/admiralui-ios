//
//  SwiftUIController.swift
//  ExampleiOS
//
//  Created on 08.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct NavBarAccessor: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UINavigationBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let navBar = self.navigationController {
                self.callback(navBar.navigationBar)
            }
        }
    }
    
    var callback: (UINavigationBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavBarAccessor>) -> UIViewController {
        proxyController.callback = callback
        
        return proxyController
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<NavBarAccessor>) {
        //
    }
}

@available(iOS 14.0.0, *)
struct CustomSwiftUIView: View {

    @ObservedObject var viewModel: CustomSwiftUIViewModel
    @ObservedObject var manager = Appearance.shared.swiftuiThemeManager
    @ObservedObject var toastManager = ToastNotificationsManager.shared

    init(viewModel: CustomSwiftUIViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        let scheme = SwiftUIContentViewScheme(theme: manager.theme)
        ZToastNotificationsView(
            direction: viewModel.toastDirection,
            isAfterTouchUpdateTimer: viewModel.toastDirection == .up,
            topOffset: UIApplication.shared.statusBarFrame.height,
            bottomOffset: 64.0,
            toastsDidDisappear: {
                toastManager.model = nil
                toastManager.toastDirection = nil
            },
            content: { presenter in
            NavigationView {
                NavigationContentView(
                    navigationTitle: "Дизайн-система  «Адмирал»",
                    isShowBackButton: false
                ) {
                    ZStack {
                        scheme.backgroundColor.swiftUIColor
                        VStack {
                            Spacer()
                                .frame(height: LayoutGrid.doubleModule)
                            SearchBar(
                                $viewModel.searchBarText,
                                isResponder: $viewModel.isResponder,
                                placeholder: "Поиск"
                            )
                            .padding(.leading, LayoutGrid.doubleModule)
                            .padding(.trailing, LayoutGrid.doubleModule)
                            scrollView
                        }
                    }
                    .modifier(DismissingKeyboard())
                    .navigationBarTitleDisplayMode(.inline)
                    .previewLayout(.sizeThatFits)
                }
                .onReceive(toastManager.$toastDirection, perform: { model in
                    self.viewModel.toastDirection = model ?? .up
                })
                .onReceive(toastManager.$model, perform: { model in
                    guard let model = model else { return }

                    switch model.typeToast {
                    case .toast:
                        presenter.showView(
                            ToastView(
                                title: model.title,
                                linkText: model.linkText,
                                linkAction: {},
                                imageType: model.imageType,
                                imageColorType: model.imageType,
                                type: model.type,
                                accessibilityIdentifier: model.accessibilityIdentifier
                            )
                        )
                    case .action:
                        presenter.showView(
                            ToastView(
                                title: model.title,
                                timerDuration: model.timerDuration,
                                closeAction: {},
                                closeView: model.closeView ?? { AnyView(EmptyView()) },
                                type: model.type,
                                accessibilityIdentifier: model.accessibilityIdentifier
                            )
                        )
                    }
                })
            }
            })
        .navigationBarColor(
            backgroundColor: scheme.backgroundColor.swiftUIColor,
            titleColor: scheme.titleNavigationColor.swiftUIColor
        )
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(scheme.backButtonColor.swiftUIColor)
        .edgesIgnoringSafeArea(.all)
    }

    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(viewModel.filteredItems, id: \.self) { item in
                    NavigationLink(destination: view(for: item)) {
                        ItemSwiftUIRow(item: item)
                            .frame(height: 68)
                            .accessibilityElement()
                            .accessibilityAddTraits(.isButton)
                            .accessibility(identifier: item.title)
                    }
                }
            }
            .padding(LayoutGrid.doubleModule)
            Spacer()
                .frame(height: LayoutGrid.doubleModule * 4)
        }
    }

    // swiftlint:disable all
    @ViewBuilder
    func view(for type: SwiftUIItem) -> some View {
        switch type {
        case .themes:
            NavigationContentView(navigationTitle: "Themes", isShowThemeSwitchSwiftUIView: false) {
                ThemesViewControllerRepresentable()
            }
        case .buttons:
            ButtonsSwiftUIView()
        case .switcher:
            SwitcherSwiftUIView()
        case .radioButton:
            RadioButtonSwiftUIView()
        case .checkbox:
            CheckBoxSwiftUIView()
        case .tabs:
            TabsSwiftUIView()
        case .informers:
            InformersAndToastsSwiftUIView()
        case .textFields:
            TextFieldsSwiftUIView()
        case .calendar:
            CalendarsSwiftUIView()
        case .alert:
            AlertOnboardingSwiftUIView()
        case .toolBar:
            ToolBarSwiftUIView()
        case .cells:
            CellsSwiftUIView()
        case .shimmers:
            ShimmersSwiftUIView()
        case .tags:
            TagsChipsSwiftUIView()
        case .currency:
            CurrencySwiftUIView()
        case .badges:
            BadgesSwiftUIView()
        case .textBlocks:
            TextBlocksSwiftUIView()
        case .links:
            LinksSwiftUIView()
        case .chat:
            ChatSwiftUIView(navigationStyle: .fromMainPage)
        case .pageControls:
            PageControlsSwiftUIView()
        case .admiralGun:
            AdmiralGunView()
        case .spiner:
            SpinnerSwiftUIView()
        default:
            EmptyView()
        }
    }

}

@available(iOS 14.0.0, *)
private struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({ $0.activationState == .foregroundActive })
                        .map({ $0 as? UIWindowScene })
                        .compactMap({ $0 })
                        .first?.windows
                        .filter({ $0.isKeyWindow }).first
                keyWindow?.endEditing(true)
            }
    }
}

@available(iOS 14.0.0, *)
class SwiftUIController: UIHostingController<CustomSwiftUIView> {
    
    init() {
        super.init(rootView: CustomSwiftUIView(viewModel: CustomSwiftUIViewModel()))
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
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
