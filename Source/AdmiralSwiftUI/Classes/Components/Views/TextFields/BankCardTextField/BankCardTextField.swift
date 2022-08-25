//
//  BankCardTextField.swift
//  AdmiralSwiftUI
//
//  Created on 25.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 BankCardTextField - An object that displays an editable text area for enter sms code.

 You can create a BankCardTextField with the zero frame rectangle by specifying the following parameters in init:

 - value: The value that the text field displays.
 - content:  The text that the text field displays.
 - accessibilityIdentifier: The id used by accessibility method.
 - formatter: Text field formatter.
 - contentType: The semantic meaning for a text input area.
 - returnKeyType: The visible title of the Return key.
 - autocapitalizationType: The autocapitalization style for the text object.
 - autocorrectionType: The autocorrection style for the text object.
 - placeholder: The string that displays when there is no other text in the text field.
 - icon:  The text field’s traling image view.
 - state: The textfield state.
 - info: The string that displays some additional info.
 - infoNumberOfLines: The maximum number of lines to use for info.
 - trailingView: Tap traling view. Object of protocol TextFieldInput, AccessabilitySupportUIKit, Identifiable
 
 Also BankCardTextField has public func to sets the state text field:
 
 - parameter state: The state that the text field displays.
 - returns: Input range text field.
 
 # Code
 ```
 public func state(_ state: TextInputState) -> BankCardTextField
 ```
 ## Example to create BankCardTextField
 # Code
 ```
 BankCardTextField(
     value: .constant("Text"),
     state: .normal,
     contentType: .numberPad,
     placeholder: "1111 2222 3333 4444",
     info: .constant("Info"))
```
 
 ## Example to create BankCardTextField with BlocFormatter
 # Code
 ```
 BankCardTextField(
     value: .constant("Text"),
     formatter: BlocFormatter(format: { value in
         return "text" + value
     })
```
 */
/// An object that displays an editable text area for enter sms code.
@available(iOS 14.0, *)
public struct BankCardTextField<T>: TextFieldInput, AccessabilitySupportUIKit, Identifiable where T: View {
    
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
    
    /// The value indicating whether this object is the first responder.
    private var isResponder: Binding<Bool>?
    
    /// Traling view.
    private let trailingView: () -> T
    
    /// Adds an action to perform when the user submits a value to this view.
    private let onSubmit: (() -> Void)?
    
    /// Text field formatter.
    private let formatter: Formatter?
    
    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private let onCursorPosition: ((Int, Int, String) -> (Int))?
    
    // Flag is disable pasting. If flasg is true pasting is enabled.
    private let canPerformActionPaste: Bool
    
    @State private var scheme: BankCardTextFieldScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<BankCardTextFieldScheme>()
    
