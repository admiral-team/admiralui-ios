//
//  CustomSwitch.swift
//  AdmiralUIResources
//
//  Created on 08.04.2021.
//

import AdmiralTheme
import SwiftUI
/**
 A custom control that toggles between on and off states.
 
 To configure the current toggle style for a view hierarchy, use the toggleStyle(_:) modifier.
 You can create CustomSwitch in the Default, Active states.
 
 ## Example for the Active state:
 # Code
 ```
 @State private var isOn: Bool = true
 
 public var body: some View {
    CustomSwitch(isOn: $isCustomSwitchOn)
 }
 ```
 You can also specify two additional states Disabled and Disabled Active using the disabled modifier
 
 ## Example for the Active state:
 # Code
 ```
 @State private var isOn: Bool = true
 CustomSwitch(isOn: $isCustomSwitchOn)
            .disabled(false)
 ```
 */
@available(iOS 14.0, *)
public struct CustomSwitch: View {
    
    // MARK: - Internal Properties
        
    @Binding var isOn: Bool
    
    // MARK: - Private Properties
    
    @Binding private var scheme: CustomSwitchScheme?
    
    // MARK: - Initializer
    
    public init(
        isOn: Binding<Bool>,
        scheme: Binding<CustomSwitchScheme?> = .constant(nil)
    ) {
        self._isOn = isOn
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        Toggle(isOn: $isOn, label: {})
            .labelsHidden()
            .toggleStyle(CustomSwitchStyle(scheme: $scheme))
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: Binding<CustomSwitchScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
private struct CustomSwitchStyle: ToggleStyle {

    // MARK: - Private Properties

    @Binding private var scheme: CustomSwitchScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CustomSwitchScheme>()

    // MARK: - Inializer

    public init(
        scheme: Binding<CustomSwitchScheme?> = .constant(nil)
    ) {
        self._scheme = scheme
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme

        Toggle(configuration)
            .foregroundColor(scheme.textColor.swiftUIColor)
            .font(scheme.font.swiftUIFont)
            .toggleStyle(
                SwitchToggleStyle(
                    tint: scheme.onTintColorColor.swiftUIColor
                )
            )
    }

}
