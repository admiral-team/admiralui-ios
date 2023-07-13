//
//  MonthYearButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import SwiftUI
import AdmiralTheme
/**
 The style for creating the MonthYearButton. MonthYearButton - the components that present a button with image in CalendarView..
 You can create a SeveralPinButtonStyle by specifying the following parameters in the initializer
 ## Initializer parameters:
 - image - Image? - The image of MonthYearButton.
 ## Example to create :
 # Code
 ```
 static var body: some View {
 Button(
        action: {},
        label: {Text("Button")})
        .buttonStyle(MonthYearButtonStyle(image: nil))
 ```
 */
@available(iOS 14.0.0, *)
public struct MonthYearButtonStyle: ButtonStyle {

    // MARK: - Private Properties

    private var image: Image?

    @ObservedObject var schemeProvider: SchemeProvider<MonthYearButtonScheme>

    // MARK: - Initializer

    public init(
        image: Image? = nil,
        schemeProvider: SchemeProvider<MonthYearButtonScheme> = AppThemeSchemeProvider<MonthYearButtonScheme>()
    ) {
        self.schemeProvider = schemeProvider
        self.image = image
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        MonthYearButton(
            configuration: configuration,
            image: image,
            schemeProvider: schemeProvider
        )
    }

}

@available(iOS 14.0.0, *)
private extension MonthYearButtonStyle {
    struct MonthYearButton: View {

        // MARK: - Environment

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Internal Properties

        let configuration: Configuration
        let image: Image?

        var schemeProvider: SchemeProvider<MonthYearButtonScheme>

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let color = isEnabled ?
            (configuration.isPressed ? scheme.textColor.parameter(for: .highlighted)?.swiftUIColor : scheme.textColor.parameter(for: .normal)?.swiftUIColor)
            : scheme.textColor.parameter(for: .disabled)?.swiftUIColor

            HStack(alignment: .center, spacing: LayoutGrid.module) {
                configuration.label
                    .font(scheme.font.swiftUIFont)
                    .foregroundColor(color)
                    .frame(height: 48.0)
                image
                    .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.halfModule * 7)
                    .foregroundColor(color)
            }
        }
    }
}
