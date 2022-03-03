//
//  StandardTextField.swift
//  AdmiralSwiftUI
//
//  Created on 14.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/**
 TextInputState - Public enum for TextFieldInput. The state of tex input.
 
 TextInputState can be one of the following values:
 - normal - The normal state of the field in which the user can edit textfield.
 - error - The error state is useful to show the user an error.
 - disabled - The disabled state disable user input and hide input text.
 - readOnly - The read only state disable user to modify textfield.
 
 The default value for normal state:
 - var `default`: TextInputState - default is normal
 */
/// The state of tex input
public enum TextInputState: Int {
    /// The normal state of the field in which the user can edit textfield
    case normal
    /// The error state is useful to show the user an error
    case error
    /// The disabled state disable user input and hide input text
    case disabled
    /// The read only state disable user to modify textfield
    case readOnly

    /// The default value is normal state
    static var `default`: TextInputState {
        return .normal
    }
}

@available(iOS 14.0, *)
public protocol TextFieldInput: View {
    var state: TextInputState { get set }
    var info: String { get set }
    
    func state(_ state: TextInputState) -> Self
}

/**
 StandardTextField - An object that displays an editable text area for enter sms code.

 You can create a StandardTextField with the zero frame rectangle by specifying the following parameters in init:

 - value: The value that the text field displays.
 - content: The text that the text field displays.
 - accessibilityIdentifier: The id used by accessibility method.
 - formatter: Text field formatter.
 - contentType: The semantic meaning for a text input area.
 - returnKeyType: The visible title of the Return key.
 - autocapitalizationType: The autocapitalization style for the text object.
 - autocorrectionType: The autocorrection style for the text object.
 - placeholder: The string that displays when there is no other text in the text field.
 - name: The text field’s name.
 - icon: The text field’s traling image view.
 - state: The textfield state.
 - info: The string that displays some additional info. If nil, no line limit applies.
 - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
 - trailingView: Tap traling view.
 - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
 
 Also StandardTextField has public func to sets the state text field:
 
 - parameter state: The state that the text field displays.
 - returns: Input range text field.
 
 # Code
 ```
 public func state(_ state: TextInputState) -> StandardTextField
 ```
 ## Example to create StandardTextField
 # Code
 ```
 StandardTextField(
     .constant("Text"),
     placeholder: "Placeholder",
     name: "Optional Label",
     state: .constant(.normal),
     info: .constant("Info"))
```
 */
@available(iOS 14.0, *)
public struct StandardTextField<T>: TextFieldInput, AccessabilitySupportUIKit, Identifiable where T: View {

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

    /// The text field’s name.
    private let name: String

    /// Traling view.
    private let trailingView: () -> T

    /// Adds an action to perform when the user submits a value to this view.
    private let onSubmit: (() -> Void)?

    /// The maximum number of lines to use for info. If nil, no line limit applies.
    private let infoNumberOfLines: Int?

    /// The value indicating whether this object is the first responder.
    private var isResponder: Binding<Bool>?

    /// Text field formatter.
    private var formatter: Formatter?
    
    /// Constants that identify the semantic meaning for a text-entry area.
    private var textContentType: UITextContentType? = nil
    
    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private let onCursorPosition: ((Int, Int, String) -> (Int))?

