//
//  GhostButtonWithImageStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct GhostButtonWithImageScheme: ButtonStyle, AppThemeScheme {
    
    public let font: AFont
    public var textColor = ControlParameter<AColor>()
    public var image: Image?
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        font = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }
    
    public func makeBody(configuration: GhostButtonWithImageScheme.Configuration) -> some View {
        GhostButton(
            configuration: configuration,
            font: font,
            textColor: textColor,
            image: image)
    }
}

@available(iOS 14.0.0, *)
private extension GhostButtonWithImageScheme {
    struct GhostButton: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        let font: AFont
        let textColor: ControlParameter<AColor>
        let image: Image?
        
        var body: some View {
            let color = isEnabled ?
                (configuration.isPressed ? textColor.parameter(for: .highlighted)?.swiftUIColor : textColor.parameter(for: .normal)?.swiftUIColor)
                : textColor.parameter(for: .disabled)?.swiftUIColor
            
            HStack(alignment: .center, spacing: LayoutGrid.module) {
                configuration.label
                    .font(font.swiftUIFont)
                    .foregroundColor(color)
                    .frame(height: 48.0)
                image
                    .foregroundColor(color)
            }
        }
    }
}
