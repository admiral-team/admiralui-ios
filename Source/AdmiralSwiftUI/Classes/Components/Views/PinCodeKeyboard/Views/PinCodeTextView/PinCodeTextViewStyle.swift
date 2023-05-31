//
//  PinCodeTextViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import Combine
import AdmiralTheme

@available(iOS 14.0.0, *)
public struct PinCodeTextViewStyle: ButtonStyle {

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<PinCodeTextViewScheme>

    // MARK: - Initializer

    public init(
        schemeProvider: SchemeProvider<PinCodeTextViewScheme> = AppThemeSchemeProvider<PinCodeTextViewScheme>()
    ) {
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PinCodeTextView(
            configuration: configuration,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeTextViewStyle {
    struct PinCodeTextView: View {

        // MARK: - Internal Properties

        let configuration: Configuration

        // MARK: - Private Properties

        @Environment(\.isEnabled) private var isEnabled

        private var schemeProvider: SchemeProvider<PinCodeTextViewScheme>

        // MARK: - Initializer

        init(configuration: Configuration, schemeProvider: SchemeProvider<PinCodeTextViewScheme>) {
            self.configuration = configuration
            self.schemeProvider = schemeProvider
        }

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            configuration.label
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(scheme.textFont.swiftUIFont)
                .frame(minWidth: 60.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(scheme.textColor.swiftUIColor)
                .background(
                    RoundedRectangle(cornerRadius: 30.0)
                        .foregroundColor(scheme.backgroundColor.swiftUIColor)
                )
        }
        
    }
}

