//
//  PrimaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.09.2021.
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
public struct PrimaryButtonStyle: ButtonStyle {

    // MARK: - Public Properties

    /// The loading flag
    @Binding public var isLoading: Bool

    /// The size type
    public var sizeType: ButtonSizeType?

    // MARK: - Private Properties

    private var accessibilityIdentifier: String?

    @ObservedObject private var schemeProvider: SchemeProvider<PrimaryButtonScheme>

    // MARK: - Initializer

    public init(
        isLoading: Binding<Bool> = .constant(false),
        sizeType: ButtonSizeType? = nil,
        schemeProvider: SchemeProvider<PrimaryButtonScheme> = AppThemeSchemeProvider<PrimaryButtonScheme>(),
        accessibilityIdentifier: String? = nil
    ) {
        self._isLoading = isLoading
        self.sizeType = sizeType
        self.schemeProvider = schemeProvider
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryButton(
            isLoading: $isLoading,
            sizeType: sizeType,
            configuration: configuration,
            accessibilityIdentifier: accessibilityIdentifier,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension PrimaryButtonStyle {
    struct PrimaryButton: View {

        // MARK: - Private Properties

        @Environment(\.isEnabled) private var isEnabled
        private var accessibilityIdentifier: String?

        // MARK: - Internal Properties

        @Binding var isLoading: Bool
        var sizeType: ButtonSizeType?

        let configuration: Configuration

        private var schemeProvider: SchemeProvider<PrimaryButtonScheme>

        init(
            isLoading: Binding<Bool>,
            sizeType: ButtonSizeType?,
            configuration: Configuration,
            accessibilityIdentifier: String? = nil,
            schemeProvider: SchemeProvider<PrimaryButtonScheme>
        ) {
            self.configuration = configuration
            self.sizeType = sizeType
            self.schemeProvider = schemeProvider
            self._isLoading = isLoading
            self.accessibilityIdentifier = accessibilityIdentifier
        }

        var body: some View {
            let scheme = schemeProvider.scheme
            let content = isLoading ?
            activityIndicator().eraseToAnyView()
            : lable(scheme: scheme).eraseToAnyView()

            let backgroundNormal = scheme.buttonBackgroundColor.parameter(for: .normal)?.swiftUIColor
            let backgroundDisabled = scheme.buttonBackgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = scheme.buttonBackgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : backgroundDisabled

            switch sizeType {
            case .small, .medium, .big:
                ZStack {
                    RoundedRectangle(cornerRadius: LayoutGrid.module)
                        .fill(scheme.backgroundColor.swiftUIColor)
                        .frame(width: sizeType?.width, height: sizeType?.height)

                    contentButton(scheme: scheme, content: content)
                        .frame(width: sizeType?.width, height: sizeType?.height)
                        .background(
                            RoundedRectangle(cornerRadius: LayoutGrid.module)
                                .foregroundColor(background)
                        )
                }

            default:
                ZStack {
                    RoundedRectangle(cornerRadius: LayoutGrid.module)
                        .fill(scheme.backgroundColor.swiftUIColor)
                        .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)

                    contentButton(scheme: scheme, content: content)
                        .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                        .background(
                            RoundedRectangle(cornerRadius: LayoutGrid.module)
                                .foregroundColor(background)
                        )
                }
            }

        }

        func activityIndicator() -> some View {
            ActivityIndicator(
                style: .default,
                size: .medium
            ).accessibilityIdentifier(
                PrimaryButtonAccessibilityIdentifiers
                    .activityIndicator
                    .accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier)
            )
        }

        func lable(scheme: PrimaryButtonScheme) -> some View {
            let textColor = isEnabled ? scheme.textColor.parameter(for: .normal)?.swiftUIColor : scheme.textColor.parameter(for: .disabled)?.swiftUIColor
            return configuration.label.accessibilityIdentifier(
                PrimaryButtonAccessibilityIdentifiers
                    .lable
                    .accessibilityViewIdentifier(
                        accessibilityIdentifier: accessibilityIdentifier
                    )
            )
                .foregroundColor(textColor)
        }

        func contentButton(
            scheme: PrimaryButtonScheme,
            content: AnyView
        ) -> some View {
            let textNormal = scheme.textColor.parameter(for: .normal)?.swiftUIColor
            let textDisabled = scheme.textColor.parameter(for: .disabled)?.swiftUIColor
            let text = isEnabled ? textNormal : textDisabled

            return content
                .font(scheme.font.swiftUIFont)
                .foregroundColor(text)
                .frame(maxWidth: .infinity)
        }
    }

}

@available(iOS 14.0, *)
struct PrimaryButton_Previews: PreviewProvider {

    static var previews: some View {
        Button("Text", action: {})
            .buttonStyle(
                PrimaryButtonStyle(
                    isLoading: .constant(false),
                    schemeProvider: .constant(scheme: PrimaryButtonScheme(theme: .default))
                )
            )
    }
}
