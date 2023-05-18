//
//  MapButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//
import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public enum MapButtonType {
    case plus
    case minus
    case location
    case custom(image: Image)
}
/**
 The style for creating the Map Button. The presented style is used to create buttons on the map
 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons of the following types: (plus, minus, location and custom by specifying your own image) by specifying the size type in the initial button style
 ## Example to create button with MapButtonStyle:
 # Code
 ```
 Button(action: {}, label: {})
       .buttonStyle(MapButtonStyle(type: .plus))
 ```
*/
@available(iOS 14.0.0, *)
public struct MapButtonStyle: ButtonStyle {

    // MARK: - Public Properties

    public let image: Image

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<MapButtonScheme>

    // MARK: - Initializer

    public init(
        type: MapButtonType,
        schemeProvider: SchemeProvider<MapButtonScheme> = AppThemeSchemeProvider<MapButtonScheme>()
    ) {
        self.schemeProvider = schemeProvider
        switch type {
        case .plus:
            image = SymbolsNew.Service.Outline.plus.swiftUIImage
        case .minus:
            image = SymbolsNew.Service.Outline.minus.swiftUIImage
        case .location:
            image = SymbolsNew.Location.Solid.gps.swiftUIImage
        case .custom(let image):
            self.image = image
        }
    }

    // MARK: - Public Methods

    public func makeBody(configuration: Self.Configuration) -> some View {
        MapButton(
            image: image,
            schemeProvider: schemeProvider,
            configuration: configuration
        )
    }
}

@available(iOS 14.0.0, *)
private extension MapButtonStyle {
    struct MapButton: View {

        // MARK: - Constants
        enum Constants {
            static let cornerRadius: CGFloat = LayoutGrid.module
        }

        // MARK: - Environment
        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        var image: Image

        private var schemeProvider: SchemeProvider<MapButtonScheme>

        // MARK: - Initializer

        init(
            image: Image,
            schemeProvider: SchemeProvider<MapButtonScheme>,
            configuration: Configuration
        ) {
            self.configuration = configuration
            self.schemeProvider = schemeProvider
            self.image = image
        }

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let backgroundColor = configuration.isPressed ? scheme.backgroundColor.parameter(for: .highlighted)?.swiftUIColor : scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor
            image
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.halfModule * 10)
                .foregroundColor(scheme.imageTintColor.swiftUIColor)
                .background(
                    RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 10)
                        .shadow(
                            color: scheme.shadowColor.swiftUIColor,
                            radius: Constants.cornerRadius,
                            x: 0,
                            y: LayoutGrid.halfModule
                        )
                        .foregroundColor(backgroundColor)
                )
        }
    }
}

@available(iOS 14.0, *)
struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}, label: {})
            .buttonStyle(MapButtonStyle(type: .plus))
    }
}
