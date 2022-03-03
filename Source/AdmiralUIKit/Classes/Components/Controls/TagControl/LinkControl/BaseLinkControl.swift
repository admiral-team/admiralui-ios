//
//  CustomLinkControl.swift
//  AdmiralUI
//
//  Created on 19.10.2020.
//

import UIKit

/// The base link control class.
open class BaseLinkControl: TagControl<UIImageView, UIImageView> {
    
    /// Link font style.
    public enum FontStyle {
        case body
        case subhead
    }
    
    /// Type font label. Default is body.
    public var fontStyle: FontStyle = .body {
        didSet { update(fontStyle: fontStyle) }
    }
    
    /// Leading picture from text.
    public var leadingImage: UIImage? {
        didSet { update(leadingImage: leadingImage) }
    }
    
    /// Trailing picture from text.
    public var trailingImage: UIImage? {
        didSet { update(trailingImage: trailingImage) }
    }
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func commonInit() {
        //
    }
    
    func update(fontStyle: FontStyle) {
        switch fontStyle {
        case .body:
            titleFont = scheme.linkTitleFont.uiFont
        case .subhead:
            titleFont = scheme.linkTitleFontAdidtional.uiFont
        }
        updateScheme()
    }
    
    func update(leadingImage: UIImage?) {
        if let leadingImage = leadingImage {
            leadingView = UIImageView(image: leadingImage)
        } else {
            leadingView = nil
        }
    }

    func update(trailingImage: UIImage?) {
        if let trailingImage = trailingImage {
            trailingView = UIImageView(image: trailingImage)
        } else {
            trailingView = nil
        }
    }
    
}
