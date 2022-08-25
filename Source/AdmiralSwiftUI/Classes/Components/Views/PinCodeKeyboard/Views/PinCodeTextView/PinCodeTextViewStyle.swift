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

@available(iOS 14.0.0, *)
struct PinCodeTextViewStyle: ButtonStyle {
    
    @State private var scheme: PinCodeTextViewScheme? = nil
    @ObservedObject var schemeProvider = SwiftUISchemeProvider<PinCodeTextViewScheme>()
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        PinCodeTextView(configuration: configuration, scheme: scheme)
    }
}

@available(iOS 14.0.0, *)
private extension PinCodeTextViewStyle {
    struct PinCodeTextView: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        var scheme: PinCodeTextViewScheme
        
        init(configuration: Configuration, scheme: PinCodeTextViewScheme) {
            self.configuration = configuration
            self.scheme = scheme
        }
        
        var body: some View {
            
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

