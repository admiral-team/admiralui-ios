//
//  OTPTextField.swift
//  AdmiralSwiftUI
//
//  Created on 25.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 OTPTextField - An object that displays an editable text area for enter sms code.

 You can create a OTPTextField with the zero frame rectangle by specifying the following parameters in init:

 - value: The value that the text field displays.
 - content:  The text that the text field displays.
 - accessibilityIdentifier: The id used by accessibility method.
 - formatter: Text field formatter.
 - contentType: The semantic meaning for a text input area.
 - returnKeyType: The visible title of the Return key.
 - autocapitalizationType: The autocapitalization style for the text object.
 - autocorrectionType: The autocorrection style for the text object.
 - placeholder: The string that displays when there is no other text in the text field.
 - state: The textfield state.
 - info: The string that displays some additional info. If nil, no line limit applies.
 - infoNumberOfLines: The maximum number of lines to use for info.
 
 Also OTPTextField has public func to sets the state text field:
 
 - parameter state: The state that the text field displays.
 - returns: Input range text field.
 
 # Code
 ```
 public func state(_ state: TextInputState) -> OTPTextField
 ```
 ## Example to create OTPTextField
 # Code
 ```
 OTPTextField(
            .constant("Text"),
            placeholder: "Placeholder",
            state: .constant(.normal))

```
 */
/// An object that displays an editable text area for enter sms code.
@available(iOS 14.0, *)
public struct OTPTextField: TextFieldInput, AccessabilitySupportUIKit, Identifiable {
    
    // MARK: - Public Properties
    
    /// Unique id.
    public let id = UUID()
    
    /// The textfield state.
    @Binding public var state: TextInputState
    
    /// The string that displays some additional info.
    @Binding public var info: String
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    @State var isTextFieldResponder: Bool = false
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    var isResponder: Binding<Bool>?
    
    // MARK: - Private Properties
    
    /// The text that the text field displays.
    @Binding private var content: String?
    
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
    
    /// The maximum number of lines to use for info. If nil, no line limit applies.
    private let infoNumberOfLines: Int?
    
    /// Text field formatter.
    private let formatter: Formatter?
    
    /// Adds an action to perform when the user submits a value to this view.
    private let onSubmit: (() -> Void)?
    
    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private let onCursorPosition: ((Int, Int, String) -> (Int))?
    
    /// Constants that identify the semantic meaning for a text-entry area.
    private let textContentType: UITextContentType?
    
    // Flag is disable pasting. If flasg is true pasting is enabled.
    private let canPerformActionPaste: Bool
    
