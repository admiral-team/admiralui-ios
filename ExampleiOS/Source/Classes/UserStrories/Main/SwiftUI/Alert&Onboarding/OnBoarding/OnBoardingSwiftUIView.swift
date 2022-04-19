//
//  OnboardingSwiftUIView.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 08.04.2022.
//
// swiftlint:disable all

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct OnBoardingSwiftUIView: View {
    
    var onBoardingModels = [UIHostingController(rootView: OnBoardingPageUIView(
                                    title: "Добро\nпожаловать!",
                                    subtitle: "Приветствуем вас в нашем мобильном приложении.  Это приложение служит удобным инструментом для всех участников команд!",
                                    imageName: Asset.Onboarding.one.name)),
                                    UIHostingController(rootView: OnBoardingPageUIView(
                                    title: "Что внутри приложения",
                                    subtitle: "В приложении есть набор всех стилей и компонентов UI kit 3.0 Mobile, который вы сможете протестировать в реальном времени.",
                                    imageName: Asset.Onboarding.two.name)),
                                    UIHostingController(rootView: OnBoardingPageUIView(
                                    title: "Ждем ваших\n👍🏽",
                                    subtitle: "Мы рады любому фидбеку и активно ведем непрерывную работу над дизайн-системой.\nВсе наши контакты находятся в разделе “Инфо”.",
                                    imageName: Asset.Onboarding.three.name))]
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<OnBoardingCustomScheme>()
    @State private var currentPageIndex: Int = 0
    @State private var circlePageIndex: Int = 1
    
    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Onboarding") {
            VStack(spacing: 0) {
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: onBoardingModels)
                
                Spacer()
                
                SwiftUI.Button(action: {}, label: {})
                    .buttonStyle(
                        CirclePageControlStyle(
                            step: $circlePageIndex,
                            totalPages: onBoardingModels.count,
                            style: .default
                        )
                    )
                Spacer()
                    .frame(height: LayoutGrid.module * 11)
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .background(scheme.backgroundColor.swiftUIColor)
            .onChange(of: currentPageIndex) { newValue in
                circlePageIndex = newValue + 1
            }
            .onChange(of: circlePageIndex) { newValue in
                currentPageIndex = newValue - 1
            }
        }
    }
}

@available(iOS 14.0, *)
struct OnBoardingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSwiftUIView()
    }
}
