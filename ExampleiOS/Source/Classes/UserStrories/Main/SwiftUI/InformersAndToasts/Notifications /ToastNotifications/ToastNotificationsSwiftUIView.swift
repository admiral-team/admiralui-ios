//
//  ToastNotificationsSwiftUIView.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ToastNotificationsSwiftUIView: View {

    @State var isShow: Bool = false
    @State var toastView: ToastView?
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ToastNotificationsSwiftUIViewScheme>()
    private let toastManager = ToastNotificationsManager.shared
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Toast") {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            
            // swiftlint:disable line_length
            ScrollView {
                LazyVStack(alignment: .center) {
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    Text("Компонент появляется в верхней части страницы на мобильных девайсах и справа в верхней части страницы на планшетах только внутри приложения, автоматически исчезает по таймауту, по свайпу вверх или по нажатию на иконку закрытия если она присутствует.\n\nКомпонентов на странице может быть несколько, если они приходят одновременно наслаиваясь друг на друга и исчезают по собственному таймауту. При тапу на группу таких уведомлений они раскрываются в список.")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    SwiftUI.Button("Показать Toast") {
                        isShow.toggle()
                        toastManager.toastDirection = .up
                        toastManager.model = ToastNotificationsViewModel(
                            title: "At breakpoint boundaries, mini units divide the screen into a fixed master grid.",
                            linkText: "Link Text",
                            imageType: isShow ? .info : .error,
                            type: isShow ? .default : .error)
                    }
                    .buttonStyle(GhostButtonStyle())
                }
                .padding(LayoutGrid.doubleModule)
            }
            .padding(.horizontal, LayoutGrid.doubleModule)
        }
    }
    
}
