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
    
    @ObservedObject private var schemeProvider: SchemeProvider<CustomSwitchScheme>
    
    // MARK: - Initializer
    
    public init(
        isOn: Binding<Bool>,
        schemeProvider: SchemeProvider<CustomSwitchScheme> = AppThemeSchemeProvider<CustomSwitchScheme>()
    ) {
        self._isOn = isOn
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        Toggle(isOn: $isOn, label: {})
            .labelsHidden()
            .toggleStyle(
                CustomSwitchStyle(schemeProvider: schemeProvider)
            )
    }

    // MARK: - Internal Methods

    func scheme(_ scheme: CustomSwitchScheme) -> some View {
        var view = self
        view.schemeProvider = SchemeProvider.constant(scheme: scheme)
        return view.id(UUID())
    }

}

@available(iOS 14.0, *)
private struct CustomSwitchStyle: ToggleStyle {

    // MARK: - Private Properties

    private var schemeProvider: SchemeProvider<CustomSwitchScheme>

    // MARK: - Inializer

    public init(
        schemeProvider: SchemeProvider<CustomSwitchScheme>
    ) {
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        Toggle(configuration)
            .foregroundColor(schemeProvider.scheme.textColor.swiftUIColor)
            .font(schemeProvider.scheme.font.swiftUIFont)
            .toggleStyle(
                SwitchToggleStyle(
                    tint: schemeProvider.scheme.tintColor.swiftUIColor
                )
            )
    }

}
