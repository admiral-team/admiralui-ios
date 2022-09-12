//
//  SecondaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.09.2021.
//

import AdmiralTheme
import SwiftUI
/**
 The style for creating the Secondary Button. A secondary button, for additional actions, is used independently or in combination with other types of buttons.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in three sizes: (small, medium, big) by specifying size Type in init SecondaryButtonStyle:
 # Code
 ```
Button("Text", action: {})
    .buttonStyle(SecondaryButtonStyle(sizeType: .small))
 ```
 Big - the main button, the width of which depends on the width of the screen;
 Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
 Small - changes its width depending on the content inside it, often used with the keyboard.

 You can create a button with an activity indicator instead of text by specifying isLoading: .constant(true) in init SecondaryButtonStyle. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:

 # Code
 ```
 Button("Text", action: {})
    .buttonStyle(SecondaryButtonStyle(isLoading: .constant(true)))
 ```
*/
@available(iOS 14.0.0, *)
public struct SecondaryButtonStyle: ButtonStyle {

    // MARK: - Public Properties

    /// The loading flag
    @Binding public var isLoading: Bool

    /// The size type
    public var sizeType: ButtonSizeType?

    // MARK: - Private Properties

    @Binding private var scheme: SecondaryButtonScheme?
    @ObservedObject private var schemeProvider: SchemeProvider<SecondaryButtonScheme>

    // MARK: - Initializer

    public init(
        isLoading: Binding<Bool> = .constant(false),
        sizeType: ButtonSizeType? = nil,
        scheme: Binding<SecondaryButtonScheme?> = .constant(nil),
        schemeProvider: SchemeProvider<SecondaryButtonScheme> = AppThemeSchemeProvider<SecondaryButtonScheme>()
    ) {
        self._isLoading = isLoading
        self.sizeType = sizeType
        self._scheme = scheme
        self.schemeProvider = schemeProvider
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        SecondaryButton(
            isLoading: $isLoading,
            sizeType: sizeType,
            scheme: $scheme,
            schemeProvider: schemeProvider,
            configuration: configuration
        )
    }
}

@available(iOS 14.0.0, *)
private extension SecondaryButtonStyle {
    struct SecondaryButton: View {

        @Environment(\.isEnabled) private var isEnabled

        @Binding var isLoading: Bool
        var sizeType: ButtonSizeType?

        let configuration: Configuration

        private var schemeProvider: SchemeProvider<SecondaryButtonScheme>
        @Binding var scheme: SecondaryButtonScheme?

        // MARK: - Initializer

        init(
            isLoading: Binding<Bool>,
            sizeType: ButtonSizeType?,
            scheme: Binding<SecondaryButtonScheme?> = .constant(nil),
            schemeProvider: SchemeProvider<SecondaryButtonScheme>,
            configuration: Configuration
        ) {

            self.sizeType = sizeType
            self.configuration = configuration
            self._scheme = scheme
            self.schemeProvider = schemeProvider
            self._isLoading = isLoading
        }

        // MARK: - Body

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
            let content = isLoading ?
                ActivityIndicator(style: .contrast, size: .medium).eraseToAnyView()
                : configuration.label.eraseToAnyView()

            switch sizeType {
            case .small:
                contentButton(
                    scheme: scheme,
                    configuration: configuration,
                    isEnabled: isEnabled,
                    content: content)
                    .frame(width: sizeType?.width, height: sizeType?.height)
            case .medium:
                contentButton(
                    scheme: scheme,
                    configuration: configuration,
                    isEnabled: isEnabled,
                    content: content)
                    .frame(width: sizeType?.width, height: sizeType?.height)
            case .big:
                contentButton(
                    scheme: scheme,
                    configuration: configuration,
                    isEnabled: isEnabled,
                    content: content)
                    .frame(width: sizeType?.width, height: sizeType?.height)
            default:
                contentButton(
                    scheme: scheme,
                    configuration: configuration,
                    isEnabled: isEnabled,
                    content: content)
                    .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
            }
        }

        // MARK: - Private Methods

        private func contentButton(
            scheme: SecondaryButtonScheme,
            configuration: Configuration,
            isEnabled: Bool,
            content: AnyView) -> some View {
                let textNormal = scheme.textColor.parameter(for: .normal)?.swiftUIColor
                let textDisabled = scheme.textColor.parameter(for: .disabled)?.swiftUIColor
                let textHighlighted = scheme.textColor.parameter(for: .highlighted)?.swiftUIColor
                let text = isEnabled ? (configuration.isPressed ? textHighlighted : textNormal) : textDisabled

                let borderNormal = scheme.borderColor.parameter(for: .normal)?.swiftUIColor
                let borderDisabled = scheme.borderColor.parameter(for: .disabled)?.swiftUIColor
                let borderHighlighted = scheme.borderColor.parameter(for: .highlighted)?.swiftUIColor
                let border = (isEnabled ? (configuration.isPressed ? borderHighlighted : borderNormal) : borderDisabled) ?? .clear

            return
                content
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(text)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                    .overlay(
                        RoundedRectangle(cornerRadius: LayoutGrid.module)
                            .stroke(border, lineWidth: LayoutGrid.halfModule / 2)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: LayoutGrid.module)
                            .fill(scheme.backgroundColor.swiftUIColor)
                    )
                    .padding(LayoutGrid.halfModule / 2)

        }
    }

}

@available(iOS 14.0, *)
struct SecondaryButton_Previews: PreviewProvider {

    static var previews: some View {
        Button("Text", action: {})
            .buttonStyle(SecondaryButtonStyle(isLoading: .constant(false)))
    }
}
