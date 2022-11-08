//
//  InputNumber.swift
//  AdmiralSwiftUI
//
//  Created on 12.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 InputNumber - A object that displays an editable text area with incrementing or decrementing a value.

 You can create a InputNumber by specifying the following parameters in the initializer
 ## Initializer parameters:
 - titleText - leading text
 - value - the numeric value of the stepper
 - minimumValue - the lowest possible numeric value for the stepper
 - maximumValue - the highest possible numeric value for the stepper
 - stepValue - the step, or increment, value for the stepper. The default value for this property is 1.
 ## Example to create InputNumber:
 # Code
 ```
 @State static var value: Double = 10.0
 InputNumber(
 titleText: .constant("Optional text"),
 value: .constant(10),
 minimumValue: .constant(5.0))
 ```
 */
@available(iOS 14.0, *)
/// An object that displays an editable text area with incrementing or decrementing a value.
public struct InputNumber: View {

    // MARK: - Constants

    enum Constants {
        static let height: CGFloat = LayoutGrid.module * 6
        static let buttonHeight: CGFloat = LayoutGrid.module * 5
        static let buttonWidth: CGFloat = LayoutGrid.module * 5
        static let titleHeight: CGFloat = LayoutGrid.halfModule * 5
        static let tick: TimeInterval = 0.25
        static let countTick: Float = 0.25

        static let firstStepMultiplier: Double = 5
        static let secondStepMultiplier: Double = 10
        static let thirdStepMultiplier: Double = 100

        enum TitleLabel {
            static let defaultWidth: CGFloat = 48.0
            static let maxWidth: CGFloat = 102.0
        }
    }

    // MARK: - Internal Properties

    @Environment(\.isEnabled) var isEnabled

    @State var isMinusPressing = false
    @State var isPlusPressing = false

    // MARK: - Private Properties

    @Binding private var titleText: String?

    /// The numeric value of the stepper.
    @Binding private var value: Double

    /// The lowest possible numeric value for the stepper.
    @Binding private var minimumValue: Double

    /// The highest possible numeric value for the stepper.
    @Binding private var maximumValue: Double

    /// The step, or increment, value for the stepper. The default value for this property is 1.
    @Binding private var stepValue: Double

    @ObservedObject private var schemeProvider: SchemeProvider<InputNumberScheme>

    @State private var valueText: String?

    @State private var isMinusButtonDisabled: Bool = false
    @State private var isPlusButtonDisabled: Bool = false

    @State private var inputStepValue: Double = 1.0
    @State private var timer: Timer?
    @State private var runCount: Float = 0

    @State private var segmentSize: CGSize = .zero

    private var style: InputNumberStyle = .default

    @State private var updatedWidth: CGFloat = 0.0

    /// Adds an action to perform when the user submits a value to this view.
    private var onSubmit: (() -> Void)? = nil

    /// The value indicating whether this object is the first responder.
    private var isResponder: Binding<Bool>? = nil

    /// Text field formatter.
    private var formatter: Formatter? = nil

    /// Constants that identify the semantic meaning for a text-entry area.
    private var textContentType: UITextContentType? = nil

    // Flag is disable pasting. If flasg is true pasting is enabled.
    private var canPerformActionPaste: Bool = true

    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private var onCursorPosition: ((Int, Int, String) -> (Int))? = nil

    /// The semantic meaning for a text input area.
    private var contentType: UIKeyboardType = .default

    /// The visible title of the Return key.
    private var returnKeyType: UIReturnKeyType = .default

    /// The autocapitalization style for the text object.
    private var autocapitalizationType: UITextAutocapitalizationType = .allCharacters

    /// The autocorrection style for the text object.
    private var autocorrectionType: UITextAutocorrectionType = .default

    private var accessibilityIdentifier: String? = nil
    private var placeholder: String?
    private var textfieldWidth: CGFloat?

