//
//  RadioButtonListView.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 RadioButtonListView - A view object with big title.
 
 You can create a SecondaryTitleListView with the zero frame rectangle by specifying the following parameters in init:
 - isControlSelected: Binding<Bool> - the property is responsible for сontrol selected
 
 RadioButtonListView has a public property:
 - state: ControlState - The state of the view. Default is normal.
 
 ## Example to create BadgeArrowListView
 # Code
 ```
 RadioButtonListView(isControlSelected: .constant(false))
```
 */
/// A view object with radio button.
@available(iOS 14.0, *)
public struct RadioButtonListView: View, TralingListViewComponent {
    
    enum Constants {
        static let selectedImage = SystemAsset.Custom.Control.radioButtonOn.image
        static let defaultImage = SystemAsset.Custom.Control.radioButtonOff.image
    }
    
    // MARK: - Public Properties
    
    @Binding public var isControlSelected: Bool
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    @State private var scheme: RadioButtonListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<RadioButtonListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(isControlSelected: Binding<Bool>) {
        self._isControlSelected = isControlSelected
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        RadioControl(isSelected: $isControlSelected)
            .scheme(scheme.radioButtonView)
    }
    
}

