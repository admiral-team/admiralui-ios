//
//  NumberInputButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created by on 13.10.2022.
//  
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
public struct NumberInputButtonStyle: ButtonStyle {

    public enum NumberInputButtonType {
        case left
        case right
    }

    // MARK: - Public Properties

    /// The pressing flag
    @Binding public var isPressing: Bool

    /// The image
    public var image: Image

    /// The tap callback
    public var onTap: () -> ()

    /// The type of direction
    public var type: NumberInputButtonType

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<NumberInputButtonScheme>

    // MARK: - Initializer

    public init(
        isPressing: Binding<Bool>,
        backgroundColor: ControlParameter<AColor>,
        tintColor: ControlParameter<AColor>,
        image: Image,
        type: NumberInputButtonType,
        schemeProvider: SchemeProvider<NumberInputButtonScheme> = AppThemeSchemeProvider<NumberInputButtonScheme>(),
        onTap: @escaping () -> ()
    ) {
        self._isPressing = isPressing
        self.schemeProvider = schemeProvider
        self.image = image
        self.type = type
        self.onTap = onTap
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        NumberInputButton(
            configuration: configuration,
            schemeProvider: schemeProvider,
            image: image,
            type: type,
            onTap: onTap,
            isPressing: $isPressing
        )
    }
}

@available(iOS 14.0.0, *)
private extension NumberInputButtonStyle {
    struct NumberInputButton: View {

        // MARK: - Environment

        @Environment(\.isEnabled) private var isEnabled

        // MARK: - Internal Properties

        let configuration: Configuration
        let schemeProvider: SchemeProvider<NumberInputButtonScheme>
        let image: Image
        let type: NumberInputButtonType
        let onTap: () -> ()

        @Binding var isPressing: Bool

        // MARK: - Body

        var body: some View {
            let scheme = schemeProvider.scheme
            let tintNormal = scheme.tintColor.parameter(for: .normal)?.swiftUIColor
            let tintDisabled = scheme.tintColor.parameter(for: .disabled)?.swiftUIColor
            let tint = isEnabled ? tintNormal : tintDisabled

            let backgroundNormal = scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor
            let bacroundDisabled = scheme.backgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = scheme.backgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : bacroundDisabled

            var corners: UIRectCorner
            if type == .left {
                corners = [.topLeft, .bottomLeft]
            } else {
                corners = [.topRight, .bottomRight]
            }

            return image
                .foregroundColor(tint)
                .frame(width: LayoutGrid.halfModule * 9)
                .frame(height: LayoutGrid.halfModule * 9)
                .background(background)
                .clipShape(RoundedCorner(radius: LayoutGrid.module, corners: corners))
                .onTapGesture {
                    onTap()
                }
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                    self.isPressing = pressing
                }, perform: {})

        }
    }
}
