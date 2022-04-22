//
//  ActionNotificationSwiftUIView.swift
//  ExampleiOS
//
//  Created on 07.10.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ActionNotificationSwiftUIView: View {

    @State var isShow: Bool = false
    @State var toastView: ToastView?
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ToastNotificationsSwiftUIViewScheme>()
    private let toastManager = ToastNotificationsManager.shared
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Action", isShowThemeSwitchSwiftUIView: false) {
            scheme.backgroundColor.swiftUIColor
                .edgesIgnoringSafeArea(.all)
            
            // swiftlint:disable line_length
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .center) {
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    Text("Компонент используется для отмены совершенного действия, появляется внизу экрана поверх контента с обратным отсчетом времени в 5 секунд сразу после совершения какого-либо действия.")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    Spacer()
                        .frame(height: LayoutGrid.quadrupleModule)
                    SwiftUI.Button("Показать Action") {
                        isShow.toggle()
                        toastManager.toastDirection = .down
                        toastManager.model = ToastNotificationsViewModel(
                            typeToast: .action,
                            title: "Сообщение будет удалено",
                            imageType: .info,
                            type: .default,
                            timerDuration: 5,
                            closeView: { AnyView(Text("Отмена")) })
                    }
                    .buttonStyle(GhostButtonStyle())
                }
                .padding(LayoutGrid.doubleModule)
            }
            .padding(.horizontal, LayoutGrid.doubleModule)
        }
    }
    
}
