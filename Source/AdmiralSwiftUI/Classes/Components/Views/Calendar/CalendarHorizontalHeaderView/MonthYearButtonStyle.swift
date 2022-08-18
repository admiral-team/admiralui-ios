//
//  MonthYearButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 18.08.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

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

    @State private var scheme: MonthYearButtonScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<MonthYearButtonScheme>()

    // MARK: - Initializer

    public init(
        image: Image? = nil,
        scheme: MonthYearButtonScheme? = nil
    ) {
        self.scheme = scheme
        self.image = image
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        MonthYearButton(
            configuration: configuration,
            image: image,
            scheme: scheme
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
        let scheme: MonthYearButtonScheme

        // MARK: - Body

        var body: some View {
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
