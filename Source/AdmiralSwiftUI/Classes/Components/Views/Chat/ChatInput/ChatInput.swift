//
//  ChatInput.swift
//  AdmiralSwiftUI
//
//  Created on 16.08.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/**
 ChatInput - A view for chat input message and add files.

 You can create a ChatInput by specifying the following parameters in the initializer

 - content: Binding<String - The text that the text field displays.
 - contentType: UIKeyboardType - The semantic meaning for a text input area.
 - returnKeyType: UIReturnKeyType - The visible title of the Return key.
 - autocapitalizationType: UITextAutocapitalizationType - The autocapitalization style for the text object.
 - autocorrectionType: UITextAutocorrectionType - The autocorrection style for the text object.
 - isResponder: Binding<Bool?> - Is ChatInput responder
 - placeholder: String - The string that displays when there is no other text in the text field.
 - tapSendButton: @escaping () - Tap send button. Return true if you want clear text.
 - tapFileButton: @escaping () - Tap file button.
 - isShowFileButton: Bool - Will the file button be shown.
 - formatter: Formatter?
 - isSendButtonDisabled: Bool? - Flag send button disabled.
 - maxNumberOfLines: Int? - Max number of lines input.
 - maxHeight: CGFloat? - Max height input
 - onCursorPosition: An action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.

 ## Example to create ChatInput:
 # Code
 ```
 ChatInput(
     .constant("Text"),
     contentType: .default,
     returnKeyType: .send,
     autocapitalizationType: .none,
     autocorrectionType: .default,
     isResponder: .constant(false),
     placeholder: "Введите сообщение",
     tapSendButton: {},
     tapFileButton: {},
     isShowFileButton: true
 )
 ```
*/
@available(iOS 14.0, *)
public struct ChatInput: View, AccessabilitySupportUIKit {

    // MARK: - Constants

    enum Constants {
        static let maxHeightInput: CGFloat = 306.0
        static let lineSpacing = LayoutGrid.halfModule
    }

    // MARK: - Private Properties

    /// The text that the text field displays.
    @Binding private var content: String?

    /// Flag disabled send button.
    private var isSendButtonDisabled: Bool?

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

    /// Flag show file button
    private let isShowFileButton: Bool

    /// Flag that hide or show sendButton
    private let isTapSendButtonHidden: Bool

    /// Text field formatter.
    private let formatter: Formatter?

    /// Tap send button. Return true if you want clear text.
    private let tapSendButton: () -> (Bool)

    /// Tap file button.
    private let tapFileButton: () -> ()

    /// Adds an action to perform change cursor position. On enter 3 parameters - startCursor, currentCursor, text. Return cursor position.
    private let onCursorPosition: ((Int, Int, String) -> (Int))?

    // Flag is disable pasting. If flasg is true pasting is enabled.
    private let canPerformActionPaste: Bool

    @Environment(\.isEnabled) private var isEnabled

    @State private var isScrollEnabled: Bool = false
    @State private var isTextFieldResponder: Bool = false
    @State private var segmentSize: CGSize = .zero
    @State private var textViewHeight: CGFloat = 0.0
    @State private var initGeometryReader = false
    @State private var isSendButtonEnabled = true

    private var maxHeight: CGFloat?
    private var isResponder: Binding<Bool>?
    private var maxNumberOfLines: Int?
    private var accessibilityIdentifier: String?

    private var maxHeightInput: CGFloat {
        return maxHeight ?? Constants.maxHeightInput
    }

