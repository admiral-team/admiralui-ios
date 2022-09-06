//
//  CirclePageControl.swift
//  AdmiralSwiftUI
//
//  Created on 11.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 The style for creating the CirclePageControl Button.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in two styles: (default, additional) by specifying style in init CirclePageControlStyle:
 # Code
 ```
 Button(action: {}, label: {})
     .buttonStyle(CirclePageControlStyle(totalPages: 7, style: .additional))
 ```
 You can create a buttin with CirclePageControlStyle specifying the following parameters in init:

 step: Binding<Int> - The current page of page control.
 style: CirclePageSliderStyle - The style of button.
 totalPages: Int - The number of pages of page control.

 There is two types of style:
 Additional - the style with additional colors in elements including cirle, progress indicator and arrow icon;
 Default - the style with accent colors in elements including cirle, progress indicator and arrow icon

 # Code
 ```
 Button(action: {}, label: {})
     .buttonStyle(CirclePageControlStyle(totalPages: 7, style: .additional))
 ```
*/
@available(iOS 14.0.0, *)
public struct CirclePageControlStyle: ButtonStyle {

    // MARK: - Public properties
    
    /// Step page control.
    @Binding public var step: Int
    /// Total count pages.
    public var totalPages: Int = 0
    /// Page control style.
    public let style: CirclePageSliderStyle
    /// The action to perform when the user triggers the button.
    public let action: (() -> Void)?

    // MARK: - Private properties

    private var scheme: CirclePageControlScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<CirclePageControlScheme>

    // MARK: - Initializier

    public init(
        step: Binding<Int>,
        totalPages: Int,
        style: CirclePageSliderStyle = .default,
        action: (() -> Void)? = nil,
        scheme: CirclePageControlScheme? = nil,
        schemeProvider: SchemeProvider<CirclePageControlScheme> = AppThemeSchemeProvider<CirclePageControlScheme>()
    ) {
        self.totalPages = totalPages
        self.style = style
        self._step = step
        self.scheme = scheme
        self.action = action
        self.schemeProvider = schemeProvider
    }

    // MARK: - Public methods

    public func makeBody(configuration: Self.Configuration) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        CirclePageControl(
            totalPages: totalPages,
            step: $step,
            style: style,
            scheme: scheme,
            schemeProvider: schemeProvider,
            action: action,
            configuration: configuration
        )
    }
}

@available(iOS 14.0.0, *)
public enum CirclePageSliderStyle: Int {
    case `default`
    case additional
}

@available(iOS 14.0.0, *)
private extension CirclePageControlStyle {
    struct CirclePageControl: View {

        // MARK: - Constants

        private enum Constants {
            static let circleSize: CGFloat = LayoutGrid.tripleModule * 2
            static let progressFrameSize: CGFloat = LayoutGrid.tripleModule * 3
            static let circleLineWidth: CGFloat = LayoutGrid.module / 4
            static let progressRotationAngle: Double = 270
        }

        // MARK: - Private Properties

        @Binding private var step: Int
        private let style: CirclePageSliderStyle
        private let totalPages: Int
        private let configuration: Configuration
        private let stepLength: CGFloat
        private let action: (() -> Void)?
        private let scheme: CirclePageControlScheme
        private let schemeProvider: SchemeProvider<CirclePageControlScheme>

        // MARK: - Initializer

        init(
            totalPages: Int,
            step: Binding<Int>,
            style: CirclePageSliderStyle,
            scheme: CirclePageControlScheme,
            schemeProvider: SchemeProvider<CirclePageControlScheme>,
            action: (() -> Void)?,
            configuration: Configuration
        ) {
            self.scheme = scheme
            self._step = step
            self.configuration = configuration
            self.totalPages = totalPages
            self.style = style
            self.action = action
            self.schemeProvider = schemeProvider
            stepLength = 1.0 / CGFloat(totalPages)
        }

        // MARK: - Layout

        var body: some View {
            contentView()
                .onTapGesture {
                    if step < totalPages {
                        step += 1
                    }
                    action?()
                }
        }

        // MARK: - Private methods

        private func contentView() -> some View {
            ZStack {

                Circle()
                    .trim(from: .zero, to: CGFloat(step) * stepLength)
                    .stroke(style: StrokeStyle(lineWidth: Constants.circleLineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(scheme.backgroundColor.parameter(for: configuration.isPressed, style: style)?.swiftUIColor)
                    .frame(width: Constants.progressFrameSize, height: Constants.progressFrameSize)
                    .rotationEffect(.init(degrees: Constants.progressRotationAngle))
                    .animation(.linear)
                if let color = scheme.backgroundColor.parameter(for: configuration.isPressed, style: style) {
                    Circle()
                        .fill(color.swiftUIColor)
                        .frame(width: Constants.circleSize, height: Constants.circleSize)
                }
                if let imageTintColor = scheme.imageTintColor.parameter(for: configuration.isPressed, style: style) {
                    AssetSymbol.System.Outline.arrowRight.image
                        .foregroundColor(imageTintColor.swiftUIColor)
                }
            }
        }
    }

}

@available(iOS 14.0, *)
private struct exampleCircleControl: View {
    @State var step: Int = 0
    var body: some View {
        Button(action: {}, label: {})
            .buttonStyle(CirclePageControlStyle(step: $step, totalPages: 7, style: .default))
    }
}

@available(iOS 14.0, *)
struct CirclePageControl_Previews: PreviewProvider {

    static var previews: some View {
        exampleCircleControl()
    }
    
}
