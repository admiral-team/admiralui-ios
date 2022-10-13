//
//  InputNumber.swift
//  AdmiralSwiftUI
//
//  Created on 12.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/// The value that changes buttons style
public enum InputNumberStyle: Int {
    /// The value that presents rounded buttons
    case `default`
    /// The value that presents button with border
    case secondary
}
/**
 InputNumber - A object that displays an editable text area with incrementing or decrementing a value.

 You can create a InputNumber by specifying the following parameters in the initializer
 ## Initializer parameters:
 - titleText - leading text
 - value - the numeric value of the stepper
 - minimumValue - the lowest possible numeric value for the stepper
 - maximumValue - the highest possible numeric value for the stepper
 - style: The value that presents button in two styles - default, secondary
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

    private let style: InputNumberStyle

    // MARK: - Initializer

    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - titleText: Leading text.
    ///   - value: The numeric value of the stepper.
    ///   - minimumValue: The lowest possible numeric value for the stepper.
    ///   - maximumValue: he highest possible numeric value for the stepper.
    ///   - style: The value that presents button in two styles
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

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme

        ZStack(alignment: .leading) {
            HStack(spacing: 0.0) {
                Text(titleText ?? "")
                    .font(scheme.titleFont.parameter(for: .normal)?.swiftUIFont)
                    .foregroundColor(scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                Spacer()
                Button(action: {}, label: {})
                    .buttonStyle(
                        InputNumberButtonStyle(
                            isPressing: $isMinusPressing,
                            image: Image(uiImage: Asset.Service.Outline.minusOutline.image),
                            style: style,
                            onTap: {
                                tapMinus()
                            },
                            schemeProvider: .constant(scheme: scheme.buttonScheme)
                        )
                    )
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
                Spacer()
                    .frame(width: LayoutGrid.module)
                HStack {
                    Text(valueText ?? "")
                        .fixedSize()
                        .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
                        .foregroundColor(scheme.textColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                }
                .frame(width: min(max(segmentSize.width, Constants.TitleLabel.defaultWidth), Constants.TitleLabel.maxWidth))
                Spacer()
                    .frame(width: LayoutGrid.module)
                Button(action: {}, label: {})
                    .buttonStyle(
                        InputNumberButtonStyle(
                            isPressing: $isPlusPressing,
                            image: Image(uiImage: Asset.Service.Outline.plusOutline.image),
                            style: style,
                            onTap: { tapPlus() },
                            schemeProvider: .constant(scheme: scheme.buttonScheme)
                        )
                    )
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
        InputNumber(titleText: .constant("Optional text"), value: .constant(10), minimumValue: .constant(5.0), style: .default)

    }
}
