//
//  PrimaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 08.09.2021.
//

import AdmiralTheme
import SwiftUI

/**
 The style for creating the Primary Button.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in three sizes: (small, medium, big) by specifying size Type in init PrimaryButtonStyle:
 # Code
 ```
Button("Text", action: {})
    .buttonStyle(PrimaryButtonStyle(sizeType: .small))
 ```
 Big - the main button, the width of which depends on the width of the screen;
 Medium - an additional button of a smaller size, the button does not change its size depending on the width of the screen;
 Small - changes its width depending on the content inside it, often used with the keyboard.
 
 You can create a button with an activity indicator instead of text by specifying isLoading: .constant(true) in init PrimaryButtonStyle. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:
 
 You can add accessibilityIdentifier (a string that identifies the element) in PrimaryButtonStyle
 
 # Code
 ```
 Button("Text", action: {})
    .buttonStyle(PrimaryButtonStyle(isLoading: .constant(true)))
 ```
*/
@available(iOS 14.0.0, *)
public struct PrimaryButtonStyle: ButtonStyle {
    
    @Binding var isLoading: Bool
    
    var sizeType: ButtonSizeType?
    
    // MARK: - Private Properties
    
    private var scheme: PrimaryButtonScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<PrimaryButtonScheme>()
    private var accessibilityIdentifier: String?

    public init(
        isLoading: Binding<Bool> = .constant(false),
        sizeType: ButtonSizeType? = nil,
        scheme: PrimaryButtonScheme? = nil,
        accessibilityIdentifier: String? = nil) {
        self._isLoading = isLoading
        self.sizeType = sizeType
        self.scheme = scheme
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        PrimaryButton(
            isLoading: $isLoading,
            sizeType: sizeType,
            scheme: scheme,
            configuration: configuration,
            accessibilityIdentifier: accessibilityIdentifier)
    }
}

@available(iOS 14.0.0, *)
private extension PrimaryButtonStyle {
    struct PrimaryButton: View {
        
        // MARK: - Private Properties
        
        @Environment(\.isEnabled) private var isEnabled
        private var accessibilityIdentifier: String?
        
        // MARK: - Internal Properties
        
        @Binding var isLoading: Bool
        var sizeType: ButtonSizeType?

        
        let configuration: Configuration
        var scheme: PrimaryButtonScheme
        
        init(
            isLoading: Binding<Bool>,
            sizeType: ButtonSizeType?,
            scheme: PrimaryButtonScheme,
            configuration: Configuration,
            accessibilityIdentifier: String? = nil) {
            
            self.configuration = configuration
            self.sizeType = sizeType
            self.scheme = scheme
            self._isLoading = isLoading
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        
        var body: some View {
            let content = isLoading ?
                activityIndicator().eraseToAnyView()
                : lable().eraseToAnyView()
            
            let backgroundNormal = scheme.buttonBackgroundColor.parameter(for: .normal)?.swiftUIColor
            let backgroundDisabled = scheme.buttonBackgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = scheme.buttonBackgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : backgroundDisabled
            
            switch sizeType {
            case .small, .medium, .big:
                ZStack {
                    RoundedRectangle(cornerRadius: LayoutGrid.module)
                        .fill(scheme.backgroundColor.swiftUIColor)
                        .frame(width: sizeType?.width, height: sizeType?.height)
                    
                    contentButton(scheme: scheme, content: content)
                        .frame(width: sizeType?.width, height: sizeType?.height)
                        .background(
                            RoundedRectangle(cornerRadius: LayoutGrid.module)
                                .foregroundColor(background)
                        )
                }
                
            default:
                ZStack {
                    RoundedRectangle(cornerRadius: LayoutGrid.module)
                        .fill(scheme.backgroundColor.swiftUIColor)
                        .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                    
                    contentButton(scheme: scheme, content: content)
                        .frame(minHeight: LayoutGrid.halfModule * 10, idealHeight: LayoutGrid.module * 6, maxHeight: LayoutGrid.module * 6)
                        .background(
                            RoundedRectangle(cornerRadius: LayoutGrid.module)
                                .foregroundColor(background)
                        )
                }
            }
            
        }
        
        func activityIndicator() -> some View {
            ActivityIndicator(style: .default, size: .medium).accessibilityIdentifier(PrimaryButtonAccessibilityIdentifiers.activityIndicator
                                                                                        .accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
        }
        
        func lable() -> some View {
            configuration.label.accessibilityIdentifier(PrimaryButtonAccessibilityIdentifiers.lable
                                                            .accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                .foregroundColor(scheme.textColor.parameter(for: .normal)?.swiftUIColor)
        }
        
        func contentButton(
            scheme: PrimaryButtonScheme,
            content: AnyView) -> some View {
            let textNormal = scheme.textColor.parameter(for: .normal)?.swiftUIColor
            let textDisabled = scheme.textColor.parameter(for: .disabled)?.swiftUIColor
            let text = isEnabled ? textNormal : textDisabled
            
            return content
                .font(scheme.font.swiftUIFont)
                .foregroundColor(text)
                .frame(maxWidth: .infinity)
        }
    }
    
}

@available(iOS 14.0, *)
struct PrimaryButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Button("Text", action: {})
            .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false)))
    }
}