    @State private var segmentSize: CGSize = .zero
    @State private var scheme: StandardTextFieldScheme? = nil
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<StandardTextFieldScheme>()

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
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T) {
        self.accessibilityIdentifier = accessibilityIdentifier
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
        self.contentType = contentType
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self.trailingView = trailingView
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textContentType = textContentType
        self.isResponder = isResponder
        self.formatter = formatter
        self.onCursorPosition = onCursorPosition
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
    }
    
    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content: The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
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
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            textContentType: textContentType,
            placeholder: placeholder,
            name: name,
            state: state,
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
        let placeholderColor = scheme.placeholderColor.parameter(for: state == .disabled ? .disabled : .normal)
        var underlineColor = scheme.underlineColor.swiftUIColor
        var textColor = scheme.textColor
        var tintColor = scheme.tintColor
        var infoColor = scheme.placeholderColor.parameter(for: .normal)?.swiftUIColor  ?? .clear
        let curcorColor = scheme.tintColor

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
            tintColor = scheme.disabledColor
        default:
            break
        }

        return TextInputDecorationBox<AnyView>(
            textFieldView: {
                textFieldView(
                    placeholderColor: placeholderColor,
                    tintColor: curcorColor,
                    textColor: textColor,
                    trailingViewTintColor: scheme.underlineColor.swiftUIColor,
                    textFieldFont: scheme.textFieldFont,
                    nameFont: scheme.nameFont,
                    isTextFieldDisabled: isTextFieldDisabled)
            },
            name: name,
            placeholder: placeholder,
            info: $info,
            infoNumberOfLines: infoNumberOfLines,
            placeholderColor: placeholderColor?.swiftUIColor,
            infoColor: infoColor,
            tintColor: tintColor.swiftUIColor,
            underlineColor: underlineColor,
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

    // MARK: - Internal Methods

    func scheme(_ scheme: StandardTextFieldScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }

    // MARK: - Private Methods

    private func clear() {
        content = ""
    }

    private func textFieldView(
        placeholderColor: AColor?,
        tintColor: AColor,
        textColor: AColor,
        trailingViewTintColor: Color,
        textFieldFont: AFont,
        nameFont: AFont?,
        isTextFieldDisabled: Bool) -> AnyView {

        return HStack {
            ZStack {
                if isTextFieldDisabled {
                    Text(content ?? "")
                        .foregroundColor(textColor.swiftUIColor)
                        .font(textFieldFont.swiftUIFont)
                        .frame(height: LayoutGrid.tripleModule)
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
                        formatter: formatter,
                        keyboard: contentType,
                        returnKeyType: returnKeyType,
                        autocapitalizationType: autocapitalizationType,
                        autocorrectionType: autocorrectionType,
                        textContentType: textContentType,
                        textColor: textColor.uiColor,
                        placeholderColor: placeholderColor?.uiColor ?? .clear,
                        tintColor: tintColor.uiColor,
                        font: textFieldFont.uiFont,
                        onSubmit: onSubmit,
                        onCursorPosition: onCursorPosition,
                        accessibilityIdentifier: accessibilityIdentifier
                    )
                        .accessibilityElement(children: .contain)
                        .frame(height: LayoutGrid.tripleModule)
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
            Spacer(minLength: trailingView() is EmptyView ? 0.0 : LayoutGrid.module)
            if !(trailingView() is EmptyView) {
                trailingView()
                    .foregroundColor(trailingViewTintColor)
                    .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.trailingView.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
            }
        }
        .eraseToAnyView()
    }

}

@available(iOS 14.0, *)
extension StandardTextField where T == EmptyView {
    
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
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
        self.accessibilityIdentifier = accessibilityIdentifier
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

        self.contentType = contentType
        self.placeholder = placeholder
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self.trailingView = { EmptyView() }
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.textContentType = textContentType
        self.isResponder = isResponder
        self.formatter = formatter
        self.onCursorPosition = onCursorPosition
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
    }

    /// Initializes and returns a newly allocated view object
    /// - Parameters:
    ///   - content: The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info. If nil, no line limit applies.
    ///   - infoNumberOfLines: he maximum number of lines to use for info. If nil, no line limit applies.
    ///   - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        textContentType: UITextContentType? = nil,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
            self.init(value: content,
                      accessibilityIdentifier: accessibilityIdentifier,
                      formatter: nil,
                      contentType: contentType,
                      returnKeyType:returnKeyType,
                      autocapitalizationType: autocapitalizationType,
                      autocorrectionType: autocorrectionType,
                      textContentType: textContentType,
                      placeholder: placeholder,
                      name: name,
                      state: state,
                      info: info,
                      infoNumberOfLines: infoNumberOfLines,
                      isResponder: isResponder,
                      onSubmit: onSubmit,
                      onCursorPosition: onCursorPosition)
    }

}