    // MARK: - Initializer

    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - titleText: Leading text.
    ///   - value: The numeric value of the stepper.
    ///   - minimumValue: The lowest possible numeric value for the stepper.
    ///   - maximumValue: he highest possible numeric value for the stepper.
    ///   - stepValue: The step, or increment, value for the stepper.
    public init(
        titleText: Binding<String?>,
        value: Binding<Double>,
        minimumValue: Binding<Double> = .constant(0.0),
        maximumValue: Binding<Double> = .constant(.infinity),
        stepValue: Binding<Double> = .constant(1.0),
        style: InputNumberStyle = .default,
        schemeProvider: SchemeProvider<InputNumberScheme> = AppThemeSchemeProvider<InputNumberScheme>()
    ) {
        self._titleText = titleText
        self._value = value
        self._minimumValue = minimumValue
        self._maximumValue = maximumValue
        self._stepValue = stepValue
        self.style = style
        self.schemeProvider = schemeProvider
    }

    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - titleText: Leading text.
    ///   - value: The numeric value of the stepper.
    ///   - minimumValue: The lowest possible numeric value for the stepper.
    ///   - maximumValue: he highest possible numeric value for the stepper.
    ///   - stepValue: The step, or increment, value for the stepper.
    public init(
        titleText: Binding<String?>,
        value: Binding<Double>,
        minimumValue: Binding<Double> = .constant(0.0),
        maximumValue: Binding<Double> = .constant(.infinity),
        stepValue: Binding<Double> = .constant(1.0),
        style: InputNumberStyle = .default,
        textfieldWidth: CGFloat? = nil,
        placeholder: String? = nil,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        textContentType: UITextContentType? = nil,
        canPerformActionPaste: Bool = true,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        schemeProvider: SchemeProvider<InputNumberScheme> = AppThemeSchemeProvider<InputNumberScheme>()
    ) {
        self.init(
            titleText: titleText,
            value: value,
            minimumValue: minimumValue,
            maximumValue: maximumValue,
            stepValue: stepValue,
            style: style,
            schemeProvider: schemeProvider)

        self.textfieldWidth = textfieldWidth
        self.placeholder = placeholder
        self.contentType = contentType
        self.canPerformActionPaste = canPerformActionPaste
        self.onSubmit = onSubmit
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textContentType = textContentType
        self.isResponder = isResponder
        self.formatter = formatter
        self.onCursorPosition = onCursorPosition
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        let spacerOffset = style == .input ? LayoutGrid.halfModule / 2 : LayoutGrid.module

        ZStack(alignment: .leading) {
            HStack(spacing: 0.0) {
                Text(titleText ?? "")
                    .font(scheme.titleFont.parameter(for: .normal)?.swiftUIFont)
                    .foregroundColor(scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                Spacer()

                minusButton()
                    .buttonStyle(
                        InputNumberButtonStyle(
                            isPressing: $isMinusPressing,
                            image: Image(uiImage: Asset.Service.Outline.minusOutline.image),
                            style: style,
                            type: .left,
                            onTap: { tapMinus() },
                            schemeProvider: .constant(scheme: scheme.buttonScheme)
                        )
                    )
                Spacer()
                    .frame(width: spacerOffset)

                mainContent()

                Spacer()
                    .frame(width: spacerOffset)
                plusButton()
                    .buttonStyle(
                        InputNumberButtonStyle(
                            isPressing: $isPlusPressing,
                            image: Image(uiImage: Asset.Service.Outline.minusOutline.image),
                            style: style,
                            type: .right,
                            onTap: { tapPlus() },
                            schemeProvider: .constant(scheme: scheme.buttonScheme)
                        )
                    )
            }
            .frame(height: Constants.height)
            .onAppear(perform: {
                setInitialNumberValue()
            })
        }
    }

    // MARK: - Internal Methods

    func runTimedMinusCode() {
        setStepValue()
        tapMinus()
    }

    func runTimedPlusCode() {
        setStepValue()
        tapPlus()
    }

    // MARK: - Private Methods

    private func mainContent() -> some View {
        let scheme = schemeProvider.scheme
        var backColor: Color?
        if style == .input {
            backColor = scheme.textFieldBackground.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor
        }

        return HStack {
            switch style {
            case .default, .secondary:
                defaultContent()
            case .input:
                inputContent()
            }
        }
        .frame(
            width: min(max(segmentSize.width + LayoutGrid.module, Constants.TitleLabel.defaultWidth), Constants.TitleLabel.maxWidth),
            height: LayoutGrid.halfModule * 9
        )
        .background(
            backColor
        )
    }

    @ViewBuilder
    private func plusButton() -> some View {
        Button(action: {}, label: {})
            .onChange(of: isPlusPressing) { value in
                if value {
                    timer?.invalidate()
                    timer = Timer.scheduledTimer(
                        withTimeInterval: Constants.tick,
                        repeats: true) { timer in
                            runTimedPlusCode()
                        }
                } else {
                    finishTimer()
                }
            }
            .disabled(isPlusButtonDisabled)
    }

    @ViewBuilder
    private func minusButton() -> some View {
        Button(action: {}, label: {})
            .onChange(of: isMinusPressing) { value in
                if value {
                    timer?.invalidate()
                    timer = Timer.scheduledTimer(
                        withTimeInterval: Constants.tick,
                        repeats: true) { timer in
                            runTimedMinusCode()
                        }
                } else {
                    finishTimer()
                }
            }
            .disabled(isMinusButtonDisabled)
    }

    @ViewBuilder
    private func defaultContent() -> some View {
        let scheme = schemeProvider.scheme
        
        Text(valueText ?? "")
            .fixedSize()
            .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
            .foregroundColor(scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
    }

    @ViewBuilder
    private func inputContent() -> some View {
        let scheme = schemeProvider.scheme

        Spacer()
            .frame(width: LayoutGrid.halfModule)
        UIKitTextField(
            text: $valueText,
            isResponder: isResponder,
            placeholder: placeholder,
            formatter: formatter,
            keyboard: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            textContentType: textContentType,
            canPerformActionPaste: canPerformActionPaste,
            textColor: scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.uiColor ?? .clear,
            placeholderColor: scheme.placeholderColor.parameter(for: isEnabled ? .normal : .disabled)?.uiColor ?? .clear,
            textAlignment: .center,
            font: scheme.textFieldFont.uiFont,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition,
            updateWidth: $updatedWidth,
            accessibilityIdentifier: accessibilityIdentifier
        )
        .fixedSize(horizontal: isFixedTextFieldSize(), vertical: true)
        .frame(width: textFieldWidth())
        .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
        .onChange(of: valueText) { _ in
            updateTextValueState()
        }
        Spacer()
            .frame(width: LayoutGrid.halfModule)
    }

    private func isFixedTextFieldSize() -> Bool {
        var isFixedSize = updatedWidth < Constants.TitleLabel.maxWidth
        if textfieldWidth != nil {
            isFixedSize = false
        }
        return isFixedSize
    }

    private func textFieldWidth() -> CGFloat? {
        var width = updatedWidth < Constants.TitleLabel.maxWidth ? nil : Constants.TitleLabel.maxWidth
        if let textfieldWidth = textfieldWidth {
            width = textfieldWidth
        }
        return width
    }

    private func setStepValue() {
        runCount += Constants.countTick
        if runCount < Constants.countTick * 5 {
            inputStepValue = stepValue
        } else if runCount >= Constants.countTick * 5 && runCount < Constants.countTick * 12 {
            inputStepValue = stepValue * Constants.firstStepMultiplier
        } else if runCount >= Constants.countTick * 12 && runCount < Constants.countTick * 20 {
            inputStepValue = stepValue * Constants.secondStepMultiplier
        } else {
            inputStepValue = stepValue * Constants.thirdStepMultiplier
        }
    }

    private func tapMinus() {
        if value - inputStepValue <= minimumValue {
            value = minimumValue
            isMinusButtonDisabled = true
        } else {
            value -= inputStepValue
        }
        isPlusButtonDisabled = false
        updateValueState()
    }

    private func tapPlus() {
        if value + inputStepValue >= maximumValue {
            value = maximumValue
            isPlusButtonDisabled = true
        } else {
            value += inputStepValue
        }
        isMinusButtonDisabled = false
        updateValueState()
    }

    private func updateTextValueState() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        value = formatter.number(from: valueText ?? "")?.doubleValue ?? 0.0
    }

    private func updateValueState() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        valueText = formatter.string(from: NSNumber(value: value)) ?? ""
    }

    private func setInitialNumberValue() {
        if value >= maximumValue {
            value = maximumValue
            isPlusButtonDisabled = true
        } else if value <= minimumValue {
            value = minimumValue
            isMinusButtonDisabled = true
        }
        updateValueState()
    }

    private func finishTimer() {
        timer?.invalidate()
        timer = nil
        runCount = 0
        inputStepValue = stepValue
    }

}

@available(iOS 14.0, *)
struct InputNumber_Previews: PreviewProvider {
    @State static var value: Double = 10.0

    static var previews: some View {
        InputNumber(titleText: .constant("Optional text"), value: .constant(10), minimumValue: .constant(5.0))

    }
}
