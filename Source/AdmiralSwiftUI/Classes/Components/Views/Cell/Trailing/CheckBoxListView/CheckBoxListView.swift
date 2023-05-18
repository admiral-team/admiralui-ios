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
        static let selectedImage = SystemImagesNew.Custom.Control.radioButtonOn.image
        static let defaultImage = SystemImagesNew.Custom.Control.radioButtonOff.image
    }
    
    // MARK: - Public Properties
    
    @Binding public var isControlSelected: Bool
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled

    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    private var checkBoxValueFormatString = ""

    @ObservedObject private var schemeProvider: SchemeProvider<CheckBoxListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        isControlSelected: Binding<Bool>,
        checkBoxValueFormatString: String = "",
        schemeProvider: SchemeProvider<CheckBoxListViewScheme> = AppThemeSchemeProvider<CheckBoxListViewScheme>()
    ) {
        self._isControlSelected = isControlSelected
        self.checkBoxValueFormatString = checkBoxValueFormatString
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        CheckBox(
            isSelected: $isControlSelected,
            schemeProvider: .constant(scheme: scheme.checkBoxScheme)
        )
    }
    
}
