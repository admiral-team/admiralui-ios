//
//  ActionBarButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme

@available(iOS 14.0.0, *)
struct ActionBarButtonStyle: ButtonStyle {
    
    var image: Image
    var imageStyle: ActionBarItemImageStyle
    var actionBarControlParameters: ActionBarControlScheme.ActionBarControl
    
    init(
        image: Image,
        imageStyle: ActionBarItemImageStyle,
        actionBarControlParameters: ActionBarControlScheme.ActionBarControl
    ) {
        self.image = image
        self.imageStyle = imageStyle
        self.actionBarControlParameters = actionBarControlParameters
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ActionBarButton(
            configuration: configuration,
            parameters: actionBarControlParameters,
            image: image,
            imageStyle: imageStyle
        )
    }
}

@available(iOS 14.0.0, *)
private extension ActionBarButtonStyle {
    
    struct ActionBarButton: View {
        @Environment(\.isEnabled) private var isEnabled

        private enum Constants {
            static let imageSize: CGFloat = LayoutGrid.quadrupleModule
        }

        let configuration: Configuration
        let parameters: ActionBarControlScheme.ActionBarControl
        let image: Image
        let imageStyle: ActionBarItemImageStyle
        
        var body: some View {
            var backgroundColor = parameters.backgroundColor.parameter(for: .normal)?.swiftUIColor ?? .clear
            if !isEnabled {
                backgroundColor = parameters.backgroundColor.parameter(for: .disabled)?.swiftUIColor ?? .clear
            } else if configuration.isPressed {
                backgroundColor = parameters.backgroundColor.parameter(for: .selected)?.swiftUIColor ?? .clear
            }
            
            return image
                .renderingMode(.template)
                .scaledToFit()
                .opacity(parameters.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
                .foregroundColor(parameters.imageTintColor.parameter(style: imageStyle)?.swiftUIColor)
                .frame(width: Constants.imageSize, height: Constants.imageSize)
                .background(backgroundColor)
                .cornerRadius(LayoutGrid.quadrupleModule / 2)
        }
    }
}
