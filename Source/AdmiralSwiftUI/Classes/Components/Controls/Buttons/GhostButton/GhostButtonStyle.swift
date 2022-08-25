//
//  GhostButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.09.2021.
//

import AdmiralTheme
import SwiftUI

/**
 The style for creating the Ghost Button. Is used in cases when the main button is not enough, often goes with it in pairs when you need to designate several actions, one of which is the main one.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in three sizes: (small, medium, big) by specifying size Type in init GhostButtonStyle:
 # Code
 ```
Button("Text", action: {})
    .buttonStyle(GhostButtonStyle(sizeType: .small))
 ```
 Big - the main button, the width of which depends on the width of the screen;
 Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
 Small - changes its width depending on the content inside it, often used with the keyboard.
 
 You can create a button with an activity indicator instead of text by specifying isLoading: .constant(true) in init GhostButtonStyle. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:
 
 # Code
 ```
 Button("Text", action: {})
    .buttonStyle(GhostButtonStyle(isLoading: .constant(true)))
 ```
*/
@available(iOS 14.0.0, *)
public struct GhostButtonStyle: ButtonStyle {
    
    @Binding var isLoading: Bool
    var sizeType: ButtonSizeType?
    
    private var scheme: GhostButtonScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<GhostButtonScheme>()

    public init(
        isLoading: Binding<Bool> = .constant(false),
        sizeType: ButtonSizeType? = nil,
        scheme: GhostButtonScheme? = nil) {
        self._isLoading = isLoading
        self.sizeType = sizeType
        self.scheme = scheme
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return GhostButton(
            isLoading: $isLoading,
            scheme: scheme,
            sizeType: sizeType,
            configuration: configuration)
    }
}

@available(iOS 14.0.0, *)
private extension GhostButtonStyle {
    struct GhostButton: View {
        
        @Environment(\.isEnabled) private var isEnabled
        
        @Binding var isLoading: Bool
        
        var sizeType: ButtonSizeType?
        
        let configuration: Configuration
        
        var scheme: GhostButtonScheme
        
        init(
            isLoading: Binding<Bool>,
            scheme: GhostButtonScheme,
            sizeType: ButtonSizeType?,
            configuration: Configuration) {
            
            self.sizeType = sizeType
            self.configuration = configuration
            self._isLoading = isLoading
            self.scheme = scheme
        }
        
        var body: some View {
            let content = isLoading ?
                ActivityIndicator(style: .contrast, size: .medium).eraseToAnyView()
                : configuration.label.eraseToAnyView()
            
            switch sizeType {
            case .small, .medium, .big:
                buttonWithSize(content: content, sizeType: sizeType)
            default:
                contentButton(scheme: scheme, content: content)
                    .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                    .background(
                        Rectangle()
                            .fill(Color.clear)
                    )
            }
        }
        
        func contentButton(
            scheme: GhostButtonScheme,
            content: AnyView) -> some View {
                let normal = scheme.textColor.parameter(for: .normal)?.swiftUIColor
                let disabled = scheme.textColor.parameter(for: .disabled)?.swiftUIColor
                let highlighted = scheme.textColor.parameter(for: .highlighted)?.swiftUIColor
                
                return content
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(isEnabled ? (configuration.isPressed ? highlighted : normal) : disabled)
        }
        
        func buttonWithSize(content: AnyView, sizeType: ButtonSizeType?) -> some View  {
            return contentButton(scheme: scheme, content: content)
                .frame(maxWidth: .infinity)
                .frame(width: sizeType?.width, height: sizeType?.height)
                .background(
                    Rectangle()
                        .fill(Color.clear)
                )
        }
        
    }
}

@available(iOS 14.0, *)
struct GhostButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Button("Text", action: {})
            .buttonStyle(GhostButtonStyle(isLoading: .constant(false)))
    }
}
