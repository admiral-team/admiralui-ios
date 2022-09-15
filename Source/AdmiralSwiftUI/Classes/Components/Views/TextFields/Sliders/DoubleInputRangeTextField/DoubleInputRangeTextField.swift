//
//  DoubleInputRangeTextField.swift
//  AdmiralSwiftUI
//
//  Created on 29.09.2021.
//

import AdmiralUIResources
import AdmiralTheme
import SwiftUI

/**
 DoubleInputRangeTextField - An object that displays an editable text area and slider.

 You can create a DoubleInputRangeTextField with the zero frame rectangle by specifying the following parameters in init:

 - contentFrom: String? - The text that the text field displays.
 - contentTo: String? - The text that the text field displays.
 - state: TextInputState - The textfield state.
 - contentType: UIKeyboardType - The semantic meaning for a text input area.
 - returnKeyType: UIReturnKeyType - The visible title of the Return key.
 - autocapitalizationType: UITextAutocapitalizationType - The autocapitalization style for the text object.
 - autocorrectionType: UITextAutocorrectionType - The autocorrection style for the text object.
 - placeholderFrom: String - The string that displays when there is no other text in the text field.
 - placeholderTo: String - The string that displays when there is no other text in the text field.
 - name: String - The text field’s name.
 - info: String - The string that displays some additional info.
 - infoNumberOfLines: Int? - The maximum number of lines to use for info.
 - isResponderFrom: Binding<Bool>? - The value indicating whether this object is the first responder.
 - isResponderTo: Binding<Bool>? - The value indicating whether this object is the first responder.
 - leadingText: String? - Leading text.
 - trailingText: String? - Trailing text.
 - onSubmit: (() -> Void)? - Adds an action to perform when the user submits a value to this view.
 - formatter: Formatter? - Text field formatter.
 
 ## Example to create DoubleInputRangeTextField
 # Code
 ```
 DoubleInputRangeTextField(
 .constant("Binding simple text"),
 contentTo: .constant("Binding content"),
 placeholderFrom: "PlaceholderFrom",
 placeholderTo: "PlaceholderTo",
 name: "Optional label",
 state: $state,
 info: .constant("Additional text"),
 sliderValueFrom: 100,
 sliderValueTo: 300,
 minValue: 100,
 maxValue: 1000,
 leadingText: .constant("₽"),
 trailingText: .constant("₽")
 )
 ```
 
 Also DoubleInputRangeTextField has public func to sets the state text field:
 
 - parameter state: The state that the text field displays.
 - returns: Input range text field.
 
 # Code
 ```
 public func state(_ state: TextInputState) -> DoubleInputRangeTextField
 ```
 */
/// An object that displays an editable text area and slider.
@available(iOS 14.0, *)
public struct DoubleInputRangeTextField: AccessabilitySupportUIKit, Identifiable {
    
    // MARK: - Constants
    
    enum Constants {
        static let textFrom = "От"
        static let textTo = "До"
        static let maxSymbols = 12
    }
    
    // MARK: - Public Properties
    
    /// Unique id.
    public let id = UUID()
    
    // MARK: - Internal Properties
    
    @State var isTextFieldResponderFrom: Bool = false
    @State var isTextFieldResponderTo: Bool = false
    
    @State var isFocusedFrom: Bool = false
    @State var isFocusedTo: Bool = false
    
    @State var isFilledFrom: Bool = false
    @State var isFilledTo: Bool = false
    
    @State var sliderValueFrom: Double = 0
    @State var sliderValueTo: Double = 0
    @State var minValue: Double = 0
    @State var maxValue: Double = 100
    
    // MARK: - Private Properties
    
    /// The text that the text field displays.
    @Binding private var contentFrom: String?
    
    /// The text that the text field displays.
    @Binding private var contentTo: String?
    
    /// The textfield state.
    @Binding private var state: TextInputState
    
    /// The semantic meaning for a text input area.
    private let contentType: UIKeyboardType
    
    /// The visible title of the Return key.
    private let returnKeyType: UIReturnKeyType
    
    /// The autocapitalization style for the text object.
    private let autocapitalizationType: UITextAutocapitalizationType
    
    /// The autocorrection style for the text object.
    private let autocorrectionType: UITextAutocorrectionType
    
    /// The string that displays when there is no other text in the text field.
    private let placeholderFrom: String
    
    /// The string that displays when there is no other text in the text field.
    private let placeholderTo: String
    
    /// The text field’s name.
    private let name: String
    
