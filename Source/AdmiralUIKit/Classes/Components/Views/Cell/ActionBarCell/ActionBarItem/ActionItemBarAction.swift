//
//  ActionItemBarAction.swift
//  AdmiralUIKit
//
//  Created on 07.02.2022.
//

import UIKit
/**
 ActionItemBarAction - A view with icon and handler action

 You can create a ActionItemBarAction with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - Image for ActionItemBarAction
 - style: ActionBarItemStyle - the style of ActionItemBarAction.
 - handler: @escaping () -> Void) - handler action if ActionItemBarAction.
 - backgroundColor: UIColor - the background color of ActionItemBarAction.
 - imageTintColor: UIColor? - the image tint color of ActionItemBarAction.

 ## Example to create ActionItemBarAction
 # Code
 ```
 let action = ActionItemBarAction(
    image: UIimage(""),
    imageStyle: .accent,
    style: .default,
    handler: { _ in}
 )
```
 */
/// An initial class that configure settings of ActionItemBarView.
public class ActionItemBarAction {

    // MARK: - Public properties

    /// An image of ActionItemBar.
    public let image: UIImage

    /// The style of ActionItemBar.
    public var imageStyle: ActionBarItemImageStyle? = nil

    // The tint color off ActionItemBar.
    public var imageTintColor: UIColor? = nil

    // The backgroundColor of ActionItemBar.
    public var backgroundColor: UIColor? = nil

    /// The style of ActionBarItem
    public let style: ActionBarItemStyle

    /// The callback of tap action in ActionItemBar.
    public let handler: () -> Void

    /// The text of ActionItemBar.
    public var text: String?

    /// The accesibility id
    public var accesibilityId: String?

    // MARK: - Initializer

    public init(
        image: UIImage,
        imageStyle: ActionBarItemImageStyle,
        style: ActionBarItemStyle = .default,
        text: String? = nil,
        accesibilityId: String? = nil,
        handler: @escaping () -> Void
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.style = style
        self.text = text
        self.accesibilityId = accesibilityId
        self.handler = handler
    }

    public init(
        image: UIImage,
        imageTintColor: UIColor,
        backgroundColor: UIColor,
        style: ActionBarItemStyle = .default,
        text: String? = nil,
        accesibilityId: String? = nil,
        handler: @escaping () -> Void
    ) {
        self.image = image
        self.imageTintColor = imageTintColor
        self.backgroundColor = backgroundColor
        self.text = text
        self.handler = handler
        self.style = style
        self.accesibilityId = accesibilityId
    }

}
