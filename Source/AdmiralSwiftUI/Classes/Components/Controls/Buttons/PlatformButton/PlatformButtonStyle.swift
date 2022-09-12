//
//  PlatformButtonStyle.swift
//  AdmiralUIResources
//
//  Created on 05.07.2022.
//

import AdmiralTheme
import SwiftUI
/**
 The style for creating the Primary Button.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in three sizes: (small, medium, big) by specifying size Type in init PrimaryButtonStyle:
 # Code
 ```
 Button("Text", action: {})
 .buttonStyle(PrimaryButtonStyle(sizeType: .small))
 ```
 Big - the main button, the width of which depends on the width of the screen;
 Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
 Small - changes its width depending on the content inside it, often used with the keyboard.

 You can create a button with an activity indicator instead of text by specifying isLoading: .constant(true) in init PrimaryButtonStyle. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:

 You can add accessibilityIdentifier (a string that identifies the element) in PrimaryButtonStyle

 # Code
 ```
 Button("Text", action: {})
 .buttonStyle(PrimaryButtonStyle(isLoading: .constant(true)))
 ```
 */
@available(iOS 14.0.0, *)
public struct PlatformButtonStyle: ButtonStyle {

    // MARK: - Private Properties

    private var accessibilityIdentifier: String?

    @Binding private var scheme: PlatformButtonScheme?

    // MARK: - Initializer

    public init(
        scheme: Binding<PlatformButtonScheme?> = .constant(nil),
        accessibilityIdentifier: String? = nil
    ) {
        self._scheme = scheme
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryButton(
            scheme: $scheme,
            configuration: configuration,
            accessibilityIdentifier: accessibilityIdentifier
        )
    }
}

@available(iOS 14.0.0, *)
private extension PlatformButtonStyle {
    struct PrimaryButton: View {

        // MARK: - Private Properties

        @Environment(\.isEnabled) private var isEnabled
        private var accessibilityIdentifier: String?

        // MARK: - Internal Properties

        let configuration: Configuration
        @Binding private var scheme: PlatformButtonScheme?

        @ObservedObject private var schemeProvider = AppThemeSchemeProvider<PlatformButtonScheme>()

        init(
            scheme: Binding<PlatformButtonScheme?> = .constant(nil),
            configuration: Configuration,
            accessibilityIdentifier: String? = nil
        ) {

            self.configuration = configuration
            self._scheme = scheme
            self.accessibilityIdentifier = accessibilityIdentifier
        }

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
            let backgroundNormal = scheme.buttonBackgroundColor.parameter(for: .normal)?.swiftUIColor
            let backgroundDisabled = scheme.buttonBackgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = scheme.buttonBackgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : backgroundDisabled

            ZStack {
                RoundedRectangle(cornerRadius: LayoutGrid.module)
                    .fill(scheme.backgroundColor.swiftUIColor)
                    .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)

                contentButton(scheme: scheme, content: lable(scheme: scheme).eraseToAnyView())
                    .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                    .background(
                        RoundedRectangle(cornerRadius: LayoutGrid.module)
                            .foregroundColor(background)
                    )
            }
        }

        private func lable(scheme: PlatformButtonScheme) -> some View {
            configuration.label.accessibilityIdentifier(PlatformButtonAccessibilityIdentifiers.lable
                .accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
            .foregroundColor(scheme.textColor.parameter(for: .normal)?.swiftUIColor)
        }

        private func contentButton(
            scheme: PlatformButtonScheme,
            content: AnyView
        ) -> some View {
                let textNormal = scheme.textColor.parameter(for: .normal)?.swiftUIColor

                return content
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(textNormal)
                    .frame(maxWidth: .infinity)
            }
    }

}
