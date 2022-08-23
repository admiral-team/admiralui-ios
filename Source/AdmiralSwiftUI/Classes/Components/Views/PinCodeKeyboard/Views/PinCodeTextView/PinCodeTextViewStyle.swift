//
//  PinCodeTextViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

/**
 PinCodeTextViewStyle - the button style that creates PinCodeTextView.

 ## Example to create PinCodeTextViewStyle:
 # Code
 ```
 Button(action: {}, label: {})
    .buttonStyle(PinCodeNumberViewStyle())
 ```
*/
@available(iOS 14.0.0, *)
public struct PinCodeTextViewStyle: ButtonStyle {

    // MARK: - Properties

    @Binding private var scheme: PinCodeTextViewScheme?

    // MARK: - Initializer

    public init(scheme: Binding<PinCodeTextViewScheme?> = .constant(nil)) {
        self._scheme = scheme
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        PinCodeTextView(configuration: configuration, scheme: $scheme)
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeTextViewStyle {
    struct PinCodeTextView: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration

        @ObservedObject var schemeProvider = AppThemeSchemeProvider<PinCodeTextViewScheme>()
        @Binding var scheme: PinCodeTextViewScheme?

        init(
            configuration: Configuration,
            scheme: Binding<PinCodeTextViewScheme?> = .constant(nil)
        ) {
            self.configuration = configuration
            self._scheme = scheme
        }

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
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
