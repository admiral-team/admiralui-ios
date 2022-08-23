//
//  TextView.swift
//  AdmiralSwiftUI
//
//  Created on 11.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 TextView - An object that displays an editable text area and slider.

 You can create a TextView with the zero frame rectangle by specifying the following parameters in init:

 - value: The value that the text field displays.
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
 - info: The string that displays some additional info.
 - infoNumberOfLines: infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
 - trailingView: Tap traling view.
 - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
 
 ## Example to create TextView
 # Code
 ```
 TextView(
     .constant("Text"),
     contentType: .default,
     placeholder: "Placeholder",
     name: "Optional label",
     state: $state,
     info: .constant("Additional text"),
     infoNumberOfLines: 3)
```
 */
/// A Multiline text region.
@available(iOS 14.0, *)
public struct TextView<T>: TextFieldInput, AccessabilitySupportUIKit, Identifiable where T: View {
    
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
    
    // MARK: - Private Properties
    
    @State private var segmentSize: CGSize = .zero
    @State private var textViewHeight: CGFloat = 36.0
    @State private var textViewWidth: CGFloat?
    @State private var trailingViewSize: CGSize = CGSize(
        width: 30.0,
        height: LayoutGrid.halfModule * 6
    )

    @Binding private var scheme: StandardTextFieldScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<StandardTextFieldScheme>()
    
    private let rightOffset = LayoutGrid.module
    private let labelOffset: CGFloat = 30.0
    private let horizontalPadding = LayoutGrid.doubleModule
    private var accessibilityIdentifier: String?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object,
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
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
    ///    - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    /// - Returns: Text view.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T,
        scheme: Binding<StandardTextFieldScheme?> = .constant(nil)
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
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self.onCursorPosition = onCursorPosition
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self.trailingView = trailingView
        self._scheme = scheme
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object,
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
    ///    - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    /// - Returns: Text view.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        @ViewBuilder trailingView: @escaping () -> T,
        scheme: Binding<StandardTextFieldScheme?> = .constant(nil)
    ) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
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
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition,
            trailingView: trailingView,
            scheme: scheme
        )
    }

    // MARK: - Body
    
    public var body: some View {
        let isTextFieldDisabled = !isEnabled || (state == .disabled || state == .readOnly)
        
        let scheme = self.scheme ?? schemeProvider.scheme
        let placeholderColor = scheme.placeholderColor.parameter(for: state == .disabled ? .disabled : .normal)
        var underlineColor = scheme.underlineColor.swiftUIColor
        var textColor = scheme.textColor
        var tintColor = scheme.tintColor
        var infoColor = scheme.placeholderColor.parameter(for: .normal)?.swiftUIColor  ?? .clear
        let curcorColor = scheme.tintColor
        
        let textViewWidth = textViewWidth(segmentSize: segmentSize)
        
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
        
        return TextInputDecorationBox<AnyView>(
            textFieldView: {
                textFieldView(
                    tintColor: curcorColor,
                    textColor: textColor.uiColor,
                    textFieldFont: scheme.textFieldFont.uiFont,
                    trailingViewTintColor: scheme.underlineColor.swiftUIColor,
                    isTextFieldDisabled: isTextFieldDisabled,
                    textViewWidth: textViewWidth)
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
            nameOffset: labelOffset,
            nameFilledOffset: 0.0,
            placeholderOffset: labelOffset,
            segmentSize: $segmentSize,
            separatorLineMode: state != .readOnly ? .solid : .dashed(lineWidth: 1.0, dash: 5.0),
            isFocused: $isFocused,
            isFilled: $isFilled,
            isTextFieldDisabled: isTextFieldDisabled)
    }
    
    // MARK: - Public Methods
    
    /// Sets the state text field.
    /// - Parameter state: The state that the text field displays.
    /// - Returns: Text view.
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
    
    func scheme(_ scheme: Binding<StandardTextFieldScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func clear() {
        content = ""
    }
    
    private func textViewWidth(segmentSize: CGSize) -> CGFloat {
        let segmentSizeWidth = segmentSize.width
        var textViewWidth = segmentSizeWidth - rightOffset
        if !(trailingView() is EmptyView) {
            textViewWidth -= trailingViewSize.width
        }
        return max(textViewWidth, 0.0)
    }
    
    private func textView(textColor: UIColor, tintColor: UIColor, font: UIFont?, width: CGFloat, isEnabled: Bool) -> some View {
        UIKitTextView(
            text: $content,
            isResponder: isResponder == nil ? $isTextFieldResponder : isResponder,
            formatter: formatter,
            fixWidth: width,
            updateHeight: $textViewHeight,
            isEnabled: isEnabled,
            keyboard: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            canPerformActionPaste: canPerformActionPaste,
            textColor: textColor,
            tintColor: tintColor,
            font: font,
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition,
            accessibilityIdentifier: accessibilityIdentifier,
            horizontalPadding: horizontalPadding
        )
            .frame(height: textViewHeight)
            .offset(x: -LayoutGrid.halfModule)
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
                    withAnimation(.spring()) {
                        isFilled = false
                    }
                } else {
                    withAnimation(.spring()) {
                        isFilled = true
                    }
                }
            }
    }
    
    private func textFieldView(
        tintColor: AColor?,
        textColor: UIColor,
        textFieldFont: UIFont?,
        trailingViewTintColor: Color,
        isTextFieldDisabled: Bool,
        textViewWidth: CGFloat) -> AnyView {
        HStack(alignment: .top) {
            ZStack {
                if textViewWidth > 0 {
                    textView(
                        textColor: textColor,
                        tintColor: tintColor?.uiColor ?? .clear,
                        font: textFieldFont,
                        width: textViewWidth,
                        isEnabled: !isTextFieldDisabled)
                        .offset(y: LayoutGrid.halfModule)
                }
            }
            Spacer(minLength: trailingView() is EmptyView ? 0.0 : LayoutGrid.module)
            if !(trailingView() is EmptyView) {
                trailingView()
                    .foregroundColor(trailingViewTintColor)
                    .offset(y: LayoutGrid.module)
                    .accessibilityIdentifier(TextFieldsAccessibilityIdentifiers.trailingView.accessibilityViewIdentifier(accessibilityIdentifier: accessibilityIdentifier))
                    .modifier(SizeAwareViewModifier(viewSize: $trailingViewSize))
            }
        }
        .eraseToAnyView()
    }
    
}

