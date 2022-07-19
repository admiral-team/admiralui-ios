//
//  InfoSwiftUIViewScheme.swift
//  ExampleiOS
//
//  Created on 28.05.2021.
//

import SwiftUI
import Combine
import AdmiralSwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
final public class InfoSwiftUIViewScheme: AppThemeScheme {
    
    public var titleLabelTextColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var descriptionLabelTextColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var subtitleLabelTextColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var wrapViewBackgroundColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var backgroundColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var descriptionImageViewTintColors = ArrowSegmentSliderCustomThemeParameter<AColor>()
    public var descriptionImageViewAlpha = ArrowSegmentSliderCustomThemeParameter<Double>()
    
    public var titleLabelFont: AFont
    public var descriptionLabelFont: AFont
    public var subtitleLabelFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        titleLabelFont = AppTheme.default.fonts.headline
        descriptionLabelFont = AppTheme.default.fonts.largeTitle2
        subtitleLabelFont = AppTheme.default.fonts.subhead4
        
        // Normal
        titleLabelTextColors.set(parameter: theme.colors.textPrimary, for: .normal)
        descriptionLabelTextColors.set(parameter: theme.colors.textAccent, for: .normal)
        subtitleLabelTextColors.set(parameter: theme.colors.textPrimary, for: .normal)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .normal)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        descriptionImageViewTintColors.set(parameter: theme.colors.elementPrimary, for: .normal)
        descriptionImageViewAlpha.set(parameter: 1, for: .normal)

        // Disabled
        titleLabelTextColors.set(parameter: theme.colors.textSecondary, for: .disabled)
        descriptionLabelTextColors.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
        subtitleLabelTextColors.set(parameter: theme.colors.textSecondary, for: .disabled)
        backgroundColors.set(parameter: theme.colors.backgroundBasic, for: .disabled)
        wrapViewBackgroundColors.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
        descriptionImageViewTintColors.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        descriptionImageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
    
}

public typealias ArrowSegmentSliderCustomThemeParameter<T> = ParameterBox<ArrowSegmentSliderCustomThemeState, T>

public enum ArrowSegmentSliderCustomThemeState: UInt {
    case normal
    case disabled
}

extension ArrowSegmentSliderCustomThemeState: DefaultRepresentable {
    public static var defaultValue: ArrowSegmentSliderCustomThemeState { .normal }
}
