//
//  InputRangeTextField.swift
//  AdmiralSwiftUI
//
//  Created on 27.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 InputRangeTextField - An object that displays an editable text area and slider.

 You can create a InputRangeTextField with the zero frame rectangle by specifying the following parameters in init:
 - value: The value that the text field displays.
 - content:  The text that the text field displays.
 - placeholderFrom: The string that displays when there is no other text in the text field.
 - trailingView: Traling view.
 - state: The textfield state.
 - contentType:  The semantic meaning for a text input area.
 - returnKeyType: The visible title of the Return key.
 - autocapitalizationType: The autocapitalization style for the text object.
 - accessibilityIdentifier: The id used by accessibility method.
 - autocorrectionType: The autocorrection style for the text object.
 - formatter: Text field formatter.
 - placeholder: The string that displays when there is no other text in the text field.
 - name: The text field’s name.
 - icon:  The text field’s traling image view.
 - state: The textfield state.
 - info: The string that displays some additional info.
 - infoNumberOfLines: The maximum number of lines to use for info.
 - isResponder: The value indicating whether this object is the first responder.
 - onSubmit: Adds an action to perform when the user submits a value to this view.
 - sliderValue: The slider’s current value.
 - minValue: The minimum value of the slider.
 - maxValue: The maximum value of the slider
 
 ## Example to create BigInformer
 # Code
 ```
 InputRangeTextField(
     .constant("Text"),
     placeholder: "Placeholder",
     name: "Optional label",
     state: .constant(.normal),
     info: .constant("Additional text"),
     sliderValue: 100,
     minValue: 100,
     maxValue: 1000)
```
 */
/// An object that displays an editable text area and slider.
@available(iOS 14.0, *)
public struct InputRangeTextField<T>: TextFieldInput, AccessabilitySupportUIKit, Identifiable where T: View {
    
    // MARK: - Public Properties
    
    /// Unique id.
    public let id = UUID()
    
    /// The text that the text field displays.
    @Binding public var content: String?
    
    /// The textfield state.
    @Binding public var state: TextInputState
    
    /// The string that displays some additional info.
    @Binding public var info: String
    
    // MARK: - Internal Properties
    
    @State var isTextFieldResponder: Bool = false
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    
    @State var sliderValue: Double = 0
    @State var minValue: Double = 0
    @State var maxValue: Double = 100
    
    // MARK: - Private Properties
    
    /// Leading text.
    private var leadingText: String?
    
    /// The semantic meaning for a text input area.
    private let contentType: UIKeyboardType
    
    /// The visible title of the Return key.
    private let returnKeyType: UIReturnKeyType
    
    /// The autocapitalization style for the text object.
    private let autocapitalizationType: UITextAutocapitalizationType
    
    /// The autocorrection style for the text object.
    private let autocorrectionType: UITextAutocorrectionType
    
    /// The string that displays when there is no other text in the text field.
    private let placeholder: String
    
    /// The text field’s name.
    private let name: String
    
    /// The maximum number of lines to use for info.
    private let infoNumberOfLines: Int?
    
    /// The value indicating whether this object is the first responder.
    private var isResponder: Binding<Bool>?
    
    /// Traling view.
    private let trailingView: () -> T
    
    /// Adds an action to perform when the user submits a value to this view.
    private let onSubmit: (() -> Void)?
    
    /// Text field formatter.
    private let formatter: Formatter?
    
    // MARK: - Private Properties