@available(iOS 14.0, *)
extension TextView where T == EmptyView {
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object,
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
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
    ///    - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    /// - Returns: Text view.
    public init<V>(
        value: Binding<V?>,
        accessibilityIdentifier: String? = nil,
        formatter: Formatter? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        scheme: Binding<StandardTextFieldScheme?> = .constant(nil)
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
        self.name = name
        self._state = state
        self._info = info
        self.onSubmit = onSubmit
        self.infoNumberOfLines = infoNumberOfLines
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.canPerformActionPaste = canPerformActionPaste
        self.isResponder = isResponder
        self.onCursorPosition = onCursorPosition
        self._isFocused = .init(initialValue: isResponder?.wrappedValue ?? false)
        self.trailingView = { EmptyView() }
        self._scheme = scheme
        self._isFilled = .init(initialValue: !($content.wrappedValue ?? "").isEmpty)
        self.accessibilityIdentifier = accessibilityIdentifier
    }
    
    /// Initializes and returns a newly allocated view object,
    /// - Parameters:
    ///   - content:  The text that the text field displays.
    ///   - accessibilityIdentifier: The id used by accessibility method.
    ///   - contentType: The semantic meaning for a text input area.
    ///   - returnKeyType: The visible title of the Return key.
    ///   - autocapitalizationType: The autocapitalization style for the text object.
    ///   - autocorrectionType: The autocorrection style for the text object.
    ///   - canPerformActionPaste: Flag is disable pasting.
    ///   - placeholder: The string that displays when there is no other text in the text field.
    ///   - name: The text field’s name.
    ///   - icon: The text field’s traling image view.
    ///   - state: The textfield state.
    ///   - info: The string that displays some additional info.
    ///   - infoNumberOfLines: infoNumberOfLines: The maximum number of lines to use for info. If nil, no line limit applies.
    ///    - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    ///   - trailingView: Tap traling view.
    /// - Returns: Text view.
    public init(
        _ content: Binding<String?>,
        accessibilityIdentifier: String? = nil,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .default,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .yes,
        canPerformActionPaste: Bool = false,
        placeholder: String = "",
        name: String = "",
        state: Binding<TextInputState> = .constant(.normal),
        info: Binding<String> = .constant(""),
        infoNumberOfLines: Int? = nil,
        isResponder: Binding<Bool>? = nil,
        onSubmit: (() -> Void)? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil) {
        self.init(
            value: content,
            accessibilityIdentifier: accessibilityIdentifier,
            formatter: nil,
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
            onSubmit: onSubmit,
            onCursorPosition: onCursorPosition)
    }
    
}

@available(iOS 14.0, *)
struct TextView_Previews: PreviewProvider {

    @State static var text: String? = ""

    static var previews: some View {
        TextView($text, placeholder: "Placeholder", name: "Optional Label", state: .constant(.normal))
    }
}

