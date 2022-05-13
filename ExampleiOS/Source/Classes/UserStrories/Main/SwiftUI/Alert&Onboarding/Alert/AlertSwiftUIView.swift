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

    // MARK: - Properties

    @StateObject private var viewModel = AlertSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<AlertCustomScheme>()

    // MARK: - Layout

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(
            navigationTitle: viewModel.navigationTitle,
            isShowThemeSwitchSwiftUIView: !viewModel.show
        ) {
            scheme.backgroundColor.swiftUIColor
            ZStack {
                infoView
                alertView
            }
            .background(viewModel.show ? Color(scheme.backBackgroundColor.uiColor) : Color(scheme.backgroundColor.uiColor))
            .animation(.easeInOut(duration: Durations.Default.double))
        }
    }

    // MARK: - Private Properties
    
    private var infoView: some View {
        let scheme = schemeProvider.scheme
        return VStack {
            Text(viewModel.description)
                .multilineTextAlignment(.leading)
                .font(scheme.descriptionLabelFont.swiftUIFont)
                .foregroundColor(scheme.descriptionLabelTextColor.swiftUIColor)
            
            SwiftUI.Button("Показать Alert", action: { [weak viewModel] in
                viewModel?.show.toggle()
            })
                .buttonStyle(GhostButtonStyle())
            Spacer()
        }
        .padding(.top)
        .animation(nil)
    }
    
    private var alertView: some View {
        AlertView(
            image: Image(Asset.PopUp.popUpImage.name),
            title: viewModel.alertTitle,
            message: viewModel.alertMessage,
            buttonTitle: viewModel.alertButtonTitle,
            buttonAction: { [weak viewModel] in
                viewModel?.show.toggle()
            }
        )
        .padding()
        .opacity(viewModel.show ? 1 : 0)
    }
}

@available(iOS 14.0, *)
struct AlertSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlertSwiftUIView()
    }
}
