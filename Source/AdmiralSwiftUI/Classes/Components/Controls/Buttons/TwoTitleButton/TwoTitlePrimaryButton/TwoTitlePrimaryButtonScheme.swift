//
//  TwoTitleButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct TwoTitlePrimaryButtonScheme: ButtonStyle, AppThemeScheme {
    
    public var leftTitleColor = ControlParameter<AColor>()
    public var rightTitleColor = ControlParameter<AColor>()
    public var backgroundColor: AColor
    public var buttonBackgroundColor = ControlParameter<AColor>()

    public var leftLabelFont: AFont
    public var rightLabelFont: AFont
    
    // FIXME: - Separate logic scheme and style
    public var leftTitle: String = ""
    public var rightTitle: String = ""
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        leftLabelFont = theme.fonts.subhead3
        rightLabelFont = theme.fonts.body1
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        
        leftTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        leftTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
        
        rightTitleColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        rightTitleColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }
    
    public func makeBody(configuration: TwoTitlePrimaryButtonScheme.Configuration) -> some View {
        TwoTitlePrimaryButton(
            configuration: configuration,
            leftTitle: leftTitle,
            rightTitle: rightTitle,
            leftTitleColor: leftTitleColor,
            rightTitleColor: rightTitleColor,
            backgroundColor: backgroundColor,
            buttonBackgroundColor: buttonBackgroundColor,
            leftLabelFont: leftLabelFont,
            rightLabelFont: rightLabelFont)
    }
    
}

@available(iOS 14.0.0, *)
private extension TwoTitlePrimaryButtonScheme {
    struct TwoTitlePrimaryButton: View {
        
        let configuration: Configuration
        let leftTitle: String
        let rightTitle: String
        let leftTitleColor: ControlParameter<AColor>
        let rightTitleColor: ControlParameter<AColor>
        let backgroundColor: AColor
        let buttonBackgroundColor: ControlParameter<AColor>

        let leftLabelFont: AFont
        let rightLabelFont: AFont
        
        @Environment(\.isEnabled) private var isEnabled

        var body: some View {
            let state = twoTitlePrimaryState(configuration)
            return ZStack {
                buttonBackgroundColor.parameter(for: state)?.swiftUIColor
                HStack(spacing: 0) {
                    Text(leftTitle)
                        .font(leftLabelFont.swiftUIFont)
                        .foregroundColor(leftTitleColor.parameter(for: state)?.swiftUIColor)
                        .padding(.horizontal, LayoutGrid.doubleModule)
                    Spacer()
                    Text(rightTitle)
                        .font(rightLabelFont.swiftUIFont)
                        .foregroundColor(rightTitleColor.parameter(for: state)?.swiftUIColor)
                        .padding(.horizontal, LayoutGrid.doubleModule)
                }
            }
            .background(backgroundColor.swiftUIColor)
            .cornerRadius(LayoutGrid.module)
        }
        
        private func twoTitlePrimaryState(_ configuration: Configuration) -> ControlState {
            var state: ControlState = .normal
            if !isEnabled {
                state = .disabled
            } else if configuration.isPressed {
                state = .highlighted
            }
            return state
        }
    }
}
