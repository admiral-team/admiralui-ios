//
//  TwoTitlePrimaryButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created by on 06.09.2022.
//

import SwiftUI
import AdmiralTheme
/**
 A TwoTitlePrimaryButtonStyle with two text headers (left and right). PrimaryButton - the main button for the most important actions

 You can create a TwoTitlePrimaryButton by specifying the following parameters in the initializer
 ## Initializer parameters:
 - leftText - value of String
 - rightText - value of String

 ## Example to create TwoTitlePrimaryButton:
 # Code
 ```
 Button("", action: {})
     .buttonStyle(
         TwoTitlePrimaryButtonStyle(
             leftTitle: leftText,
             rightTitle: rightText
         )
     )
 )
 ```
 */
@available(iOS 14.0.0, *)
public struct TwoTitlePrimaryButtonStyle: ButtonStyle {

    // MARK: - Private properties

    private let leftTitle: String
    private let rightTitle: String

    @ObservedObject private var schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme>

    // MARK: - Initializier

    public init(
        leftTitle: String = "",
        rightTitle: String = "",
        schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme> = AppThemeSchemeProvider<TwoTitlePrimaryButtonScheme>()
    ) {
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.schemeProvider = schemeProvider
    }

    // MARK: - Public methods

    public func makeBody(configuration: Self.Configuration) -> some View {
        TwoTitlePrimaryButton(
            configuration: configuration,
            leftTitle: leftTitle,
            rightTitle: rightTitle,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension TwoTitlePrimaryButtonStyle {
    struct TwoTitlePrimaryButton: View {

        // MARK: - Private Properties

        private let configuration: Configuration
        private let leftTitle: String
        private let rightTitle: String

        @Environment(\.isEnabled) private var isEnabled

        private var schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme>

        // MARK: - Initializer

        init(
            configuration: Configuration,
            leftTitle: String,
            rightTitle: String,
            schemeProvider: SchemeProvider<TwoTitlePrimaryButtonScheme>
        ) {
            self.schemeProvider = schemeProvider
            self.configuration = configuration
            self.leftTitle = leftTitle
            self.rightTitle = rightTitle
        }

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let state = twoTitlePrimaryState(configuration)
            return ZStack {
                scheme.buttonBackgroundColor.parameter(for: state)?.swiftUIColor
                HStack(spacing: 0) {
                    Text(leftTitle)
                        .font(scheme.leftLabelFont.swiftUIFont)
                        .foregroundColor(scheme.leftTitleColor.parameter(for: state)?.swiftUIColor)
                        .padding(.horizontal, LayoutGrid.doubleModule)
                    Spacer()
                    Text(rightTitle)
                        .font(scheme.rightLabelFont.swiftUIFont)
                        .foregroundColor(scheme.rightTitleColor.parameter(for: state)?.swiftUIColor)
                        .padding(.horizontal, LayoutGrid.doubleModule)
                }
            }
            .background(scheme.backgroundColor.swiftUIColor)
            .cornerRadius(LayoutGrid.module)
        }

        // MARK: - Private Methods

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
