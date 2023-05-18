//
//  ActionItemBarView.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
/// The tint color style of ActionBarItemImage.
public enum ActionBarItemImageStyle: Int {
    /// An accent style.
    case accent
    /// The primary style.
    case primary
    /// An error style.
    case error
    /// The success style.
    case success
    /// An attention style.
    case attention
}

/**
 ActionBarControlView - A view object with background view and image view for ActionBarView.
 
 You can create a ActionBarControlView with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - The image displayed in the image view.

 ## Example to create ActionBarControlView
 # Code
 ```
 ActionBarControlView(
            image: Image("Your image"),
            tapActionBar: {})
```
 */
/// A view object with background view and image view.
@available(iOS 14.0.0, *)
struct ActionBarControlView: View {

    // MARK: - Internal Properties
    
    /// The image displayed in the image view.
    var image: Image

    /// The image style of ActionBarControlView.
    var imageStyle: ActionBarItemImageStyle

    /// The callback action.
    var tapActionBar: () -> ()

    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<ActionBarControlScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    init(
        image: Image,
        imageStyle: ActionBarItemImageStyle,
        schemeProvider: SchemeProvider<ActionBarControlScheme> = AppThemeSchemeProvider<ActionBarControlScheme>(),
        tapActionBar: @escaping () -> ()
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.tapActionBar = tapActionBar
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    var body: some View {
        Button(action: tapActionBar, label: {})
            .buttonStyle(ActionBarButtonStyle(
                image: image,
                imageStyle: imageStyle,
                actionBarControlParameters: schemeProvider.scheme.actionBarControl
            )
        )
    }
}

@available(iOS 14.0, *)
struct ActionBarControlView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActionBarControlView(
            image: Image(uiImage: ImagesNew.Category.Outline.addCommentOutline.image),
            imageStyle: .accent,
            tapActionBar: {}
        )
    }
    
}
