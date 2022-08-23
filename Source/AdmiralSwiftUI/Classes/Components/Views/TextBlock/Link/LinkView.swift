//
//  LinkView.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 LinkView - A header with link button.

 You can create a LinkView by specifying the following parameters in the initializer

 ## Initializer parameters:

 - buttonTitle: String - The text that the button displays
 - buttonAction: () -> () - The callback action by tapping the button

 ## Example to create LinkView:
 # Code
 ```
 LinkView(
     buttonTitle: "Button",
     buttonAction: {})
 ```
*/
/// A header with link button.
@available(iOS 14.0.0, *)
public struct LinkView: View {

    /// The text that the button displays.
    @Binding public var buttonTitle: String

    /// The button action.
    public var buttonAction: () -> ()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        buttonTitle: String,
        buttonAction: @escaping () -> ()) {
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self.buttonAction = buttonAction
    }

    // MARK: - Body

    public var body: some View {
        ListCell(
            centerView: {
                HStack(spacing: 0.0) {
                    ButtonListView(text: buttonTitle, action: buttonAction)
                    Spacer()
                }
        })
        .configCell(
            minHeight: TextBlockStyle.link.minHeight,
            edgeInsets: TextBlockStyle.link.edgeInsets
        )
    }
}

@available(iOS 14.0, *)
struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(
            buttonTitle: "Button",
            buttonAction: {})
    }
}
