//
//  ActionBarButtonSchemeTwo.swift
//  AdmiralSwiftUI
//
//  Created on 08.02.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct ActionBarButtonStyleSecondary: ButtonStyle {

    // MARK: - Private properties.

    private let image: Image
    private let imageStyle: ActionBarItemImageStyle?
    private let style: ActionBarItemStyle
    private let actionBarControlScheme: ActionBarControlSchemeSecondary
    private let backgroundColor: Color?
    private let imageTintColor: Color?
    private let text: String?

    // MARK: - Initializer.

    init(
        image: Image,
        imageStyle: ActionBarItemImageStyle?,
        style: ActionBarItemStyle,
        backgroundColor: Color?,
        imageTintColor: Color?,
        text: String?,
        actionBarControlScheme: ActionBarControlSchemeSecondary
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.style = style
        self.imageTintColor = imageTintColor
        self.backgroundColor = backgroundColor
        self.text = text
        self.actionBarControlScheme = actionBarControlScheme
    }

    // MARK: - Public methods.

    public func makeBody(configuration: Self.Configuration) -> some View {
        ActionBarButton(
            configuration: configuration,
            scheme: actionBarControlScheme,
            image: image,
            imageStyle: imageStyle,
            style: style,
            backgroundColor: backgroundColor,
            imageTintColor: imageTintColor,
            text: text
        )
    }
}

@available(iOS 14.0.0, *)
private extension ActionBarButtonStyleSecondary {

    struct ActionBarButton: View {

        // MARK: - Constants

        private enum Constants {
            static let imageSize: CGFloat = LayoutGrid.quadrupleModule
            static let width: CGFloat = 90
            static let height: CGFloat = LayoutGrid.halfModule * 18
        }

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Properties

        let configuration: Configuration
        let scheme: ActionBarControlSchemeSecondary
        let image: Image
        let imageStyle: ActionBarItemImageStyle?
        let style: ActionBarItemStyle
        let backgroundColor: Color?
        let imageTintColor: Color?
        let text: String?

        // MARK: - Layout

        var body: some View {
            let colors = setupColors()
            return VStack {
                image
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(colors.1)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                Text(text ?? "")
                    .font(scheme.textFont.swiftUIFont)
                    .foregroundColor(scheme.textColor.swiftUIColor)
            }
            .opacity(scheme.actionBarControl.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
            .frame(width: Constants.width, height: Constants.height)
            .background(colors.0)
        }

        // MARK: - Private methods

        private func setupColors() -> (Color?, Color?) {
            var frontColor: Color?
            var imageColor: Color?

            switch (imageStyle, imageTintColor, backgroundColor) {
            case (nil, let tintColor, let background):
                guard let tintColor = tintColor,
                      let background = background
                else {
                    return (frontColor, imageColor)
                }

                frontColor = background
                imageColor = tintColor
                if !isEnabled || configuration.isPressed {
                    frontColor = frontColor?.opacity(Double(scheme.alpha))
                    imageColor = imageColor?.opacity(Double(scheme.alpha))
                }
            case (let imgStyle, nil, nil):
                imageColor = scheme.imageTintColor.swiftUIColor
                guard let imgStyle = imgStyle else {
                    return (frontColor, imageColor)
                }

                frontColor = scheme.actionBarControl.backgroundColor.parameter(for: imgStyle, control: .normal)?.swiftUIColor
                if !isEnabled {
                    frontColor = scheme.actionBarControl.backgroundColor.parameter(for: imgStyle, control: .disabled)?.swiftUIColor
                } else if configuration.isPressed {
                    frontColor = scheme.actionBarControl.backgroundColor.parameter(for: imgStyle, control: .selected)?.swiftUIColor
                }
            default:
                break
            }
            return (frontColor, imageColor)
        }

    }
}
