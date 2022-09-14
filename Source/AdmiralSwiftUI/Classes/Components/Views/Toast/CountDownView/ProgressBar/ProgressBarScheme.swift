//
//  ProgressBarScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//
import AdmiralTheme
import AdmiralUIResources
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
struct ProgressBarScheme: AppThemeScheme {

    // MARK: - Properties

    /// The tint color
    var tintColor: AColor

    // MARK: - Initializer

    init(theme: AppTheme = .default) {
        tintColor = theme.colors.elementAccent
    }

}

