//
//  SwitchListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 SwitchListView - A view object with check box view.
 
 You can create a SwitchListView with the zero frame rectangle by specifying the following parameters in init:
 - isSwitchSelected: Binding<Bool> - the property is responsible for сontrol selected
 
 ## Example to create CheckBoxListView
 # Code
 ```
 SwitchListView(isSwitchSelected: .constant(true))
```
 */
/// A view object with switch view.
@available(iOS 14.0, *)
public struct SwitchListView: View, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    @Binding public var isSwitchSelected: Bool
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @State private var scheme: SwitchListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwitchListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(isSwitchSelected: Binding<Bool>) {
        self._isSwitchSelected = isSwitchSelected
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(alignment: .center) {
            Spacer()
            CustomSwitch(isOn: $isSwitchSelected)
                .scheme(.constant(scheme.customSwitch))
        }
    }
    
}

