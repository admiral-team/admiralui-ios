//
//  TitleButtonDropDown.swift
//  AdmiralUIResources
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 TitleButtonDropDown - A view with title and button (down).

 You can create a TitleButtonDropDown by specifying the following parameters in the initializer

 ## Initializer parameters:

 - title: String? - The text that the label displays.
 - buttonTitle: String - The text that the button displays
 - buttonAction: () -> () - The callback action by tapping the button
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom

 ## Example to create TitleButtonDropDown:
 # Code
 ```
 TitleButtonDropDown(
             title: "Title",
             buttonTitle: "Button",
             buttonAction: {})
 ```
*/
/// A header with header title.
@available(iOS 14.0.0, *)
public struct TitleButtonDropDown: View {

    /// The text that the label displays.
    @Binding public var title: String?

    /// The text that the button displays.
    @Binding public var buttonTitle: String

    /// The button action.
    public var buttonAction: () -> ()

    /// DropDown header type.
    @Binding public var dropDownHeaderType: DropDownHeaderType

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<TitleButtonDropDownScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        buttonTitle: String,
        dropDownHeaderType: DropDownHeaderType = .down,
        schemeProvider: SchemeProvider<TitleButtonDropDownScheme> = AppThemeSchemeProvider<TitleButtonDropDownScheme>(),
        buttonAction: @escaping () -> ()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self._dropDownHeaderType = Binding(get: { return dropDownHeaderType }, set: { _ in })
        self.buttonAction = buttonAction
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        ListCell(
            centerView: { SecondaryTitleListView(title: title) },
            trailingView: { ButtonWithArrowListView(
                text: buttonTitle,
                image: dropDownHeaderType.image,
                action: buttonAction) })
        .configCell(
            minHeight: TextBlockStyle.dropDown.minHeight,
            edgeInsets: TextBlockStyle.dropDown.edgeInsets,
            schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
        )
    }
}

@available(iOS 14.0, *)
struct TitleButtonDropDown_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TitleButtonDropDown(title: "Title", buttonTitle: "Button", buttonAction: {})
        }
    }
}
