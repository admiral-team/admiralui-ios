//
//  InputNumberButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.05.2021.
//
import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 The style for creating the InputNumber Button.

 To configure the current button style for a view hierarchy, use the buttonStyle(_:) modifier.
 You can create buttons in three sizes: (small, medium, big) by specifying size Type in init InputNumberButtonStyle:
 # Code
 ```
 Button("Text", action: {})
 .buttonStyle(InputNumberButtonStyle())
 ```

 You can create a button with an activity indicator instead of text by specifying isPressing: .constant(true) in init InputNumberButtonStyle. In this case, the text that you pass to the Button will not be shown, but the activity indicator will be shown instead:
 */
@available(iOS 14.0.0, *)
public struct InputNumberButtonStyle: ButtonStyle {

    // MARK: - Public Properties

    /// The pressing flag of InputNumberButton
    @Binding public var isPressing: Bool

    /// The image of InputNumberButton
    public var image: Image

    /// The tap action of InputNumberButton
    public var onTap: () -> ()

    /// The button style
    public var style: InputNumberStyle

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<InputNumberButtonScheme>

    // MARK: - Initializer

    public init(
        isPressing: Binding<Bool>,
        image: Image,
        style: InputNumberStyle,
        onTap: @escaping () -> (),
        schemeProvider: SchemeProvider<InputNumberButtonScheme> = AppThemeSchemeProvider<InputNumberButtonScheme>()
    ) {
        self._isPressing = isPressing
        self.image = image
        self.onTap = onTap
        self.style = style
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        InputNumberButton(
            configuration: configuration,
            image: image,
            onTap: onTap,
            isPressing: $isPressing,
            style: style,
            schemeProvider: schemeProvider
        )
    }
}

@available(iOS 14.0.0, *)
private extension InputNumberButtonStyle {
    struct InputNumberButton: View {

        // MARK: - Environment

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Internal Properties

        let configuration: Configuration
        let image: Image
        let onTap: () -> ()
        let style: InputNumberStyle

        @Binding var isPressing: Bool

        // MARK: - Private Properties

        private var schemeProvider: SchemeProvider<InputNumberButtonScheme>

        // MARK: - Computed Properties

        private var buttonSize: CGSize {
            switch style {
            case .default:
                return .init(width: LayoutGrid.module * 5, height: LayoutGrid.module * 5)
            case .secondary:
                return .init(width: LayoutGrid.doubleModule * 2, height: LayoutGrid.doubleModule * 2)
            }
        }

        private var buttonBorderRadius: CGFloat {
            switch style {
            case .default:
                return LayoutGrid.halfModule * 5
            case .secondary:
                return LayoutGrid.module
            }
        }

        private var borderWidth: CGFloat {
            switch style {
            case .default:
                return .zero
            case .secondary:
                return LayoutGrid.halfModule / 2
            }
        }

        // MARK: - Initializer

        init(
            configuration: Configuration,
            image: Image,
            onTap: @escaping () -> (),
            isPressing: Binding<Bool>,
            style: InputNumberStyle,
            schemeProvider: SchemeProvider<InputNumberButtonScheme>
        ) {
            self.configuration = configuration
            self.image = image
            self.onTap = onTap
            self._isPressing = isPressing
            self.style = style
            self.schemeProvider = schemeProvider
        }

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let tintNormal = scheme.tintColor.parameter(for: .normal, style: style)?.swiftUIColor
            let tintDisabled = scheme.tintColor.parameter(for: .disabled, style: style)?.swiftUIColor
            let tint = isEnabled ? tintNormal : tintDisabled

            let backgroundNormal = scheme.backgroundColor.parameter(for: .normal, style: style)?.swiftUIColor
            let bacroundDisabled = scheme.backgroundColor.parameter(for: .disabled, style: style)?.swiftUIColor
            let backgroundHighlighted = scheme.backgroundColor.parameter(for: .highlighted, style: style)?.swiftUIColor

            let borderNormal = scheme.borderColor.parameter(for: .normal, style: style)?.swiftUIColor
            let borderDisabled = scheme.borderColor.parameter(for: .disabled, style: style)?.swiftUIColor
            let borderHighlighted = scheme.borderColor.parameter(for: .highlighted, style: style)?.swiftUIColor

            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : bacroundDisabled
            let borderColor = isEnabled ? (configuration.isPressed ? borderHighlighted : borderNormal) : borderDisabled

            image
                .foregroundColor(tint)
                .frame(width: buttonSize.width, height: buttonSize.height)
                .overlay(
                    RoundedRectangle(cornerRadius: buttonBorderRadius)
                        .strokeBorder(borderColor ?? .clear, lineWidth: borderWidth)
                )
                .background(
                    RoundedRectangle(cornerRadius: buttonBorderRadius)
                        .fill(background ?? .clear)
                )
                .onTapGesture {
                    onTap()
                }
                .onLongPressGesture(
                    minimumDuration: .infinity,
                    pressing: { pressing in
                        self.isPressing = pressing
                    }, perform: {}
                )
        }
    }
}
