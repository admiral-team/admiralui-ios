//
//  ChatButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 26.11.2021.
//

import SwiftUI
import AdmiralUIResources
import AdmiralTheme

@available(iOS 14.0.0, *)
public struct ChatButtonStyle: ButtonStyle {

    // MARK: - Private Properties

    @Binding private var scheme: ChatButtonScheme?
    @ObservedObject private var schemeProvider: SchemeProvider<ChatButtonScheme>

    // MARK: - Initialiazer

    public init(
        scheme: Binding<ChatButtonScheme?> = .constant(nil),
        schemeProvider: SchemeProvider<ChatButtonScheme> = AppThemeSchemeProvider<ChatButtonScheme>()
    ) {
        self._scheme = scheme
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        return ChatButton(
            scheme: $scheme,
            schemeProvider: schemeProvider,
            configuration: configuration
        )
    }
}


@available(iOS 14.0.0, *)
private extension ChatButtonStyle {
    struct ChatButton: View {

        // MARK: - Constants

        private enum Constants {
            static let buttonSpacing: CGFloat = .zero
        }

        // MARK: - Private properties

        @Environment(\.isEnabled) private var isEnabled
        private let configuration: Configuration

        @Binding private var scheme: ChatButtonScheme?
        private var schemeProvider: SchemeProvider<ChatButtonScheme>

        // MARK: - Initializer

        init(
            scheme: Binding<ChatButtonScheme?> = .constant(nil),
            schemeProvider: SchemeProvider<ChatButtonScheme>,
            configuration: Configuration
        ) {
            self.configuration = configuration
            self._scheme = scheme
            self.schemeProvider = schemeProvider
        }

        // MARK: - Layout

        var body: some View {
            let content = configuration.label.eraseToAnyView()
            let scheme = self.scheme ?? schemeProvider.scheme
            contentView(content: content, scheme: scheme)
        }

        // MARK: - Private methods

        private func contentView(content: AnyView, scheme: ChatButtonScheme) -> some View {
            let normal = scheme.buttonColor.parameter(for: .normal)?.swiftUIColor
            let disabled = scheme.buttonColor.parameter(for: .disabled)?.swiftUIColor
            let selected = scheme.buttonColor.parameter(for: .selected)?.swiftUIColor
            return content
                .foregroundColor(scheme.sendButtonColor.swiftUIColor)
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.halfModule * 10)
                .background(isEnabled ? (configuration.isPressed ? selected : normal) : disabled)
                .cornerRadius(LayoutGrid.module)
        }

    }

}

@available(iOS 14.0, *)
struct ChatButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        Button(action: {}, label: {
            AssetSymbol.System.Outline.arrowRight.image
        })
        .buttonStyle(ChatButtonStyle())
    }

}