    /// The string that displays some additional info.
    @Binding private var info: String
    
    /// The maximum number of lines to use for info.
    private let infoNumberOfLines: Int?
    
    /// The value indicating whether this object is the first responder.
    private var isResponderFrom: Binding<Bool>?
    
    /// The value indicating whether this object is the first responder.
    private var isResponderTo: Binding<Bool>?
    
    /// Leading text.
    @Binding private var leadingText: String?
    
    /// Trailing text.
    @Binding private var trailingText: String?
    
    /// Adds an action to perform when the user submits a value to this view.
    private let onSubmit: (() -> Void)?
    
    /// Text field formatter.
    private let formatter: Formatter?

    private var accessibilityIdentifierFirst: String?
    private var accessibilityIdentifierSecond: String?
    
    @ObservedObject private var schemeProvider: SchemeProvider<DoubleInputRangeTextFieldScheme>
    
    @State private var textViewFromWidth: CGFloat = LayoutGrid.tripleModule
    @State private var textViewWidth: CGFloat = LayoutGrid.tripleModule
    @State private var sizeModifier: CGSize = .zero
    @State private var sizeModifierFrom: CGSize = .zero
    
    @State private var finishAfterChangeSlider: Bool = false
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifierFirst: The id used by accessibility method for firstTextField.
    ///   - accessibilityIdentifierSecond: The id used by accessibility method for second textField.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - sliderValue: The slider’s current value.
    ///   - minValue: The minimum value of the slider.
    ///   - maxValue: The maximum value of the slider.
    public init(
        _ contentFrom: Binding<String?>,
        accessibilityIdentifierFirst: String? = nil,
        accessibilityIdentifierSecond: String? = nil,
        contentTo: Binding<String?>,
        placeholderFrom: String = "",
        placeholderTo: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        sliderValueFrom: Double = 0,
        sliderValueTo: Double = 0,
        minValue: Double = 0,
        maxValue: Double = 100,
        formatter: Formatter? = nil,
        leadingText: Binding<String?> = .constant(nil),
        trailingText: Binding<String?> = .constant(nil),
        isResponderFrom: Binding<Bool>? = nil,
        isResponderTo: Binding<Bool>? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        schemeProvider: SchemeProvider<DoubleInputRangeTextFieldScheme> = AppThemeSchemeProvider<DoubleInputRangeTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil
    ) {
        self._contentFrom = contentFrom
        self._contentTo = contentTo
        self.placeholderFrom = placeholderFrom
        self.placeholderTo = placeholderTo
        self.name = name
        self.formatter = formatter
        self._state = state
        self._info = info
        self._leadingText = leadingText
        self._trailingText = trailingText
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self._sliderValueFrom = .init(initialValue: sliderValueFrom)
        self._sliderValueTo = .init(initialValue: sliderValueTo)
        self._maxValue = .init(initialValue: maxValue)
        self._minValue = .init(initialValue: minValue)
        self._isFilledFrom = .init(initialValue: !(contentFrom.wrappedValue ?? "").isEmpty)
        self._isFilledTo = .init(initialValue: !(contentTo.wrappedValue ?? "").isEmpty)
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isResponderFrom = isResponderFrom
        self.isResponderTo = isResponderTo
        self._isFocusedFrom = .init(initialValue: isResponderFrom?.wrappedValue ?? false)
        self._isFocusedTo = .init(initialValue: isResponderTo?.wrappedValue ?? false)
        self.accessibilityIdentifierFirst = accessibilityIdentifierFirst
        self.accessibilityIdentifierSecond = accessibilityIdentifierSecond
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body
    
    public var body: some View {
        let globalScheme = schemeProvider.scheme
        let style = globalScheme.textField
        let isTextFieldDisabled = state == .disabled || state == .readOnly
        
        let placeholderColor = style.placeholderColor.parameter(for:  isTextFieldDisabled ? .disabled : .normal)
        var textColor = style.textColor
        var tintColor = style.tintColor
        var infoColor = style.placeholderColor.parameter(for: .normal)?.swiftUIColor  ?? .clear
        var nameColor = style.placeholderColor.parameter(for: .normal)?.swiftUIColor ?? .clear
        
        switch state {
        case .error:
            nameColor = style.errorColor.swiftUIColor
            infoColor = style.errorColor.swiftUIColor
            textColor = style.textColor
            tintColor = style.errorColor
        case .disabled:
            nameColor = style.disabledColor.swiftUIColor
            infoColor = style.disabledColor.swiftUIColor
            textColor = style.disabledColor
            tintColor = style.disabledColor
        case .readOnly:
            nameColor = style.disabledColor.swiftUIColor
            infoColor = style.disabledColor.swiftUIColor
            textColor = style.textColor
            tintColor = style.disabledColor
        default:
            break
        }
        
        return ZStack {
            VStack(spacing: 0) {
                placeholderView(
                    placeholderColor: placeholderColor?.swiftUIColor,
                    tintColor: tintColor.swiftUIColor,
                    nameColor: nameColor,
                    textFieldFont: style.textFieldFont.swiftUIFont,
                    informerFont: style.informerFont.swiftUIFont
                )
                textFieldView(
                    placeholderColor: placeholderColor,
                    tintColor: tintColor,
                    textColor: textColor,
                    trailingViewTintColor: style.underlineColor.swiftUIColor,
                    textFieldFont: style.textFieldFont,
                    textFromToFont: globalScheme.textFont,
                    textFromToColor: placeholderColor,
                    isTextFieldDisabled: isTextFieldDisabled
                )
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                DoubleSliderView(
                    valueFrom: $sliderValueFrom,
                    valueTo: $sliderValueTo,
                    minValue: minValue,
                    maxValue: maxValue,
                    segmentSize: $sizeModifier,
                    scheme: globalScheme.slider,
                    gestureChange: {
                        DispatchQueue.main.async {
                            self.finishAfterChangeSlider = true
                            self.isTextFieldResponderTo = false
                        }
                    })
                    .padding(.top, 5)
                    .onChange(of: sliderValueFrom) { value in
                        DispatchQueue.main.async {
                            let text = String(format: "%.0f", value).replacingOccurrences(of: ",", with: ".")
                            contentFrom = text
                        }

                    }
                    .onChange(of: sliderValueTo) { value in
                        DispatchQueue.main.async {
                            let text = String(format: "%.0f", value).replacingOccurrences(of: ",", with: ".")
                            contentTo = text
                        }
                    }
                    .disabled(isTextFieldDisabled)
                Spacer()
                    .frame(height: 16.0)
                minMaxView(
                    placeholderColor: placeholderColor?.swiftUIColor,
                    valueFont: globalScheme.valueFont.swiftUIFont)
                if !info.isEmpty {
                    Text(info)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(infoNumberOfLines)
                        .foregroundColor(infoColor)
                        .font(style.informerFont.swiftUIFont)
                        .padding(.top, LayoutGrid.module)
                        .padding(.bottom, LayoutGrid.halfModule * 3)
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Sets the state text field.
    /// - Parameter state: The state that the text field displays.
    /// - Returns: Input range text field.
    public func state(_ state: TextInputState) -> DoubleInputRangeTextField {
        var view = self
        view._state = $state
        return view
    }
    
    public func accessibility(identifierUIKit: String) -> Self {
        var view = self
        view.accessibilityIdentifierFirst = identifierUIKit
        return view
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: DoubleInputRangeTextFieldScheme) -> some View {
        var view = self
        view.schemeProvider = .constant(scheme: scheme)
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func clear() {
        contentFrom = ""
    }
    
    private func placeholderView(
        placeholderColor: Color?,
        tintColor: Color?,
        nameColor: Color?,
        textFieldFont: SwiftUI.Font?,
        informerFont: SwiftUI.Font?) -> some View {
            HStack(spacing: 0.0) {
                ZStack {
                    Text("\(name)")
                        .offset(x: 0.0)
                        .foregroundColor((isFocusedFrom || isFocusedTo) ? tintColor : nameColor)
                        .font(informerFont)
                }
                Spacer()
            }
        }
    
    private func textFieldView(
        placeholderColor: AColor?,
        tintColor: AColor,
        textColor: AColor,
        trailingViewTintColor: Color,
        textFieldFont: AFont?,
        textFromToFont: AFont?,
        textFromToColor: AColor?,
        isTextFieldDisabled: Bool
    ) -> some View {
        let textHeight = LayoutGrid.quadrupleModule
        let textWidth = round(min(sizeModifier.width / 2 - LayoutGrid.tripleModule, textViewWidth), toNearest: LayoutGrid.halfModule * 3)
        return HStack(spacing: .zero) {
            HStack(spacing: LayoutGrid.halfModule) {
                Text(Constants.textFrom)
                    .multilineTextAlignment(.leading)
                    .font(textFromToFont?.swiftUIFont)
                    .foregroundColor(textFromToColor?.swiftUIColor)
                textFieldFrom(
                    placeholderColor: placeholderColor,
                    tintColor: tintColor,
                    textColor: textColor,
                    trailingViewTintColor: trailingViewTintColor,
                    textFieldFont: textFieldFont,
                    isTextFieldDisabled: isTextFieldDisabled,
                    textWidth: textWidth,
                    textHeight: textHeight
                )
            }
            Spacer(minLength: .zero)
            Text(Constants.textTo)
                .multilineTextAlignment(.trailing)
                .font(textFromToFont?.swiftUIFont)
                .foregroundColor(textFromToColor?.swiftUIColor)
            textFieldTo(
                placeholderColor: placeholderColor,
                tintColor: tintColor,
                textColor: textColor,
                trailingViewTintColor: trailingViewTintColor,
                textFieldFont: textFieldFont,
                isTextFieldDisabled: isTextFieldDisabled,
                textWidth: textWidth,
                textHeight: textHeight
            )
            if let trailingText = trailingText {
                Text(trailingText)
                    .font(textFieldFont?.swiftUIFont)
                    .foregroundColor(textColor.swiftUIColor)
            }
        }
    }

    private func responderFromChange(value: Bool) {
        withAnimation() {
            isFocusedFrom = value
        }
        
        if finishAfterChangeSlider {
            finishAfterChangeSlider = false
            return
        }
        
        if !value {
            if sliderValueFrom < sliderValueTo {
                sliderValueFrom = max(min(sliderValueFrom, maxValue), minValue)
            } else {
                sliderValueFrom = sliderValueTo
            }
            contentFrom = String(format: "%.0f", sliderValueFrom).replacingOccurrences(of: ",", with: ".")
        }
    }
    
    private func responderToChange(value: Bool) {
        withAnimation() {
            isFocusedTo = value
        }
        
        if finishAfterChangeSlider {
            finishAfterChangeSlider = false
            return
        }
        
        if !value {
            
            textViewWidth = 0
            
            if sliderValueTo > sliderValueFrom {
                sliderValueTo = max(min(sliderValueTo, maxValue), minValue)
            } else {
                sliderValueTo = sliderValueFrom
            }
            contentTo = String(format: "%.0f", sliderValueTo).replacingOccurrences(of: ",", with: ".")
        }
    }
    
    private func round(_ value: CGFloat, toNearest: CGFloat) -> CGFloat {
        return Darwin.round(value / toNearest) * toNearest
    }
    
    private func minMaxView(
        placeholderColor: Color?,
        valueFont: SwiftUI.Font?
    ) -> some View {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        formatter.numberStyle = .decimal

        return HStack {
            Text(formatter.string(from: minValue as NSNumber) ?? "")
                .multilineTextAlignment(.leading)
                .font(valueFont)
                .foregroundColor(placeholderColor)
            Spacer()
            Text(formatter.string(from: maxValue as NSNumber) ?? "")
                .multilineTextAlignment(.trailing)
                .font(valueFont)
                .foregroundColor(placeholderColor)
        }
    }

    private func textFieldTo(
        placeholderColor: AColor?,
        tintColor: AColor,
        textColor: AColor,
        trailingViewTintColor: Color,
        textFieldFont: AFont?,
        isTextFieldDisabled: Bool,
        textWidth: CGFloat,
        textHeight: CGFloat
    ) -> some View {
        ZStack {
            if isTextFieldDisabled {
                Text(contentTo ?? "")
                    .foregroundColor(textColor.swiftUIColor)
                    .font(textFieldFont?.swiftUIFont)
                    .frame(width: textWidth, height: textHeight)
                    .disabled(isTextFieldDisabled)
                    .onAppear {
                        isFocusedTo = false
                        isTextFieldResponderTo = false
                    }
            } else {
                if sizeModifier != .zero {
                    UIKitTextView(
                        text: $contentTo,
                        isResponder: isResponderTo == nil ? $isTextFieldResponderTo : isResponderTo,
                        shouldChangeText: { text in
                            if let text = text, text.count > Constants.maxSymbols {
                                return false
                            }
                            return true
                        },
                        fixHeight: LayoutGrid.quadrupleModule,
                        maxWidth: sizeModifier.width / 2 - LayoutGrid.tripleModule,
                        updateWidth: $textViewWidth,
                        isEnabled: !isTextFieldDisabled,
                        keyboard: contentType,
                        returnKeyType: returnKeyType,
                        autocapitalizationType: autocapitalizationType,
                        autocorrectionType: autocorrectionType,
                        textColor: textColor.uiColor,
                        tintColor: tintColor.uiColor,
                        font: textFieldFont?.uiFont,
                        onSubmit: onSubmit ?? {
                            // TODO: - Close keyboard by flag
                            UIApplication.shared.keyWindow?.endEditing(true)
                        },
                        accessibilityIdentifier: accessibilityIdentifierSecond
                    )
                        .zIndex(10)
                        .fixedSize()
                        .onChange(of: contentTo) { value in
                            guard !finishAfterChangeSlider else { return }

                            if(contentTo == "") {
                                withAnimation(.easeInOut) {
                                    isFilledTo = false
                                }
                            } else {
                                withAnimation(.easeInOut) {
                                    isFilledTo = true
                                }
                            }

                            let text = (value ?? "").replacingOccurrences(of: ",", with: ".")
                            guard let val = Double(text) else { return }

                            withAnimation(.easeInOut) {
                                sliderValueTo = val
                            }
                        }
                        .onChange(of: isTextFieldResponderTo) { value in
                            responderToChange(value: value)
                        }
                        .onChange(of: isResponderTo?.wrappedValue ?? false, perform: { value in
                            responderToChange(value: value)
                        })
                }
            }
        }
    }

    private func textFieldFrom(
        placeholderColor: AColor?,
        tintColor: AColor,
        textColor: AColor,
        trailingViewTintColor: Color,
        textFieldFont: AFont?,
        isTextFieldDisabled: Bool,
        textWidth: CGFloat,
        textHeight: CGFloat
    ) -> some View {
        HStack(spacing: LayoutGrid.module) {
            if isTextFieldDisabled {
                HStack {
                    Text(contentFrom ?? "")
                        .foregroundColor(textColor.swiftUIColor)
                        .font(textFieldFont?.swiftUIFont)
                        .frame(width: textWidth, height: textHeight)
                        .disabled(isTextFieldDisabled)
                        .onAppear {
                            self.isFocusedFrom = false
                            self.isTextFieldResponderFrom = false
                        }
                    Spacer()
                }
            } else {
                HStack(spacing: LayoutGrid.halfModule) {
                    UIKitTextField(
                        text: $contentFrom,
                        isResponder: isResponderFrom == nil ? $isTextFieldResponderFrom : isResponderFrom,
                        formatter: formatter ?? BlocFormatter(format: { text in
                            if let text = text, text.count > Constants.maxSymbols {
                                let substring = text.prefix(Constants.maxSymbols)
                                contentFrom = String(substring)
                                return String(substring)
                            } else {
                                contentFrom = text ?? ""
                                return contentFrom
                            }
                        }),
                        keyboard: contentType,
                        returnKeyType: returnKeyType,
                        autocapitalizationType: autocapitalizationType,
                        autocorrectionType: autocorrectionType,
                        textColor: textColor.uiColor,
                        placeholderColor: placeholderColor?.uiColor ?? .clear,
                        tintColor: tintColor.uiColor,
                        font: textFieldFont?.uiFont,
                        onSubmit: onSubmit ?? {
                            // TODO: - Close keyboard by flag
                            UIApplication.shared.keyWindow?.endEditing(true)
                        },
                        accessibilityIdentifier: accessibilityIdentifierFirst
                    )
                        .fixedSize()
                        .onChange(of: contentFrom) { value in
                            guard !finishAfterChangeSlider else { return }

                            if(contentFrom == "") {
                                withAnimation(.easeInOut) {
                                    isFilledFrom = false
                                }
                            } else {
                                withAnimation(.easeInOut) {
                                    isFilledFrom = true
                                }
                            }
                            withAnimation(.easeInOut) {
                                let text = (value ?? "").replacingOccurrences(of: ",", with: ".")
                                guard let val = Double(text) else { return }

                                sliderValueFrom = val
                            }
                        }
                        .onChange(of: isTextFieldResponderFrom) { value in
                            responderFromChange(value: value)
                        }
                        .onChange(of: isResponderFrom?.wrappedValue ?? false, perform: { value in
                            responderFromChange(value: value)
                        })
                    if let leadingText = leadingText {
                        Text(leadingText)
                            .font(textFieldFont?.swiftUIFont)
                            .foregroundColor(textColor.swiftUIColor)
                    }
                }
            }
        }
    }
    
}
