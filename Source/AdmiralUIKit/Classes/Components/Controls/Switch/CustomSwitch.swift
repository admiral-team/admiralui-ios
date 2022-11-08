//
//  CustomSwitch.swift
//  AdmiralUI
//
//  Created on 20.10.2020.
//

import UIKit
import AdmiralTheme

/// A control that offers a binary choice, such as On/Off.
open class CustomSwitch: UISwitch, AnyAppThemable {

    // MARK: - Public Properties

    /// Color scheme.
    public var scheme = CustomSwitchScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Initializers
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    open func apply(theme: AppTheme) {
        scheme = CustomSwitchScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        clipsToBounds = true
    }

    private func updateScheme() {
        configure()
    }

    private func configure() {
        onTintColor = scheme.onTintColor.uiColor
        tintColor = isEnabled ? scheme.textColor.uiColor : scheme.disabledTextColor.uiColor
        onTintColor = isEnabled ? scheme.tintColor.uiColor : scheme.disabledTintColor.uiColor
    }
}