    @State private var finishAfterChangeSlider: Bool = false
    @ObservedObject private var schemeProvider: SchemeProvider<InputRangeTextFieldScheme>
    private var accessibilityIdentifier: String?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - value: The value that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - formatter: Text field formatter.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - sliderValue: The slider’s current value.
    ///   - minValue: The minimum value of the slider.
    ///   - maxValue: The maximum value of the slider.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        leadingText: String? = nil,
        infoNumberOfLines: Int? = nil,
        sliderValue: Double = 0,
        minValue: Double = 0,
        maxValue: Double = 100,
        isResponder: Binding<Bool>? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        schemeProvider: SchemeProvider<InputRangeTextFieldScheme> = AppThemeSchemeProvider<InputRangeTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        @ViewBuilder trailingView: @escaping () -> T
    ) {
        self._content = Binding(get: {
            if let value = value.wrappedValue {
                return String(describing: value)
            } else {
                return ""
            }
        }, set: { val in
            if let val = val as? V {
                value.wrappedValue = val
            }
        })
        self.formatter = formatter
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.leadingText = leadingText
        self.infoNumberOfLines = infoNumberOfLines
        self._sliderValue = .init(initialValue: sliderValue)
        self._maxValue = .init(initialValue: maxValue)
        self._minValue = .init(initialValue: minValue)
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isResponder = isResponder
        self.schemeProvider = schemeProvider
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self.trailingView = trailingView
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
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
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        leadingText: String? = nil,
        infoNumberOfLines: Int? = nil,
        sliderValue: Double = 0,
        minValue: Double = 0,
        maxValue: Double = 100,
        isResponder: Binding<Bool>? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        schemeProvider: SchemeProvider<InputRangeTextFieldScheme> = AppThemeSchemeProvider<InputRangeTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        @ViewBuilder trailingView: @escaping () -> T
    ) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
            placeholder: placeholder,
            name: name,
            state: state,
            info: info,
            leadingText: leadingText,
            infoNumberOfLines: infoNumberOfLines,
            sliderValue: sliderValue,
            minValue: minValue,
            maxValue: maxValue,
            isResponder: isResponder,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            schemeProvider: schemeProvider,
            onSubmit: onSubmit,
            trailingView: trailingView)
    }
    
    public var body: some View {
        let globalScheme = schemeProvider.scheme
        let style = globalScheme.textFieldScheme
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
                    informerFont: style.informerFont.swiftUIFont)
                textFieldView(
                    placeholderColor: placeholderColor,
                    tintColor: tintColor,
                    textColor: textColor,
                    trailingViewTintColor: style.underlineColor.swiftUIColor,
                    textFieldFont: style.textFieldFont,
                    isTextFieldDisabled: isTextFieldDisabled)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                SliderView(
                    value: $sliderValue,
                    minValue: minValue,
                    maxValue: maxValue,
                    schemeProvider: .constant(scheme: globalScheme.sliderScheme),
                    gestureChange: {
                        DispatchQueue.main.async {
                            self.finishAfterChangeSlider = true
                        }
                    })
                    .padding(.top, 5)
                    .onChange(of: sliderValue) { value in
                        DispatchQueue.main.async {
                            let text = String(format: "%.0f", value).replacingOccurrences(of: ",", with: ".")
                            content = text
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
    public func state(_ state: TextInputState) -> InputRangeTextField {
        var view = self
        view._state = $state
        return view
    }
    
    public func accessibility(identifierUIKit: String) -> Self {
        var view = self
        view.accessibilityIdentifier = identifierUIKit
        return view
    }
    
    // MARK: - Private Methods
    
    private func clear() {
        content = ""
    }
    
    private func placeholderView(
        placeholderColor: Color?,
        tintColor: Color?,
        nameColor: Color?,
        textFieldFont: SwiftUI.Font?,
        informerFont: SwiftUI.Font?) -> some View {
        HStack(spacing: 0.0) {
            ZStack {
                Text("\(placeholder)")
                    .offset(y: 20)
                    .foregroundColor(placeholderColor)
                    .font(textFieldFont)
                    .opacity(!isFilled ? 1 : 0)
                
                Text("\(name)")
                    .offset(x: 0.0)
                    .foregroundColor(isFocused ? tintColor : nameColor)
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
        isTextFieldDisabled: Bool) -> some View {
            HStack {
                ZStack {
                    if isTextFieldDisabled {
                        Text(content ?? "")
                            .foregroundColor(textColor.swiftUIColor)
                            .font(textFieldFont?.swiftUIFont)
                            .frame(height: 24.0)
                            .accessibilityIdentifier(accessibilityIdentifier ?? "")
                            .disabled(isTextFieldDisabled)
                            .onAppear {
                                self.isFocused = false
                                self.isTextFieldResponder = false
                            }
                    } else {
                        HStack(spacing: LayoutGrid.halfModule) {
                            UIKitTextField(
                                text: $content,
                                isResponder: isResponder == nil ? $isTextFieldResponder : isResponder,
                                formatter: formatter,
                                keyboard: contentType,
                                returnKeyType: returnKeyType,
                                autocapitalizationType: autocapitalizationType,
                                autocorrectionType: autocorrectionType,
                                textColor: textColor.uiColor,
                                placeholderColor: placeholderColor?.uiColor ?? .clear,
                                tintColor: tintColor.uiColor,
                                font: textFieldFont?.uiFont,
                                onSubmit: onSubmit,
                                accessibilityIdentifier: accessibilityIdentifier
                            )
                                .fixedSize()
                                .frame(height: 24.0)
                                .onChange(of: content) { value in
                                    guard !finishAfterChangeSlider else { return }

                                    if(content == "") {
                                        withAnimation(.easeInOut) {
                                            isFilled = false
                                        }
                                    } else {
                                        withAnimation(.easeInOut) {
                                            isFilled = true
                                        }
                                    }
                                    withAnimation(.easeInOut) {
                                        let text = (value ?? "").replacingOccurrences(of: ",", with: ".")
                                        guard let val = Double(text) else { return }

                                        self.sliderValue = val
                                    }
                                }
                                .onChange(of: isResponder?.wrappedValue ?? false, perform: { value in
                                    changeResponder(value: value)
                                })
                                .onChange(of: isTextFieldResponder) { value in
                                    changeResponder(value: value)
                                }
                            if let leadingText = leadingText {
                                if isFilled {
                                    Text(leadingText)
                                        .font(textFieldFont?.swiftUIFont)
                                        .foregroundColor(textColor.swiftUIColor)
                                }
                            }
                        }
                    }
            }
            Spacer(minLength: trailingView() is EmptyView ? 0.0 : LayoutGrid.module)
            if !(trailingView() is EmptyView) {
                trailingView()
                    .foregroundColor(trailingViewTintColor)
            }
        }
    }
    
    private func changeResponder(value: Bool) {
        withAnimation() {
            isFocused = value
        }
        
        if finishAfterChangeSlider {
            finishAfterChangeSlider = false
            return
        }
        
        if !value {
            self.sliderValue = max(min(sliderValue, maxValue), minValue)
            self.content = String(format: "%.0f", sliderValue).replacingOccurrences(of: ",", with: ".")
        }
    }
    
    private func minMaxView(
        placeholderColor: Color?,
        valueFont: SwiftUI.Font?) -> some View {
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
    
}

@available(iOS 14.0, *)
extension InputRangeTextField where T == EmptyView {
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - value: The value that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - formatter: Text field formatter.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - sliderValue: The slider’s current value.
    ///   - minValue: The minimum value of the slider.
    ///   - maxValue: The maximum value of the slider.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        leadingText: String? = nil,
        infoNumberOfLines: Int? = nil,
        sliderValue: Double = 0,
        minValue: Double = 0,
        maxValue: Double = 100,
        isResponder: Binding<Bool>? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        schemeProvider: SchemeProvider<InputRangeTextFieldScheme> = AppThemeSchemeProvider<InputRangeTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil
    ) {
        self._content = Binding(get: {
            if let value = value.wrappedValue {
                return String(describing: value)
            } else {
                return ""
            }
        }, set: { val in
            if let val = val as? V {
                value.wrappedValue = val
            }
        })
        self.formatter = formatter
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.leadingText = leadingText
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self._sliderValue = .init(initialValue: sliderValue)
        self._maxValue = .init(initialValue: maxValue)
        self._minValue = .init(initialValue: minValue)
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isResponder = isResponder
        self.accessibilityIdentifier = accessibilityIdentifier
        self.trailingView = { EmptyView() }
        self.schemeProvider = schemeProvider
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
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
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        leadingText: String? = nil,
        infoNumberOfLines: Int? = nil,
        sliderValue: Double = 0,
        minValue: Double = 0,
        maxValue: Double = 100,
        isResponder: Binding<Bool>? = nil,
        contentType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        schemeProvider: SchemeProvider<InputRangeTextFieldScheme> = AppThemeSchemeProvider<InputRangeTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil) {
            self.init(
                value: content,
                accessibilityIdentifier: accessibilityIdentifier,
                formatter: nil,
                placeholder: placeholder,
                name: name,
                state: state,
                info: info,
                leadingText: leadingText,
                infoNumberOfLines: infoNumberOfLines,
                sliderValue: sliderValue,
                minValue: minValue,
                maxValue: maxValue,
                isResponder: isResponder,
                contentType: contentType,
                returnKeyType: returnKeyType,
                autocapitalizationType: autocapitalizationType,
                autocorrectionType: autocorrectionType,
                schemeProvider: schemeProvider,
                onSubmit: onSubmit)
    }
    
}

@available(iOS 14.0, *)
struct InputRangeTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputRangeTextField(
            .constant("Text"),
            placeholder: "Placeholder",
            name: "Optional label",
            state: .constant(.normal),
            info: .constant("Additional text"),
            sliderValue: 100,
            minValue: 100,
            maxValue: 1000)
    }
}


