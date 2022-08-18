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

    @State private var scheme: PinCodeNumberViewScheme? = nil
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<PinCodeNumberViewScheme>()

    // MARK: - Initializer

    public init(scheme: PinCodeNumberViewScheme? = nil) {
        self.scheme = scheme
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        PinCodeNumberView(configuration: configuration, scheme: scheme)
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeNumberViewStyle {
    struct PinCodeNumberView: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        var scheme: PinCodeNumberViewScheme

        
        init(configuration: Configuration, scheme: PinCodeNumberViewScheme) {
            self.configuration = configuration
            self.scheme = scheme
        }
        
        var body: some View {
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

