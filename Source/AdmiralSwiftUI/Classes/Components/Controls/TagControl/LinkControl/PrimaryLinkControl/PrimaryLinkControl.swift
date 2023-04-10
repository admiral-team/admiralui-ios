//
//  PrimaryLinkControl.swift
//  AdmiralSwiftUI
//
//  Created on 10.11.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 PrimaryLinkControlStyle - the button style that presents button with image and text.
 You can create a PrimaryLinkControlStyle with the zero frame rectangle by specifying the following parameters in init:

 image - Image.
 text - String value.
 direction - An arrangement of text and image relative to each other.
 style - Style of view, used to change size of view.

 ## Example to create PrimaryLinkControlStyle
 # Code
 ```
 public var body: some View {
    Button(action: {}, label: {})
        .buttonStyle(PrimaryLinkControlStyle(
            image: Image(uiImage: Asset.System.Outline.arrowRightOutline.image),
            text: "Link",
            direction: .left,
            style: .medium
     ))
 }
```
 */
@available(iOS 14.0.0, *)
public struct PrimaryLinkControlStyle: ButtonStyle {

    // MARK: - Public properties

    /// The image
    public let image: Image?

    /// The text
    public let text: String?

    /// The direction
    public let direction: LinkControlDirection

    /// The style
    public let style: LinkControlStyle

    // MARK: - Private properties

    @ObservedObject private var schemeProvider: SchemeProvider<PrimaryLinkControlScheme> = AppThemeSchemeProvider<PrimaryLinkControlScheme>()

    // MARK: - Initializer

    public init(
        image: Image? = nil,
        text: String? = nil,
        direction: LinkControlDirection,
        style: LinkControlStyle,
        schemeProvider: SchemeProvider<PrimaryLinkControlScheme> = AppThemeSchemeProvider<PrimaryLinkControlScheme>()
    ) {
        self.image = image
        self.text = text
        self.direction = direction
        self.style = style
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PrimaryLinkControl(
            image: image,
            text: text,
            direction: direction,
            style: style,
            schemeProvider: schemeProvider,
            configuration: configuration
        )
    }
}

@available(iOS 14.0, *)
public enum LinkControlDirection {
    case left
    case right
}

@available(iOS 14.0, *)
public enum LinkControlStyle: Int {
    case medium
    case `default`
}

@available(iOS 14.0.0, *)
private extension PrimaryLinkControlStyle {

    struct PrimaryLinkControl: View {

        // MARK: - Public properties

        public let image: Image?
        public let text: String?
        public let direction: LinkControlDirection
        public let style: LinkControlStyle

        // MARK: - Private properties

        private let configuration: Configuration

        private var schemeProvider: SchemeProvider<PrimaryLinkControlScheme>

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Initializer

        public init(
            image: Image? = nil,
            text: String? = nil,
            direction: LinkControlDirection,
            style: LinkControlStyle,
            schemeProvider: SchemeProvider<PrimaryLinkControlScheme>,
            configuration: Configuration
        ) {
            self.image = image
            self.text = text
            self.direction = direction
            self.style = style
            self.configuration = configuration
            self.schemeProvider = schemeProvider
        }

        // MARK: - Layout

        public var body: some View {
            contentView()
        }

        // MARK: - Private methods

        @ViewBuilder private func contentView() -> some View {
            let scheme = schemeProvider.scheme
            let backgroundNormal = scheme.textColor.parameter(for: .normal)?.swiftUIColor
            let backgroundDisabled = scheme.textColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = scheme.textColor.parameter(for: .highlighted)?.swiftUIColor
            let backgroundColor = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : backgroundDisabled
            HStack {
                switch direction {
                case .left:
                    image
                    textView(scheme: scheme)
                case .right:
                    textView(scheme: scheme)
                    image
                }
            }
            .foregroundColor(backgroundColor)
        }

        @ViewBuilder private func textView(scheme: PrimaryLinkControlScheme) -> some View {
            if let text = text {
                Text(text)
                    .font(scheme.font.parameter(style: style, isEnabled: isEnabled)?.swiftUIFont)
            }
        }
    }

}

@available(iOS 14.0, *)
struct PrimaryLinkControl_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            Button(action: {}, label: {})
                .buttonStyle(PrimaryLinkControlStyle(
                    image: Image(uiImage: Asset.System.Outline.arrowRightOutline.image),
                    text: "Link",
                    direction: .left,
                    style: .medium
                ))

            Button(action: {}, label: {})
                .buttonStyle(PrimaryLinkControlStyle(
                    image: Image(uiImage: Asset.System.Outline.arrowLeftOutline.image),
                    text: "Link",
                    direction: .right,
                    style: .medium
                ))

            Button(action: {}, label: {})
                .buttonStyle(PrimaryLinkControlStyle(
                    image: Image(uiImage: Asset.System.Outline.arrowLeftOutline.image),
                    text: "Link",
                    direction: .right,
                    style: .default
                ))
        }
    }

}
