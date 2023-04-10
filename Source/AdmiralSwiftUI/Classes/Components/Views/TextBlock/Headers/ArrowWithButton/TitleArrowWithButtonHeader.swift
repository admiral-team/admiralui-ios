//
//  TitleArrowWithButtonHeader.swift
//  AdmiralSwiftUI
//
//  Created on 24.09.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 TitleArrowWithButtonHeader - A header with header title, arrow and button.

 You can create a TitleArrowWithButtonHeader by specifying the following parameters in the initializer

 ## Initializer parameters:

 - title: String? - Title text block
 - buttonTitle: String - Title button
 - buttonAction: () -> () - The callback action by tapping the button
 - renderingMode: Image.TemplateRenderingMode - Rendering mode for image
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom
 - headerStyle: HeaderStyle - A style of header text block. HeaderStyle can be: title, body, headline, headlineSecondary

 ## Example to create vertical TitleArrowWithButtonHeader:
 # Code
 ```
 TitleArrowWithButtonHeader(title: "Title", buttonTitle: "Button", buttonAction: {})
 TitleArrowWithButtonHeader(
 title: "Title",
 buttonTitle: "Button",
 buttonAction: {},
 dropDownHeaderType: .up)
 ```
 */
/// A header with header title, arrow and button.
@available(iOS 14.0.0, *)
public struct TitleArrowWithButtonHeader: View {

    /// The text that the label displays.
    @Binding public var title: String?

    /// The text that the button displays.
    @Binding public var buttonTitle: String

    /// Drop down header type.
    @Binding public var dropDownHeaderType: DropDownHeaderType?

    /// The button action
    public var buttonAction: () -> ()

    /// Image rendering mode.
    public var renderingMode: Image.TemplateRenderingMode

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    // MARK: - Private Properties

    /// The accesibility id
    private var buttonAccesibilityId: String
    
    @ObservedObject private var schemeProvider: SchemeProvider<TitleArrowWithButtonHeaderScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        buttonTitle: String,
        buttonAction: @escaping () -> (),
        renderingMode: Image.TemplateRenderingMode = .original,
        dropDownHeaderType: DropDownHeaderType? = nil,
        headerStyle: HeaderStyle = .title,
        buttonAccesibilityId: String = "",
        schemeProvider: SchemeProvider<TitleArrowWithButtonHeaderScheme> = AppThemeSchemeProvider<TitleArrowWithButtonHeaderScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self.buttonAction = buttonAction
        self.renderingMode = renderingMode
        self.textBlockStyle = headerStyle.textBlockStyle
        self._dropDownHeaderType = Binding(get: { return dropDownHeaderType }, set: { _ in })
        self.buttonAccesibilityId = buttonAccesibilityId
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let titleWithImageListStyle = TitleWithImageListStyle(rawValue: textBlockStyle.rawValue)
        return ListCell(
            centerView: { TitleWithImageListView(
                title: title,
                image: dropDownHeaderType?.image.renderingMode(renderingMode),
                renderingMode: renderingMode,
                titleWithImageListStyle: titleWithImageListStyle,
                schemeProvider: .constant(scheme: schemeProvider.scheme.centerViewScheme)
            )
            },
            trailingView: { ButtonListView(
                text: buttonTitle,
                accesibilityId: buttonAccesibilityId,
                schemeProvider: .constant(scheme: schemeProvider.scheme.trailingViewScheme),
                action: buttonAction) })
        .configCell(
            minHeight: textBlockStyle.minHeight,
            edgeInsets: textBlockStyle.edgeInsets,
            schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
        )
    }
}

@available(iOS 14.0, *)
struct TitleArrowWithButtonHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitleArrowWithButtonHeader(title: "Title", buttonTitle: "Button", buttonAction: {})
            TitleArrowWithButtonHeader(
                title: "Title",
                buttonTitle: "Button",
                buttonAction: {},
                dropDownHeaderType: .up)
        }
    }
}
