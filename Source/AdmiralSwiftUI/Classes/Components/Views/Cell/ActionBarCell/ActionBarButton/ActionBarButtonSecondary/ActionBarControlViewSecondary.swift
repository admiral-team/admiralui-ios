//
//  ActionItemBarView.swift
//  AdmiralSwiftUI
//
//  Created on 08.02.2022.
//

import SwiftUI
import AdmiralTheme

/**
 ActionBarControlViewTwo - A view object with background view and image view for ActionBarView.

 You can create a ActionBarControlViewTwo with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - The image displayed in the image view.
 - imageStyle: ActionBarItemImageStyle - The image style of ActionBarControlViewTwo.
 - style: ActionBarItemStyle - The style of ActionBarControlViewTwo.
 - backgroundColor: Color? - The backgroundColor of ActionBarControlViewTwo.
 - imageTintColor: Color? - The image tint color of ActionBarControlViewTwo.

 ## Example to create ActionBarControlViewTwo
 # Code
 ```
 ActionBarControlViewTwo(
            image: Image("Your image"),
            style: .two(text: "Text"),
            tapActionBar: {}
 )
```
 */
/// A view object with background view and image view.
@available(iOS 14.0.0, *)
struct ActionBarControlViewSecondary: View {

    // MARK: Internal Properties

    @Environment(\.isEnabled) var isEnabled

    @ObservedObject private var schemeProvider: SchemeProvider<ActionBarControlSchemeSecondary>

    // MARK: - Private  Properties

    private var image: Image
    private var imageStyle: ActionBarItemImageStyle?
    private var style: ActionBarItemStyle
    private var tapActionBar: () -> ()
    private var backgroundColor: Color?
    private var imageTintColor: Color?
    private var text: String?

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    init(
        image: Image,
        imageStyle: ActionBarItemImageStyle?,
        backgroundColor: Color?,
        imageTintColor: Color?,
        style: ActionBarItemStyle = .default,
        text: String?,
        schemeProvider: SchemeProvider<ActionBarControlSchemeSecondary> = AppThemeSchemeProvider<ActionBarControlSchemeSecondary>(),
        tapActionBar: @escaping () -> ()
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.backgroundColor = backgroundColor
        self.imageTintColor = imageTintColor
        self.style = style
        self.text = text
        self.schemeProvider = schemeProvider
        self.tapActionBar = tapActionBar
    }

    // MARK: - Layout

    var body: some View {
        Button(action: tapActionBar, label: {})
            .buttonStyle(ActionBarButtonStyleSecondary(
                image: image,
                imageStyle: imageStyle,
                style: style,
                backgroundColor: backgroundColor,
                imageTintColor: imageTintColor,
                text: text,
                actionBarControlScheme: schemeProvider.scheme
            )
        )
    }
}

@available(iOS 14.0, *)
struct ActionBarControlViewTwo_Previews: PreviewProvider {

    static var previews: some View {
        ActionBarControlViewSecondary(
            image: SymbolAssets.Category.Outline.addCommen.swiftUIImage,
            imageStyle: .accent,
            backgroundColor: nil,
            imageTintColor: nil,
            style: .secondary,
            text: "Text",
            tapActionBar: {}
        )
    }
    
}
