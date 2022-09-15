//
//  GhostButtonWithImageStyle.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 15.09.2022.
//

import AdmiralTheme
import SwiftUI
/**
 The style for creating the Ghost Button.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons with image in init GhostButtonWithImageStyle:
 # Code
 ```
 Button("Text", action: {})
 .buttonStyle(GhostButtonWithImageStyle(image: Image(name: "new")))
 ```
 */
@available(iOS 14.0.0, *)
public struct GhostButtonWithImageStyle: ButtonStyle {

    // MARK: - Public Properties

    /// Image button.
    public var image: Image?

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<GhostButtonWithImageScheme>

    // MARK: - Inializer

    public init(
        image: Image?,
        schemeProvider: SchemeProvider<GhostButtonWithImageScheme> = AppThemeSchemeProvider<GhostButtonWithImageScheme>()
    ) {
        self.image = image
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        GhostButtonWithImage(
            configuration: configuration,
            image: image,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension GhostButtonWithImageStyle {
    struct GhostButtonWithImage: View {

        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        let image: Image?

        @ObservedObject var schemeProvider: SchemeProvider<GhostButtonWithImageScheme>

        var body: some View {
            let scheme = schemeProvider.scheme
            let textPresedColor = configuration.isPressed ?
            scheme.textColor.parameter(for: .highlighted)?.swiftUIColor : scheme.textColor.parameter(for: .normal)?.swiftUIColor
            let textColor = isEnabled ? textPresedColor :
            scheme.textColor.parameter(for: .disabled)?.swiftUIColor

            let imagePressedColor = configuration.isPressed ?
            scheme.imageColor.parameter(for: .highlighted)?.swiftUIColor : scheme.imageColor.parameter(for: .normal)?.swiftUIColor

            let imageColor = isEnabled ? imagePressedColor :
            scheme.imageColor.parameter(for: .disabled)?.swiftUIColor

            HStack(alignment: .center, spacing: LayoutGrid.module) {
                configuration.label
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(textColor)
                    .frame(height: 48.0)
                image
                    .foregroundColor(imageColor)
            }
        }
    }
}

@available(iOS 14.0, *)
struct GhostButtonWithImage_Previews: PreviewProvider {

    static var previews: some View {
        Button("Text", action: {})
            .buttonStyle(GhostButtonWithImageStyle(image: nil))
    }
}