    @State private var scheme: OTPTextFieldScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<OTPTextFieldScheme>
    private var accessibilityIdentifier: String?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - value: The value that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - formatter: Text field formatter.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = .oneTimeCode,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        isResponder: Binding<Bool>? = nil,
        infoNumberOfLines: Int? = nil,
        schemeProvider: SchemeProvider<OTPTextFieldScheme> = AppThemeSchemeProvider<OTPTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil
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
        self.contentType = contentType
        self.placeholder = placeholder
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.onCursorPosition = onCursorPosition
        self.infoNumberOfLines = infoNumberOfLines
        self.isResponder = isResponder
        self.returnKeyType = returnKeyType
        self.canPerformActionPaste = canPerformActionPaste
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textContentType = textContentType
        self.schemeProvider = schemeProvider
        self.accessibilityIdentifier = accessibilityIdentifier
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - formatter: Text field formatter.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = .oneTimeCode,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        isResponder: Binding<Bool>? = nil,
        infoNumberOfLines: Int? = nil,
        schemeProvider: SchemeProvider<OTPTextFieldScheme> = AppThemeSchemeProvider<OTPTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: formatter,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            textContentType: textContentType,
            canPerformActionPaste: canPerformActionPaste,
            placeholder: placeholder,
            state: state,
            info: info,
            isResponder: isResponder,
            infoNumberOfLines: infoNumberOfLines,
            schemeProvider: schemeProvider,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition)
    }
    
    public var body: some View {
        let isTextFieldDisabled = !isEnabled || (state == .disabled || state == .readOnly)
        
        let scheme = self.scheme ?? schemeProvider.scheme
        let placeholderColor = scheme.placeholderColor
        var underlineColor = scheme.underlineColor.swiftUIColor
        var textColor = scheme.textColor
        var tintColor = scheme.tintColor.swiftUIColor
        var infoColor = scheme.underlineColor.swiftUIColor
        
        switch state {
        case .error:
            infoColor = scheme.errorColor.swiftUIColor
            underlineColor = scheme.errorColor.swiftUIColor
            textColor = scheme.textColor
            tintColor = scheme.errorColor.swiftUIColor
        case .disabled:
            infoColor = scheme.disabledColor.swiftUIColor
            underlineColor = scheme.disabledColor.swiftUIColor
            textColor = scheme.disabledColor
            tintColor = scheme.disabledColor.swiftUIColor
        case .readOnly:
            textColor = scheme.textColor
            tintColor = scheme.disabledColor.swiftUIColor
        default:
            break
        }
        
        return ZStack {
            VStack(spacing: 0) {
                textFieldView(
                    placeholderColor: placeholderColor,
                    tintColor: scheme.tintColor,
                    textColor: textColor,
                    textFieldFont: scheme.textFieldFont,
                    isTextFieldDisabled: isTextFieldDisabled)
                    .padding(.top, LayoutGrid.halfModule * 3)
                Line(mode: state != .readOnly ? .solid : .dashed(lineWidth: 1.0, dash: 5.0))
                    .padding(.top, 5)
                    .foregroundColor(isFocused ? tintColor : underlineColor)
                if !info.isEmpty {
                    Text(info)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .lineLimit(infoNumberOfLines)
                        .foregroundColor(infoColor)
                        .font(scheme.informerFont.swiftUIFont)
                        .padding(.top, LayoutGrid.module)
                        .padding(.bottom, LayoutGrid.module)
                        .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.info.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Sets the state text field.
    /// - Parameter state: The state that the text field displays.
    /// - Returns: OTP text field.
    public func state(_ state: TextInputState) -> OTPTextField {
        var view = self
        view._state = $state
        return view
    }
    
    public func accessibility(identifierUIKit: String) -> Self {
        var view = self
        view.accessibilityIdentifier = identifierUIKit
        return view
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: OTPTextFieldScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func clear() {
        content = ""
    }
    
    private func textFieldView(
        placeholderColor: AColor,
        tintColor: AColor,
        textColor: AColor,
        textFieldFont: AFont?,
        isTextFieldDisabled: Bool) -> some View {
        
        HStack {
            ZStack {
                if isTextFieldDisabled {
                    Text((content ?? "").isEmpty ? placeholder : (content ?? ""))
                        .foregroundColor(textColor.swiftUIColor)
                        .font(textFieldFont?.swiftUIFont)
                        .accentColor(textColor.swiftUIColor)
                        .frame(height: LayoutGrid.halfModule * 6)
                        .offset(y: -LayoutGrid.halfModule)
                        .multilineTextAlignment(.center)
                        .onAppear {
                            self.isFocused = false
                            self.isTextFieldResponder = false
                        }
                        .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.placeholder.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                } else {
                    UIKitTextField(
                        text: $content,
                        isResponder: isResponder == nil ? $isTextFieldResponder : isResponder,
                        placeholder: placeholder,
                        formatter: formatter,
                        keyboard: .numberPad,
                        returnKeyType: .default,
                        textContentType: textContentType,
                        canPerformActionPaste: canPerformActionPaste,
                        textColor: textColor.uiColor,
                        placeholderColor: placeholderColor.uiColor,
                        tintColor: tintColor.uiColor,
                        textAlignment: .center,
                        font: textFieldFont?.uiFont,
                        onSubmit: onSubmit,
                        onCursorPosition: onCursorPosition,
                        accessibilityIdentifier: accessibilityIdentifier
                    )
                    .offset(y: -LayoutGrid.halfModule)
                    .frame(height: LayoutGrid.halfModule * 6)
                    .onChange(of: isResponder?.wrappedValue ?? false, perform: { value in
                        withAnimation() {
                            isFocused = value
                        }
                    })
                    .onChange(of: isTextFieldResponder) { value in
                        withAnimation() {
                            isFocused = value
                        }
                    }
                    .onChange(of: content) { value in

                        if(content == "") {
                            isFilled = false
                        } else {
                            isFilled = true
                        }
                    }
                }
            }
        }
    }
    
}

@available(iOS 14.0, *)
struct OTPTextField_Previews: PreviewProvider {

    @State static var text: String? = ""

    static var previews: some View {
        OTPTextField($text, placeholder: "Placeholder", state: .constant(.normal))
    }
}

