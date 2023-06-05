//
//  ProgressBarScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//
import AdmiralTheme
/**
 ProgressBarScheme - the visual scheme of ProgressBar.
 You can create a by specifying the following parameters in init:
 - ProgressBarScheme() - Initialize default ProgressBarScheme with default themezation
 # Example to create ProgressBarScheme:
 # Code
 ```
 let scheme = ProgressBarScheme()
 ```
 */
public struct ProgressBarScheme: AppThemeScheme {

    // MARK: - Properties

    /// The tint color
    public var tintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        tintColor = theme.colors.elementAccent
    }

}


