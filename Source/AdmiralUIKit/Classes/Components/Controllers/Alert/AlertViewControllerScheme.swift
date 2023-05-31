//
//  AlertViewControllerScheme.swift
//  AdmiralUIKit
//
//  Created on 31.01.2022.
//

import AdmiralTheme

/**
 AlertViewControllerScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - AlertViewControllerScheme() - Initialize default AlertViewControllerScheme with default themezation
Example to create AlertViewControllerScheme:
Code
 ```
let scheme = AlertViewControllerScheme()
 ```
 */
public struct AlertViewControllerScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Default alert view custom scheme.
    public var defaultAlertViewCustomScheme: DefaultAlertViewCustomScheme

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        backgroundColor = theme.colors.backgroundModalView.withAlpha(alpha)
        defaultAlertViewCustomScheme = DefaultAlertViewCustomScheme(theme: theme)
    }
    
}
