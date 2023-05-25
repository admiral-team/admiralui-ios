//
//  SegmentButtonsViewScheme.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme

/**
 InfoAgreementViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - InfoAgreementViewScheme() - Initialize default InfoAgreementViewScheme with default themezation
Example to create InfoAgreementViewScheme:
Code
 ```
let scheme = InfoAgreementViewScheme()
 ```
 */
public struct InfoAgreementViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Check box text button biew scheme.
    public var checkBoxTextButtonViewTheme = CheckBoxTextButtonViewScheme()

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        checkBoxTextButtonViewTheme = CheckBoxTextButtonViewScheme(theme: theme)
    }
}
