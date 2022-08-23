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

    // MARK: - Properties

    /// The pressing flag of InputNumberButton
    @Binding public var isPressing: Bool

    /// The background color of InputNumberButton
    public var backgroundColor = ControlParameter<AColor>()

    /// The tint color of InputNumberButton
    public var tintColor = ControlParameter<AColor>()

    /// The image of InputNumberButton
    public var image: Image

    /// The tap action of InputNumberButton
    public var onTap: () -> ()

    // MARK: - Initializer

    public init(
        isPressing: Binding<Bool>,
        backgroundColor: ControlParameter<AColor>,
        tintColor: ControlParameter<AColor>,
        image: Image,
        onTap: @escaping () -> ()) {
        self._isPressing = isPressing
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.image = image
        self.onTap = onTap
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> some View {
        InputNumberButton(
            configuration: configuration,
            backgroundColor: backgroundColor,
            tintColor: tintColor,
            image: image,
            onTap: onTap,
            isPressing: $isPressing
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
        let backgroundColor: ControlParameter<AColor>
        let tintColor: ControlParameter<AColor>
        let image: Image
        let onTap: () -> ()

        @Binding var isPressing: Bool

        // MARK: - Body

        var body: some View {
            let tintNormal = tintColor.parameter(for: .normal)?.swiftUIColor
            let tintDisabled = tintColor.parameter(for: .disabled)?.swiftUIColor
            let tint = isEnabled ? tintNormal : tintDisabled

            let backgroundNormal = backgroundColor.parameter(for: .normal)?.swiftUIColor
            let bacroundDisabled = backgroundColor.parameter(for: .disabled)?.swiftUIColor
            let backgroundHighlighted = backgroundColor.parameter(for: .highlighted)?.swiftUIColor
            let background = isEnabled ? (configuration.isPressed ? backgroundHighlighted : backgroundNormal) : bacroundDisabled

            image
                .foregroundColor(tint)
                .frame(width: 40.0)
                .frame(height: 40.0)
                .background(
                    RoundedRectangle(cornerRadius: 20.0)
                            .foregroundColor(background)
                )
                .onTapGesture {
                    onTap()
                }
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                    self.isPressing = pressing
                }, perform: {})

        }
    }
}