    private let textFieldHeight: CGFloat = LayoutGrid.tripleModule
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
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - isResponder: The value indicating whether this object is the first responder.
    ///   - onSubmit: Adds an action to perform when the user submits a value to this view.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    ///   - trailingView: Tap traling view.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        state: Binding<TextInputState> = .constant(.normal),
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T) {
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
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self.trailingView = trailingView
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - isResponder: The value indicating whether this object is the first responder.
    ///   - onSubmit: Adds an action to perform when the user submits a value to this view.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    ///   - trailingView: Tap traling view.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        state: Binding<TextInputState> = .constant(.normal),
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T) {
            self.init(
                value: content,
                accessibilityIdentifier: accessibilityIdentifier,
                formatter: nil,
                state: state,
                contentType: contentType,
                returnKeyType: returnKeyType,
                autocapitalizationType: autocapitalizationType,
                autocorrectionType: autocorrectionType,
                canPerformActionPaste: canPerformActionPaste,
                placeholder: placeholder,
                info: info,
                infoNumberOfLines: infoNumberOfLines,
                isResponder: isResponder,
                onSubmit: onSubmit,
                onCursorPosition: onCursorPosition,
                trailingView: trailingView)
    }
    
    public var body: some View {
        let isTextFieldDisabled = !isEnabled || (state == .disabled || state == .readOnly)
        
        let scheme = self.scheme ?? schemeProvider.scheme
        let placeholderColor = scheme.placeholderColor
        var underlineColor = scheme.underlineColor.swiftUIColor
        var textColor = scheme.textColor
        var tintColor = scheme.tintColor
        var infoColor = scheme.underlineColor.swiftUIColor
        
        switch state {
        case .error:
            infoColor = scheme.errorColor.swiftUIColor
            underlineColor = scheme.errorColor.swiftUIColor
            textColor = scheme.textColor
            tintColor = scheme.errorColor
        case .disabled:
            infoColor = scheme.disabledColor.swiftUIColor
            underlineColor = scheme.disabledColor.swiftUIColor
            textColor = scheme.disabledColor
            tintColor = scheme.disabledColor
        case .readOnly:
            textColor = scheme.textColor
            tintColor = scheme.disabledColor
        default:
            break
        }
        
        return ZStack {
            VStack(spacing: 0) {
                textFieldView(
                    placeholderColor: placeholderColor,
                    tintColor: scheme.tintColor,
                    textColor: textColor,
                    trailingViewTintColor: scheme.underlineColor.swiftUIColor,
                    textFieldFont: scheme.textFieldFont,
                    isTextFieldDisabled: isTextFieldDisabled)
                    .padding(.top, LayoutGrid.halfModule * 3)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                Line(mode: state != .readOnly ? .solid : .dashed(lineWidth: 1.0, dash: 5.0))
                    .padding(.top, 5)
                    .foregroundColor(isFocused ? tintColor.swiftUIColor : underlineColor)
                if !info.isEmpty {
                    Text(info)
                        .frame(maxWidth: .infinity, alignment: .center)
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
    /// - Returns: Bank card text field.
    public func state(_ state: TextInputState) -> BankCardTextField {
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
    
    func scheme(_ scheme: BankCardTextFieldScheme) -> some View {
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
        trailingViewTintColor: Color,
        textFieldFont: AFont?,
        isTextFieldDisabled: Bool) -> some View {
        HStack {
            ZStack {
                if isTextFieldDisabled {
                    Text(content ?? "")
                        .foregroundColor(textColor.swiftUIColor)
                        .font(textFieldFont?.swiftUIFont)
                        .disabled(isTextFieldDisabled)
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
                        keyboard: contentType,
                        returnKeyType: returnKeyType,
                        autocapitalizationType: autocapitalizationType,
                        autocorrectionType: autocorrectionType,
                        canPerformActionPaste: canPerformActionPaste,
                        textColor: textColor.uiColor,
                        placeholderColor: placeholderColor.uiColor,
                        tintColor: tintColor.uiColor,
                        font: textFieldFont?.uiFont,
                        onSubmit: onSubmit,
                        onCursorPosition: onCursorPosition,
                        accessibilityIdentifier: accessibilityIdentifier
                    )
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
                }
            }
            Spacer(minLength: trailingView() is EmptyView ? 0.0 : LayoutGrid.module)
            if !(trailingView() is EmptyView) {
                trailingView()
                    .foregroundColor(trailingViewTintColor)
                    .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.trailingView.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
            }
        }
        .frame(height: 24.0)
    }
    
}

@available(iOS 14.0, *)
extension BankCardTextField where T == EmptyView {
    
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
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - isResponder: The value indicating whether this object is the first responder.
    ///   - onSubmit: Adds an action to perform when the user submits a value to this view.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        state: Binding<TextInputState> = .constant(.normal),
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
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
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self.trailingView = { EmptyView() }
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - icon:  The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: The maximum number of lines to use for info.
    ///   - isResponder: The value indicating whether this object is the first responder.
    ///   - onSubmit: Adds an action to perform when the user submits a value to this view.
    ///   - onCursorPosition: Adds an action to perform change cursor position.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        state: Binding<TextInputState> = .constant(.normal),
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
            state: state,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            canPerformActionPaste: canPerformActionPaste,
            placeholder: placeholder,
            info: info,
            infoNumberOfLines: infoNumberOfLines,
            isResponder: isResponder,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition)
    }
    
}
