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
    
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<CustomSwitchScheme>()
    @State private var scheme: CustomSwitchScheme? = nil
    
    // MARK: - Initializer
    
    public init(isOn: Binding<Bool>) {
        self._isOn = isOn
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: CustomSwitchScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        Toggle(isOn: $isOn, label: {})
            .labelsHidden()
            .toggleStyle(scheme)
    }
    
}
