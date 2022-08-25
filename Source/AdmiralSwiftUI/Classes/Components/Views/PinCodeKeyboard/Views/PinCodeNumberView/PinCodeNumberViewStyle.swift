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
struct PinCodeNumberViewStyle: ButtonStyle {
    
    @State private var scheme: PinCodeNumberViewScheme? = nil
    @ObservedObject var schemeProvider = SwiftUISchemeProvider<PinCodeNumberViewScheme>()
    
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

