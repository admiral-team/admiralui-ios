//
//  SecureTextField.swift
//  AdmiralSwiftUI
//
//  Created on 11.06.2021.
//

import AdmiralTheme
import SwiftUI

/**
 SecurityTextField - A control into which the user securely enters private text.

 You can create a SecurityTextField with the zero frame rectangle by specifying the following parameters in init:

 - value: The value that the text field displays.
 - content: The text that the text field displays.
 - accessibilityIdentifier: The id used by accessibility method.
 - formatter: Text field formatter.
 - isSecure: The secure state.
 - contentType: The semantic meaning for a text input area.
 - returnKeyType: The visible title of the Return key.
 - autocapitalizationType: The autocapitalization style for the text object.
 - autocorrectionType: The autocorrection style for the text object.
 - placeholder: The string that displays when there is no other text in the text field.
 - name: The text field’s name.
 - iconOn: The text field’s traling image view with state "on".
 - iconOff: The text field’s traling image view with state "off".
 - state: The textfield state.
 - info: The string that displays some additional info.
 - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
 - trailingView: Tap traling view.
 - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
 
 ## Example to create SecurityTextField
 # Code
 ```
 SecurityTextField(
     .constant("Text"),
     accessibilityIdentifier: "123",
     contentType: .default,
     placeholder: "Placeholder",
     name: "Optional Label",
     state: .constant(.normal),
     info: .constant("Additional text"))
```
 
 Also SecurityTextField has public func to sets the state text field:
 
 - parameter state: The state that the text field displays.
 - returns: Input range text field.
 
 # Code
 ```
 public func state(_ state: TextInputState) -> SecurityTextField
 ```
 */
/// A control into which the user securely enters private text.
@available(iOS 14.0, *)
public struct SecurityTextField<T>: TextFieldInput, AccessabilitySupportUIKit, Identifiable where T: View {
    
    // MARK: - Public Properties
    
    /// Unique id.
    public let id = UUID()
    
    /// The textfield state.
    @Binding public var state: TextInputState
    
    /// The string that displays some additional info.
    @Binding public var info: String
    
    // MARK: - Internal Properties
    
    @State var isTextFieldResponder: Bool = false
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    @State var isSetTrailingView = false
    @State var trailingAction: (() -> ())?
    
    @Environment(\.isEnabled) var isEnabled
    
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
    
    /// The text field’s name.
    private let name: String
    
    /// The maximum number of lines to use for info. If nil, no line limit applies.
    private let infoNumberOfLines: Int?
    
    /// The secure state.
    @State private var isSecure: Bool = false
    
    /// The value indicating whether this object is the first responder.
    private var isResponder: Binding<Bool>?
    
    /// Traling view.
    private var trailingView: () -> T
    
    /// Adds an action to perform when the user submits a value to this view.
    private var onSubmit: (() -> Void)?
    
    /// Text field formatter.
    private var formatter: Formatter?
    
    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private let onCursorPosition: ((Int, Int, String) -> (Int))?
    
    // Flag is disable pasting. If flasg is true pasting is enabled.
    private let canPerformActionPaste: Bool
    
    // MARK: - Private Properties
    
    @State private var segmentSize: CGSize = .zero
    
    @ObservedObject private var schemeProvider: SchemeProvider<StandardTextFieldScheme>
    
