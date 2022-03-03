//
//  NavigationBarModifier.swift
//  ExampleiOS
//
//  Created on 24.05.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
// TODO: - Fix navigation bar for swiftui
struct NavigationBarModifier: ViewModifier {

    public var backgroundColor: UIColor?
    public var titleColor: UIColor?

    public init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    public func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

@available(iOS 14.0, *)
extension View {

    func navigationBarColor(backgroundColor: Color?, titleColor: Color?) -> some View {
        self.modifier(NavigationBarModifier(
                        backgroundColor: UIColor(backgroundColor ?? Color.clear),
                        titleColor: UIColor(titleColor ?? Color.clear)))
    }

}
