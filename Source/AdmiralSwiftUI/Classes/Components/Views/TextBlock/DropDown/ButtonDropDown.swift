//
//  ButtonDropDown.swift
//  AdmiralSwiftUI
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ButtonDropDown - A header with button.

 You can create a ButtonDropDown by specifying the following parameters in the initializer
 
 ## Initializer parameters:
 
 - buttonTitle: String - The text that the button displays
 - buttonAction: () -> () - The callback action by tapping the button
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom
 
 ## Example to create ButtonDropDown:
 # Code
 ```
 ButtonDropDown(
     buttonTitle: "Button",
     dropDownHeaderType: .up,
     buttonAction: {})
 ```
*/
/// A header with button.
@available(iOS 14.0.0, *)
public struct ButtonDropDown: View {
    
    /// The text that the button displays.
    @Binding public var buttonTitle: String
    
    /// The button action.
    public var buttonAction: () -> ()
    
    /// Drop down header type.
    @Binding public var drropDownHeaderType: DropDownHeaderType

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        buttonTitle: String,
        dropDownHeaderType: DropDownHeaderType = .down,
        buttonAction: @escaping () -> ()) {
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self._drropDownHeaderType = Binding(get: { return dropDownHeaderType }, set: { _ in })
        self.buttonAction = buttonAction
    }

    // MARK: - Body

    public var body: some View {
        ListCell(
            centerView: {
                HStack(spacing: 0.0) {
                    ButtonWithArrowListView(
                        text: buttonTitle,
                        image: drropDownHeaderType.image,
                        action: buttonAction)
                    Spacer()
                }
            }
        )
        .configCell(minHeight: TextBlockStyle.dropDown.minHeight, edgeInsets: TextBlockStyle.dropDown.edgeInsets)
    }
}

@available(iOS 14.0, *)
struct ButtonDropDown_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDropDown(
            buttonTitle: "Button",
                    dropDownHeaderType: .up,
            buttonAction: {})
    }
}
