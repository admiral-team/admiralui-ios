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

    private var scheme: ChatButtonScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ChatButtonScheme>()

    // MARK: - Initialiazer

    public init(scheme: ChatButtonScheme? = nil) {
        self.scheme = scheme
    }

    // MARK: - Public methods

    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return ChatButton(scheme: scheme, configuration: configuration)
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
        private let scheme: ChatButtonScheme

        // MARK: - Initializer

        init(scheme: ChatButtonScheme, configuration: Configuration) {
            self.configuration = configuration
            self.scheme = scheme
        }

        // MARK: - Layout

        var body: some View {
            let content = configuration.label.eraseToAnyView()
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
