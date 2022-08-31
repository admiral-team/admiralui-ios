//
//  ProgressBarScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//
import AdmiralTheme
import AdmiralUIResources

struct ProgressBarScheme: AppThemeScheme {

    // MARK: - Properties

    /// The tint color of ProgressBarView
    var tintColor: AColor

    // MARK: - Initializer
    
    init(theme: AppTheme) {
        tintColor = theme.colors.elementAccent
    }
}
