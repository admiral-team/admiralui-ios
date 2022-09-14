import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 MapButtonScheme - the visual scheme of MapButtonStyle.
 You can create a by specifying the following parameters in init:
 - MapButtonScheme() - Initialize default MapButtonScheme with default themezation
 Example to create MapButtonScheme:
 Code
 ```
 let scheme = MapButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct MapButtonScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The image color
    public let imageTintColor: AColor

    /// The shadow color
    public let shadowColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundExtraSurface, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .highlighted)
        imageTintColor = theme.colors.elementPrimary
        shadowColor = theme.colors.backgroundShadow
    }

}
