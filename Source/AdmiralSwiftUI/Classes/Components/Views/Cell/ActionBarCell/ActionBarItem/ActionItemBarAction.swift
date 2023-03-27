//
//  ActionItemBar.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
/**
 ActionItemBarAction - A view with icon and handler action
 
 You can create a ActionItemBarAction with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - Image for ActionItemBarAction
 - style: ActionBarItemStyle - the style of ActionItemBarAction.
 - handler: @escaping () -> Void) - handler action of ActionItemBarAction.
 - imageTintColor: Color? - the image tint color  of ActionItemBarAction.
 - backgroundColor: Color? - the background color of ActionItemBarAction.
 - text: String? - the text of ActionItemBarAction.s

 ## Example to create ActionItemBarAction
 # Code
 ```
 ActionItemBarAction(
             image: Image("Your image icon"),
             handler: {})
```
 */
@available(iOS 14.0.0, *)
/// The struct thats configure settings of ActionItemBar.
public struct ActionItemBarAction: Identifiable, Hashable {

    // MARK: - Public properties

    /// An unique id.
    public let id = UUID()

    /// The image of ActionItemBar.
    public let image: Image

    /// The image style of ActionItemBar.
    public var imageStyle: ActionBarItemImageStyle? = nil

    // The tint color off ActionItemBar.
    public var imageTintColor: Color? = nil

    // The backgroundColor of ActionItemBar.
    public var backgroundColor: Color? = nil

    /// The style of ActionItemBar.
    public let style: ActionBarItemStyle

    public var text: String?

    /// The callback of tap action in ActionItemBar.
    public let handler: () -> Void
    
    /// The accesibility id
    public var accesibilityId: String

    // MARK: - Initializer

    public init(
        image: Image,
        imageStyle: ActionBarItemImageStyle,
        style: ActionBarItemStyle = .default,
        text: String? = nil,
        handler: @escaping () -> Void,
        accesibilityId: String = ""
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.style = style
        self.text = text
        self.handler = handler
        self.accesibilityId = accesibilityId
    }

    public init(
        image: Image,
        imageTintColor: Color,
        backgroundColor: Color,
        style: ActionBarItemStyle = .default,
        text: String? = nil,
        handler: @escaping () -> Void,
        accesibilityId: String = ""
    ) {
        self.image = image
        self.imageTintColor = imageTintColor
        self.backgroundColor = backgroundColor
        self.text = text
        self.handler = handler
        self.style = style
        self.accesibilityId = accesibilityId
    }

    // MARK: - Public methods

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ActionItemBarAction, rhs: ActionItemBarAction) -> Bool {
        lhs.id == rhs.id
    }
    
}