    private let eyeOff = SymbolAssets.Service.Outline.eyeClose.swiftUIImage
    private let eyeOn = SymbolAssets.Service.Outline.eye.swiftUIImage
    private var accessibilityIdentifier: String?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - value: The value that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - formatter: Text field formatter.
    ///   - isSecure: The secure state.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - iconOn: The text field’s traling image view with state "on".
    ///   - iconOff: The text field’s traling image view with state "off".
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        isSecure: Bool = false,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        schemeProvider: SchemeProvider<StandardTextFieldScheme> = AppThemeSchemeProvider<StandardTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
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
        self._isSecure = .init(initialValue: isSecure) 
        self.contentType = contentType
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.trailingView = trailingView
        self.infoNumberOfLines = infoNumberOfLines
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self.onCursorPosition = onCursorPosition
        self.schemeProvider = schemeProvider
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isSetTrailingView = .init(initialValue: true)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content: The text that the text field displays.
    ///   - accessibilityIdentifier: A string that identifies the element.
    ///   - isSecure: The secure state.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - iconOn: The text field’s traling image view with state "on".
    ///   - iconOff: The text field’s traling image view with state "off".
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        isSecure: Bool = false,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        schemeProvider: SchemeProvider<StandardTextFieldScheme> = AppThemeSchemeProvider<StandardTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
            isSecure: isSecure,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            canPerformActionPaste: canPerformActionPaste,
            placeholder: placeholder,
            name: name,
            state: state,
            info: info,
            infoNumberOfLines: infoNumberOfLines,
            isResponder: isResponder,
            schemeProvider: schemeProvider,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition,
            trailingView: trailingView)
    }
    
    public var body: some View {
        let isTextFieldDisabled = !isEnabled || (state == .disabled || state == .readOnly)
        
        let scheme = schemeProvider.scheme
        let placeholderColor = scheme.placeholderColor.parameter(for: state == .disabled ? .disabled : .normal)
        var underlineColor = scheme.underlineColor
        var textColor = scheme.textColor
        var tintColor = scheme.tintColor
        var infoColor = scheme.placeholderColor.parameter(for: .normal)
        let curcorColor = scheme.tintColor
        var trailingViewTintColor = scheme.underlineColor
        
        switch state {
        case .error:
            infoColor = scheme.errorColor
            underlineColor = scheme.errorColor
            textColor = scheme.textColor
            tintColor = scheme.errorColor
            trailingViewTintColor = scheme.underlineColor
        case .disabled:
            infoColor = scheme.disabledColor
            underlineColor = scheme.disabledColor
            textColor = scheme.disabledColor
            tintColor = scheme.disabledColor
            trailingViewTintColor = scheme.disabledColor
        case .readOnly:
            tintColor = scheme.disabledColor
        default:
            break
        }
        
        return TextInputDecorationBox<AnyView, AnyView>(
            textFieldView: {
                textFieldView(
                    tintColor: curcorColor,
                    textColor: textColor,
                    placeholderColor: placeholderColor?.uiColor ?? .clear,
                    trailingViewTintColor: trailingViewTintColor.swiftUIColor,
                    textFieldFont: scheme.textFieldFont,
                    isTextFieldDisabled: isTextFieldDisabled)
            },
            name: name,
            placeholder: placeholder,
            info: $info,
            infoNumberOfLines: infoNumberOfLines,
            placeholderColor: placeholderColor?.swiftUIColor,
            infoColor: infoColor?.swiftUIColor,
            tintColor: tintColor.swiftUIColor,
            underlineColor: underlineColor.swiftUIColor,
            textFieldFont: scheme.textFieldFont,
            nameFont: scheme.nameFont,
            informerFont: scheme.informerFont.swiftUIFont,
            segmentSize: $segmentSize,
            separatorLineMode: state != .readOnly ? .solid : .dashed(lineWidth: 1.0, dash: 5.0),
            isFocused: $isFocused,
            isFilled: $isFilled,
            isTextFieldDisabled: isTextFieldDisabled)
    }
    
    // MARK: - Public Methods
    
    /// Sets the state text field.
    /// - Parameter state: The state that the text field displays.
    /// - Returns: Security text field.
    public func state(_ state: TextInputState) -> Self {
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
    
    private func changeSecure() {
        self.isSecure.toggle()
    }
    
    private func textFieldView(
        tintColor: AColor?,
        textColor: AColor?,
        placeholderColor: UIColor,
        trailingViewTintColor: Color,
        textFieldFont: AFont?,
        isTextFieldDisabled: Bool) -> AnyView {
        HStack {
            ZStack {
                if segmentSize != .zero {
                    UIKitTextField(
                        text: $content,
                        isResponder: isResponder == nil ? $isTextFieldResponder : isResponder,
                        isSecured: isSecure,
                        formatter: formatter,
                        keyboard: contentType,
                        returnKeyType: returnKeyType,
                        autocapitalizationType: autocapitalizationType,
                        autocorrectionType: autocorrectionType,
                        canPerformActionPaste: canPerformActionPaste,
                        textColor: textColor?.uiColor ?? .clear,
                        placeholderColor: placeholderColor,
                        tintColor: tintColor?.uiColor ?? .clear,
                        font: textFieldFont?.uiFont,
                        onSubmit: onSubmit,
                        onCursorPosition: onCursorPosition,
                        accessibilityIdentifier: accessibilityIdentifier
                    )
                        .frame(height: LayoutGrid.tripleModule)
                        .disabled(isTextFieldDisabled)
                        .onChange(of: isTextFieldDisabled, perform: { value in
                            if value {
                                self.isFocused = false
                                self.isTextFieldResponder = false
                            }
                        })
                        .onChange(of: content) { value in
                            if(content == "") {
                                withAnimation(.spring()) {
                                    isFilled = false
                                }
                            } else {
                                withAnimation(.spring()) {
                                    isFilled = true
                                }
                            }
                        }
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
            .disabled(isTextFieldDisabled)
            
            Spacer(minLength: LayoutGrid.module)
            if isSetTrailingView {
                trailingView()
                    .foregroundColor(trailingViewTintColor)
                    .disabled(state == .disabled)
                    .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.trailingView.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
            } else {
                Button(action: changeSecure, label: {
                    (isSecure ? eyeOn : eyeOff)
                        .frame(width: LayoutGrid.tripleModule, height: LayoutGrid.tripleModule)
                        .foregroundColor(trailingViewTintColor)
                        .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.trailingView.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                })
                .disabled(state == .disabled)
            }
        }
        .eraseToAnyView()
    }
    
}


@available(iOS 14.0, *)
extension SecurityTextField where T == EmptyView {
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - value: The value that the text field displays.
    ///   - accessibilityIdentifier: A string that identifies the element.
    ///   - formatter: Text field formatter.
    ///   - isSecure: The secure state.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - iconOn: The text field’s traling image view with state "on".
    ///   - iconOff: The text field’s traling image view with state "off".
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        isSecure: Bool = false,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        schemeProvider: SchemeProvider<StandardTextFieldScheme> = AppThemeSchemeProvider<StandardTextFieldScheme>(),
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
        self._isSecure = .init(initialValue: isSecure)
        self.contentType = contentType
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.trailingView = { EmptyView() }
        self.infoNumberOfLines = infoNumberOfLines
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self.onCursorPosition = onCursorPosition
        self.schemeProvider = schemeProvider
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self._isSetTrailingView = .init(initialValue: false)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content: The text that the text field displays.
    ///   - accessibilityIdentifier: A string that identifies the element.
    ///   - isSecure: The secure state.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - iconOn: The text field’s traling image view with state "on".
    ///   - iconOff: The text field’s traling image view with state "off".
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        isSecure: Bool = false,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = true,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        schemeProvider: SchemeProvider<StandardTextFieldScheme> = AppThemeSchemeProvider<StandardTextFieldScheme>(),
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
            isSecure: isSecure,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            canPerformActionPaste: canPerformActionPaste,
            placeholder: placeholder,
            name: name,
            state: state,
            info: info,
            infoNumberOfLines: infoNumberOfLines,
            isResponder: isResponder,
            schemeProvider: schemeProvider,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition)
    }
    
}

@available(iOS 14.0, *)
struct SecureTextField_Previews: PreviewProvider {

    @State static var text: String? = "SecureTextField_Previews"

    static var previews: some View {
        SecurityTextField(
            $text,
            accessibilityIdentifier: "123",
            contentType: .default,
            placeholder: "Placeholder",
            name: "Optional Label",
            state: .constant(.normal),
            info: .constant("Additional text"))
    }
    
}

