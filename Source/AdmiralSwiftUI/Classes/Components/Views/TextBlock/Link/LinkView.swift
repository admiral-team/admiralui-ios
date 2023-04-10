//
//  LinkView.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI
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

    // MARK: - Private Properties
    
    private var accesibilityId: String

    @ObservedObject private var schemeProvider: SchemeProvider<LinkViewScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        buttonTitle: String,
        accesibilityId: String = "",
        schemeProvider: SchemeProvider<LinkViewScheme> = AppThemeSchemeProvider<LinkViewScheme>(),
        buttonAction: @escaping () -> ()
    ) {
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self.buttonAction = buttonAction
        self.accesibilityId = accesibilityId
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        ListCell(
            centerView: {
                HStack(spacing: 0.0) {
                    ButtonListView(
                        text: buttonTitle,
                        accesibilityId: accesibilityId,
                        schemeProvider: .constant(scheme: schemeProvider.scheme.contentListViewScheme),
                        action: buttonAction)
                    Spacer()
                }
        })
        .configCell(
            minHeight: TextBlockStyle.link.minHeight,
            edgeInsets: TextBlockStyle.link.edgeInsets,
            schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
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