    @Binding private var scheme: ChatInputScheme?
    @ObservedObject var schemeProvider = AppThemeSchemeProvider<ChatInputScheme>()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object
    public init<V>(
        value: Binding<V?>,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .search,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = false,
        isResponder: Binding<Bool>? = nil,
        placeholder: String = "",
        tapSendButton: @escaping () -> (Bool) = { return false },
        tapFileButton: @escaping () -> () = {},
        isShowFileButton: Bool = false,
        isTapSendButtonHidden: Bool = false,
        formatter: Formatter? = nil,
        isSendButtonDisabled: Bool? = nil,
        maxNumberOfLines: Int? = nil,
        maxHeight: CGFloat? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        scheme: Binding<ChatInputScheme?> = .constant(nil)
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
        self.contentType = contentType
        self.returnKeyType = returnKeyType
        self.autocapitalizationType = autocapitalizationType
        self.autocorrectionType = autocorrectionType
        self.isResponder = isResponder
        self.placeholder = placeholder
        self.tapSendButton = tapSendButton
        self.tapFileButton = tapFileButton
        self.isShowFileButton = isShowFileButton
        self.isTapSendButtonHidden = isTapSendButtonHidden
        self.formatter = formatter
        self.isSendButtonDisabled = isSendButtonDisabled
        self.onCursorPosition = onCursorPosition
        self.canPerformActionPaste = canPerformActionPaste
        self._scheme = scheme
        updateMaxHeight(maxNumberOfLines: maxNumberOfLines, maxHeight: maxHeight)
    }

    /// Initializes and returns a newly allocated view object
    public init(
        _ content: Binding<String?>,
        contentType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .search,
        autocapitalizationType: UITextAutocapitalizationType = .none,
        autocorrectionType: UITextAutocorrectionType = .no,
        canPerformActionPaste: Bool = false,
        isResponder: Binding<Bool>? = nil,
        placeholder: String = "",
        tapSendButton: @escaping () -> (Bool) = { return false },
        tapFileButton: @escaping () -> () = {},
        isShowFileButton: Bool = false,
        isTapSendButtonHidden: Bool = false,
        formatter: Formatter? = nil,
        isSendButtonDisabled: Bool? = nil,
        maxNumberOfLines: Int? = nil,
        maxHeight: CGFloat? = nil,
        onCursorPosition: ((Int, Int, String) -> (Int))? = nil,
        scheme: Binding<ChatInputScheme?> = .constant(nil)
    ) {
        self.init(
            value: content,
            contentType: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            canPerformActionPaste: canPerformActionPaste,
            isResponder: isResponder,
            placeholder: placeholder,
            tapSendButton: tapSendButton,
            tapFileButton: tapFileButton,
            isShowFileButton: isShowFileButton,
            isTapSendButtonHidden: isTapSendButtonHidden,
            formatter: formatter,
            isSendButtonDisabled: isSendButtonDisabled,
            maxNumberOfLines: maxNumberOfLines,
            maxHeight: maxHeight,
            onCursorPosition: onCursorPosition,
            scheme: scheme
        )
    }

    // MARK: - Body

    public var body: some View {
        let scheme = scheme ?? schemeProvider.scheme

        return VStack(spacing: .zero) {
            HStack(alignment: .bottom) {
                HStack(alignment: .bottom, spacing: .zero) {
                    if isShowFileButton {
                        Button(action: { tapFileButton() }, label: {
                            AssetSymbol.System.Outline.attachFile.image
                        })
                        .foregroundColor(scheme.imageTintColor.swiftUIColor)
                        .frame(width: LayoutGrid.doubleModule, height: LayoutGrid.doubleModule)
                        .padding(.vertical, LayoutGrid.halfModule * 3)
                        .padding(.leading, LayoutGrid.halfModule * 3)
                    }

                    ZStack {
                        HStack(spacing: 0.0) {
                            Text(placeholder)
                                .opacity((content ?? "").isEmpty ? 1 : .zero)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(scheme.placeholderColor.swiftUIColor)
                                .font(scheme.placeholderFont.swiftUIFont)
                                .frame(height: LayoutGrid.halfModule * 3)
                                .padding(.horizontal, LayoutGrid.doubleModule)
                            Spacer()
                        }
                        if maxNumberOfLines == 1 {
                            textField()
                        } else {
                            textView()
                        }
                    }

                }
                .frame(height: min(max(textViewHeight, LayoutGrid.halfModule * 10), maxHeightInput + LayoutGrid.doubleModule))
                .background(scheme.backgroundColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                .cornerRadius(LayoutGrid.module)
                if !isTapSendButtonHidden {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Button(action: {
                            if tapSendButton() {
                                clear()
                            }
                        }, label: {
                            AssetSymbol.System.Outline.arrowRight.image
                        })
                        .buttonStyle(ChatButtonStyle())
                        .disabled(isSendButtonDisabled ?? isSendButtonEnabled)
                    }
                }

            }

        }
    }

