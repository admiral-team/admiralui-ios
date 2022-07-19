//
//  AlertSwiftUIView.swift
//  ExampleiOS
//
//  Created on 11.01.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)

struct AlertSwiftUIView: View {
    // swiftlint:disable all
    @State private var show = false
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<AlertCustomScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Alert", isShowThemeSwitchSwiftUIView: !show) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                infoView
                alertView
            }
            .background(show ? Color(scheme.backBackgroundColor.uiColor) : Color(scheme.backgroundColor.uiColor))
        }
    }
    
    private var infoView: some View {
        let scheme = schemeProvider.scheme
        return VStack {
            Text("Всплывающие окна поверх контента, часто содержат короткое информирующее сообщение, иллюстрацию и кнопки основгого или альтернативного действия. Для вызова Alert, нажмите кнопку")
                .multilineTextAlignment(.leading)
                .font(scheme.descriptionLabelFont.swiftUIFont)
                .foregroundColor(scheme.descriptionLabelTextColor.swiftUIColor)
            
            SwiftUI.Button("Показать Alert", action: {
                withAnimation(.easeInOut(duration: Durations.Default.double)) {
                    self.show.toggle()
                }
            })
            .buttonStyle(GhostButtonStyle())
            Spacer()
        }
        .padding(.top)
    }
    
    private var alertView: some View {
        AlertView(image: Image(Asset.PopUp.popUpImage.name),
                  title: "Header",
                  message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  buttonTitle: "Хорошо",
                  buttonAction: {
                    withAnimation(.easeInOut(duration: Durations.Default.double)) {
                        self.show.toggle()
                    }
                },
                  additionalButtonTitle: "Отмена",
                  additionalButtonAction: {
                    withAnimation(.easeInOut(duration: Durations.Default.double)) {
                        self.show.toggle()
                    }
                  })
            .padding()
            .opacity(show ? 1 : 0)
    }
}

@available(iOS 14.0, *)
struct AlertSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlertSwiftUIView()
    }
}
