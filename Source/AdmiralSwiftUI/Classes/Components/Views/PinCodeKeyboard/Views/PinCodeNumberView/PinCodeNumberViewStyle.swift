//
//  PinCodeNumberViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinCodeNumberViewStyle - the button style that creates PinCodeNumberView.

 ## Example to create PinCodeNumberViewStyle:
 # Code
 ```
 Button(action: {}, label: {})
    .buttonStyle(PinCodeNumberViewStyle())
 ```
*/
@available(iOS 14.0.0, *)
public struct PinCodeNumberViewStyle: ButtonStyle {

    // MARK: - Properties

    @Binding private var scheme: PinCodeNumberViewScheme?

    // MARK: - Initializer

    public init(
        scheme: Binding<PinCodeNumberViewScheme?> = .constant(nil)
    ) {
        self._scheme = scheme
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PinCodeNumberView(configuration: configuration, scheme: $scheme)
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeNumberViewStyle {
    struct PinCodeNumberView: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration

        @Binding var scheme: PinCodeNumberViewScheme?
        @ObservedObject var schemeProvider = AppThemeSchemeProvider<PinCodeNumberViewScheme>()

        // MARK: - Initializer

        init(
            configuration: Configuration,
            scheme: Binding<PinCodeNumberViewScheme?>
        ) {
            self.configuration = configuration
            self._scheme = scheme
        }

        // MARK: - Body

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
            configuration.label
                .font(scheme.textFont.swiftUIFont)
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