    // MARK: - Public Methods

    public func accessibility(identifierUIKit: String) -> Self {
        var view = self
        view.accessibilityIdentifier = identifierUIKit
        return view
    }

    /// Clear text in text input.
    public func clear() {
        withAnimation(.easeInOut) {
            content = ""
            textViewHeight = LayoutGrid.halfModule * 9
        }
    }

    // MARK: - Internal Methods

    func scheme(_ scheme: Binding<ChatInputScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }

    @ViewBuilder
    func textView() -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        GeometryReader { geo in
            if initGeometryReader {
                UIKitTextView(
                    text: $content,
                    isResponder: isResponder,
                    formatter: formatter,
                    fixWidth: geo.size.width - LayoutGrid.halfModule * 6,
                    maxHeight: maxHeightInput,
                    updateHeight: $textViewHeight,
                    isEnabled: isEnabled,
                    isScrollEnabled: isScrollEnabled,
                    autocapitalizationType: autocapitalizationType,
                    autocorrectionType: autocorrectionType,
                    canPerformActionPaste: canPerformActionPaste,
                    textColor: scheme.textColor.uiColor,
                    tintColor: scheme.tintColor.uiColor,
                    font: scheme.textFont.uiFont,
                    onCursorPosition: onCursorPosition
                )
                    .frame(width: geo.size.width - LayoutGrid.halfModule * 6)
                    .padding(.horizontal, LayoutGrid.halfModule * 3)
                    .padding(.vertical, LayoutGrid.halfModule * 2)
                    .offset(y: textViewHeight >= maxHeightInput ? 0.0 : -6)
                    .onChange(of: textViewHeight) { value in
                        DispatchQueue.main.async {
                            self.isScrollEnabled = value >= maxHeightInput && !(content ?? "").isEmpty
                        }
                    }
                    .onChange(of: content) { text in
                        guard let text = text else { return }
                        isSendButtonEnabled = text.isEmpty && isEnabled
                    }
            }
        }
        .onAppear {
            initGeometryReader = true
        }
    }

    @ViewBuilder
    func textField() -> some View {
        let scheme = scheme ?? schemeProvider.scheme
        UIKitTextField(
            text: $content,
            isResponder: isResponder,
            formatter: formatter,
            keyboard: contentType,
            returnKeyType: returnKeyType,
            autocapitalizationType: autocapitalizationType,
            autocorrectionType: autocorrectionType,
            textColor: scheme.textColor.uiColor,
            placeholderColor: .clear,
            tintColor: scheme.tintColor.uiColor,
            font: scheme.textFont.uiFont,
            onCursorPosition: onCursorPosition
        )
            .padding(LayoutGrid.halfModule * 3)
            .offset(x: LayoutGrid.halfModule)
            .onChange(of: content) { text in
                guard let text = text else { return }
                isSendButtonEnabled = text.isEmpty && isEnabled
            }
    }

    mutating func updateMaxHeight(maxNumberOfLines: Int?, maxHeight: CGFloat?) {
        if let maxHeight = maxHeight {
            self.maxHeight = maxHeight
            self.maxNumberOfLines = nil
            return
        }

        self.maxNumberOfLines = maxNumberOfLines

        guard let maxNumberOfLines = maxNumberOfLines, maxNumberOfLines > 0 else {
            self.maxHeight = nil
            return
        }

        let scheme = scheme ?? schemeProvider.scheme
        let lineHeight = scheme.textFont.size
        self.maxHeight = (lineHeight + Constants.lineSpacing) * CGFloat(maxNumberOfLines)
    }

}
