//
//  CheckBoxListView.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 CheckBoxListView - A view object with check box view.
 
 You can create a CheckBoxListView with the zero frame rectangle by specifying the following parameters in init:
 - isControlSelected: Binding<Bool> - the property is responsible for сontrol selected
 
 CheckBoxListView has a public property:
 - state: ControlState - The state of the view. Default is normal.
 
 ## Example to create CheckBoxListView
 # Code
 ```
 CheckBoxListView(isControlSelected: .constant(true))
```
 */
/// A view object with check box view.
@available(iOS 14.0, *)
public struct CheckBoxListView: View, TralingListViewComponent {
    
    enum Constants {
        static let selectedImage = PrivateAsset.Custom.Control.radioButtonOn.image
        static let defaultImage = PrivateAsset.Custom.Control.radioButtonOff.image
    }
    
    // MARK: - Public Properties
    
    @Binding public var isControlSelected: Bool
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled

    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    @State private var scheme: CheckBoxListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CheckBoxListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(isControlSelected: Binding<Bool>) {
        self._isControlSelected = isControlSelected
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        CheckBox(isSelected: $isControlSelected)
            .scheme(scheme.checkBoxView)
    }
    
}
