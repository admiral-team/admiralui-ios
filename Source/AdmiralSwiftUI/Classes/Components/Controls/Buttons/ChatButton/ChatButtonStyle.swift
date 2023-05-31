//
//  ChatButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 26.11.2021.
//

import SwiftUI
import AdmiralTheme

@available(iOS 14.0.0, *)
public struct ChatButtonStyle: ButtonStyle {

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<ChatButtonScheme>

    // MARK: - Initialiazer

    public init(
        schemeProvider: SchemeProvider<ChatButtonScheme> = AppThemeSchemeProvider<ChatButtonScheme>()
    ) {
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        return ChatButton(
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

        private var schemeProvider: SchemeProvider<ChatButtonScheme>

        // MARK: - Initializer

        init(
            schemeProvider: SchemeProvider<ChatButtonScheme>,
            configuration: Configuration
        ) {
            self.configuration = configuration
            self.schemeProvider = schemeProvider
        }

        // MARK: - Layout

        var body: some View {
            let content = configuration.label.eraseToAnyView()
            let scheme = schemeProvider.scheme
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
            SymbolAssets.System.Outline.arrowRight.swiftUIImage
        })
        .buttonStyle(ChatButtonStyle())
    }

}
