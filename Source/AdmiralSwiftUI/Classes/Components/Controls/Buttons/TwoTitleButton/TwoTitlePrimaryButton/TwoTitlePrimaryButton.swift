//
//  TwoTitlePrimaryButton.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import AdmiralTheme
import SwiftUI
/**
 A TwoTitlePrimaryButtonStyle with two text headers (left and right). PrimaryButton - the main button for the most important actions
 
 You can create a TwoTitlePrimaryButton by specifying the following parameters in the initializer
 ## Initializer parameters:
 - leftText - value of String
 - rightText - value of String
 
 ## Example to create TwoTitlePrimaryButtonStyle:
 # Code
 ```
 TwoTitlePrimaryButton(
 leftText: "left Text",
 rightText: "right Text",
 )
 ```
 */
@available(iOS 14.0.0, *)
public struct TwoTitlePrimaryButtonStyle: ButtonStyle {

    // MARK: - Public Properties

    /// The loading flag of GhostButton
    @Binding public var isLoading: Bool

    /// The size type of GhostButton
    public var sizeType: ButtonSizeType?

    ///  The left text
    public var leftText: String

    /// The right text
    public var rightText: String

    // MARK: - Private Properties

    @Binding private var scheme: TwoTitlePrimaryButtonScheme?

    // MARK: - Inializer

    public init(
        isLoading: Binding<Bool> = .constant(false),
        sizeType: ButtonSizeType? = nil,
        leftText: String,
        rightText: String,
        scheme: Binding<TwoTitlePrimaryButtonScheme?> = .constant(nil)
    ) {
        self._isLoading = isLoading
        self.sizeType = sizeType
        self.leftText = leftText
        self.rightText = rightText
        self._scheme = scheme
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        TwoTitlePrimaryButton(
            configuration: configuration,
            leftTitle: leftText,
            rightTitle: rightText,
            scheme: $scheme
        )
    }
}

@available(iOS 14.0.0, *)
private extension TwoTitlePrimaryButtonStyle {
    struct TwoTitlePrimaryButton: View {

        // MARK: - Environment

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Properties

        let configuration: Configuration
        let leftTitle: String
        let rightTitle: String

        @Binding var scheme: TwoTitlePrimaryButtonScheme?
        @ObservedObject private var schemeProvider = AppThemeSchemeProvider<TwoTitlePrimaryButtonScheme>()

        // MARK: - Body

        var body: some View {
            let scheme = self.scheme ?? schemeProvider.scheme
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

        // MARK: - Private Properties

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


@available(iOS 14.0, *)
struct Two_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
        Button(action: {}, label: {})
            .buttonStyle(
                TwoTitlePrimaryButtonStyle(
                    isLoading: .constant(false),
                    sizeType: .medium,
                    leftText: "left",
                    rightText: "right"
                )
            )
        Spacer()
    }
}

