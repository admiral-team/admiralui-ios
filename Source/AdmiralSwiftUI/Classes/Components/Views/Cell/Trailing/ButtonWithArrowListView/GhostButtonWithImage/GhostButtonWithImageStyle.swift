//
//  GhostButtonWithImageStyle.swift
//  AdmiralSwiftUI
//
//  Created on 14.09.2022.
//

import AdmiralTheme
import SwiftUI

@available(iOS 14.0.0, *)
public struct GhostButtonWithImageStyle: ButtonStyle {

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<GhostButtonWithImageScheme>
    private var image: Image?

    // MARK: - Initializer

    public init(
        schemeProvider: SchemeProvider<GhostButtonWithImageScheme> = AppThemeSchemeProvider<GhostButtonWithImageScheme>(),
        image: Image?
    ) {
        self.schemeProvider = schemeProvider
        self.image = image
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        GhostButton(
            configuration: configuration,
            image: image,
            schemeProvider: schemeProvider
        )
    }
    
}

@available(iOS 14.0.0, *)
private extension GhostButtonWithImageStyle {
    struct GhostButton: View {

        // MARK: - Internal Properties
        
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        let image: Image?
        let schemeProvider: SchemeProvider<GhostButtonWithImageScheme>

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let color = isEnabled ?
            (configuration.isPressed ? scheme.textColor.parameter(for: .highlighted)?.swiftUIColor : scheme.textColor.parameter(for: .normal)?.swiftUIColor)
            : scheme.textColor.parameter(for: .disabled)?.swiftUIColor

            HStack(alignment: .center, spacing: LayoutGrid.module) {
                configuration.label
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(color)
                    .frame(height: 48.0)
                image
                    .foregroundColor(color)
            }
        }
    }
}
