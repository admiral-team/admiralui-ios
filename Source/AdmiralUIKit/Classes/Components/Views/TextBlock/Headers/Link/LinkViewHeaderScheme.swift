//
//  LinkViewScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 LinkViewHeaderScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - LinkViewHeaderScheme() - Initialize default LinkViewHeaderScheme with default themezation
Example to create LinkViewHeaderScheme:
Code
 ```
let scheme = LinkViewHeaderScheme()
 ```
 */
public struct LinkViewHeaderScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Ghost button scheme.
    public var ghostScheme: GhostButtonCustomScheme
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        ghostScheme = GhostButtonCustomScheme(theme: theme)
    }
}

