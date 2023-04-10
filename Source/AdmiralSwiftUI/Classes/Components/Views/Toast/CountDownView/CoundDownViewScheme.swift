//
//  CoundDownViewScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 CoundDownViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CoundDownViewScheme() - Initialize default CoundDownViewScheme with default themezation
 # Example to create ClockScheme:
 # Code
 ```
 let scheme = CoundDownViewScheme()
 ```
 */
public struct CoundDownViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// Clock view scheme.
    public var clockViewScheme: ClockScheme

    /// Progress bar scheme.
    public var progressBarScheme: ProgressBarScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        clockViewScheme = ClockScheme(theme: theme)
        progressBarScheme = ProgressBarScheme(theme: theme)
    }

}
