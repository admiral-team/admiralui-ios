//
//  PinCodeNumberViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PinCodeNumberViewStyle: ButtonStyle {

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<PinCodeNumberViewScheme>

    // MARK: - Initializer

    public init(schemeProvider: SchemeProvider<PinCodeNumberViewScheme> = AppThemeSchemeProvider<PinCodeNumberViewScheme>()) {
        self.schemeProvider = schemeProvider
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        PinCodeNumberView(
            configuration: configuration,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeNumberViewStyle {
    struct PinCodeNumberView: View {

        // MARK: - Internal Properties

        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration

        // MARK: - Private Properties

        private var schemeProvider: SchemeProvider<PinCodeNumberViewScheme>

        // MARK: - Initializer

        init(configuration: Configuration, schemeProvider: SchemeProvider<PinCodeNumberViewScheme>) {
            self.configuration = configuration
            self.schemeProvider = schemeProvider
        }

        // MARK: - Body
        
        var body: some View {
            let scheme = schemeProvider.scheme
            configuration.label
                .font(scheme.textFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .frame(width: 60, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 30.0)
                            .foregroundColor(configuration.isPressed
                                                ? scheme.backgroundColor.parameter(for: .highlighted)?.swiftUIColor
                                                : scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor)
                )
        }
        
    }
}

