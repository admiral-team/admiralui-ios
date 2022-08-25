//
//  ThemeSwitchButtonStyle.swift
//  ExampleiOS
//
//  Created on 08.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ThemeSwitchButtonStyle: ButtonStyle {

    // MARK: - Internal Properties

    @Binding var isListHidden: Bool

    // MARK: - Private properties

    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ThemeSwitchButtonScheme>()
    private var scheme: ThemeSwitchButtonScheme?

    // MARK: - Initializer

    init(isListHidden: Binding<Bool>) {
        self._isListHidden = isListHidden
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        ThemeSwitchButton(
            isListHidden: $isListHidden,
            scheme: scheme ?? schemeProvider.scheme,
            configuration: configuration
        )
    }
}

@available(iOS 14.0.0, *)
private extension ThemeSwitchButtonStyle {

    struct ThemeSwitchButton: View {

        // MARK: - Private properties

        @Binding private var isListHidden: Bool
        private let configuration: Configuration
        private let scheme: ThemeSwitchButtonScheme

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Initializer

        init(
            isListHidden: Binding<Bool>,
            scheme: ThemeSwitchButtonScheme,
            configuration: Configuration
        ) {
            self._isListHidden = isListHidden
            self.configuration = configuration
            self.scheme = scheme
        }

        // MARK: - Layout

        var body: some View {
            contentView()
        }

        // MARK: - Private methods
        
        @ViewBuilder private func contentView() -> some View {
            let imageColor = configuration.isPressed ? scheme.buttonColorSelected.swiftUIColor : scheme.imageColor.swiftUIColor
            ZStack {
                configuration.label
                    .frame(width: LayoutGrid.module * 7, height: LayoutGrid.module * 7)
                    .background(
                        Circle()
                            .fill(scheme.backgroundColor.swiftUIColor)
                            .shadow(
                                color: scheme.shadowColor.swiftUIColor,
                                radius: LayoutGrid.module
                            )
                    )
                Image(uiImage: isListHidden ? Asset.Main.ellipse.image : Asset.ActionBar.closeOutline.image)
                    .renderingMode(.template)
                    .foregroundColor(imageColor)
            }
        }
    }

}
