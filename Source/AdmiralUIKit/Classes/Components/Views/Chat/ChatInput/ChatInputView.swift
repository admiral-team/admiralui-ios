//
//  ChatInputView.swift
//  AdmiralUIKit
//
//  Created on 25.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/// A custom protocol that describes some methods of communication with ChatInputView.
public protocol ChatInputViewDelegate: AnyObject {
    /// A method that calls changing of UITextField in ChatInputView.
    func textViewSizeDidChange(_ chatInput: ChatInputView, size: CGSize)
    /// A method that calls when button was pressed.
    func didTapSendButton(_ chatInput: ChatInputView)
}

/// A state that changes image in left image button.
public enum ChatInputMessageAction {
    case attachFiles
    case deleteVoiceRecord
    case startRecording
}

/// A  multiline text region.
open class ChatInputView: TextViewInput, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constraints

    private enum Constants {
        static let chatButtomSize: CGFloat = LayoutGrid.quadrupleModule + LayoutGrid.module
        static let textContainerInset = UIEdgeInsets(top: LayoutGrid.module + 2, left: LayoutGrid.quadrupleModule + 10, bottom: LayoutGrid.module + 2, right: LayoutGrid.module + 2)
        static let textViewTrailingAnchor: CGFloat = LayoutGrid.module * 6
        static let maxHeightInput: CGFloat = 306.0
    }

    /// The text view state.
    public var state: TextInputState {
        get { return privateTextFieldState }
        set { setState(newValue, animated: false) }
    }

    /// The state that controls an image in left action button.
    public var actionState:ChatInputMessageAction {
        get { return privateChatAction }
        set {
            setActionState(newValue, animated: true)
        }
    }

    /// The text value
    public var inputText: String? {
        return inputTextView.text
    }
    
    /// Flag disabled send button.
    public var isSendButtonDisabled: Bool? {
        didSet {
            configureState(animated: false)
        }
    }

    /// The text label placeholder
    public var placeholder: String? {
        get { return placeholderLabel.text }
        set { update(placeholder: newValue) }
    }

    /// A Boolean value indicating whether the control is in the selected state.
    public var isSelected: Bool = false {
        didSet { updateColors() }
    }

    weak open var chatInputDelegate: ChatInputViewDelegate? = nil

    lazy private var chatInputActionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Internal Properties

    var forceOpened: Bool = false {
        didSet { configureState(animated: false) }
    }

    var scheme = ChatInputTextFieldScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private properties

    private let chatButton = ChatButton()
    private let placeholderLabel = UILabel()

    // MARK: - AccessibilitySupport

    public var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }

    // MARK: - Private Properties

    private var isTextViewEditing: Bool = false
    private var privateTextFieldState: TextInputState = .normal
    private var privateChatAction: ChatInputMessageAction = .attachFiles

    // MARK: - Private computed properties

    private var isOversized = false {
        didSet {
            inputTextView.isScrollEnabled = isOversized
            inputTextView.setNeedsUpdateConstraints()
        }
    }

    // MARK: - Public Methods

    /// Asks UIKit to make this object the first responder in its window.
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        return inputTextView.becomeFirstResponder()
    }

    /// Notifies this object that it has been asked to relinquish its status as first responder in its window.
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        return inputTextView.resignFirstResponder()
    }

    /// Sets the  text, allowing you to animate the change visually.
    /// - Parameters:
    ///   - text: Text.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    open func setText(_ text: String?, animated: Bool) {
        inputTextView.text = text
        configureState(animated: animated)
    }

    /// Sets the  state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - state: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    open func setState(_ state: TextInputState, animated: Bool) {
        privateTextFieldState = state
        configureState(animated: animated)
    }

    /// Sets the  state of left button that allows you to change image button.
    /// - Parameters:
    ///   - state: ChatInputMessageAction.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    open func setActionState(_ state: ChatInputMessageAction, animated: Bool) {
        privateChatAction = state
        switch state {
        case .attachFiles:
            chatInputActionButton.setImage(Asset.System.Outline.attachFileOutline.image, for: .normal)
        case .deleteVoiceRecord:
            chatInputActionButton.setImage(Asset.System.Outline.deleteOutline.image, for: .normal)
        default:
            break
        }
    }

    /// Sets the  separator state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - hidden: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    open func setSeparator(hidden: Bool, animated: Bool) {
        if animated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    //self.isSeparatorHidden = hidden
                }, completion: nil)
        } 
    }

    // MARK: - AppTheamable

    open func apply(theme: AppTheme) {
        self.scheme = ChatInputTextFieldScheme(theme: theme)
        chatButton.apply(theme: theme)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        chatInputDelegate?.textViewSizeDidChange(self, size: frame.size)
    }

    // MARK: - Private Methods

    override func commonInit() {
        super.commonInit()
        addSubviews()
        setupContraints()
        configureUI()
    }

    override func textViewStateNeedUpdate() {
        configureState(animated: true)
    }

    private func addSubviews() {
        [chatButton, inputTextView, chatInputActionButton, placeholderLabel].addToSuperview(self)
    }

    private func setupContraints() {
        NSLayoutConstraint.activate([
            chatButton.widthAnchor.constraint(equalToConstant: Constants.chatButtomSize),
            chatButton.heightAnchor.constraint(equalToConstant: Constants.chatButtomSize),
            chatButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            chatButton.trailingAnchor.constraint(equalTo: trailingAnchor),

            inputTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputTextView.topAnchor.constraint(equalTo: topAnchor),
            inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.textViewTrailingAnchor),

            chatInputActionButton.leadingAnchor.constraint(equalTo: inputTextView.leadingAnchor, constant: LayoutGrid.module + 2),
            chatInputActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutGrid.module),

            placeholderLabel.leadingAnchor.constraint(equalTo: inputTextView.leadingAnchor, constant: Constants.chatButtomSize),
            placeholderLabel.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: -(LayoutGrid.module + 2))
        ])
    }

    private func configureUI() {
        apply(theme: defaultTheme)
        configurePlaceHolder()
        configureChatButton()
        configureInputTextView()
        addGestures()
        configureState(animated: false)
    }

    private func configurePlaceHolder() {
        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureChatButton() {
        chatButton.setImage(PrivateAsset.Custom.CirclePageControl.arrowRight.image, for: .normal)
        chatButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        chatInputActionButton.tintColor = scheme.imageTintColor.uiColor
    }

    private func configureInputTextView() {
        inputTextView.layer.cornerRadius = LayoutGrid.module
        inputTextView.backgroundColor = scheme.textFieldBackgroundColor.parameter(for: privateTextFieldState)?.uiColor
        inputTextView.delegate = self
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.isScrollEnabled = false
        inputTextView.isUserInteractionEnabled = true
        inputTextView.textContainerInset = Constants.textContainerInset
        inputTextView.textContainer.lineFragmentPadding = .zero
        inputTextView.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        inputTextView.addGestureRecognizer(tap)
    }

    @objc private func didTap() {
        guard !inputTextView.isFirstResponder else { return }
        becomeFirstResponder()
    }

    @objc private func didTapSendButton() {
        chatInputDelegate?.didTapSendButton(self)
        isOversized = false
    }

    private func updateScheme() {
        updateFonts()
        updateColors()
    }

    private func updateFonts() {
        inputTextView.setDynamicFont(
            font: scheme.textFieldFont.uiFont,
            textStyle: scheme.textFieldFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        placeholderLabel.setDynamicFont(
            font: scheme.placeholderFont.uiFont,
            textStyle: scheme.placeholderFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }

    private func updateColors() {
        inputTextView.tintColor = scheme.tintColor.parameter(for: privateTextFieldState)?.uiColor
        placeholderLabel.textColor = scheme.placeholderColor.parameter(for: privateTextFieldState)?.uiColor
        inputTextView.textColor = scheme.textColor.parameter(for: privateTextFieldState)?.uiColor
        inputTextView.backgroundColor = scheme.textFieldBackgroundColor.parameter(for: privateTextFieldState)?.uiColor
    }

    private func update(placeholder: String?) {
        placeholderLabel.text = placeholder
        updatePlaceholder()
    }

}

// MARK: - State Configuration

extension ChatInputView {

    open override func textViewDidChange(_ textView: UITextView) {
        textViewStateNeedUpdate()
        isOversized = textView.contentSize.height >= Constants.maxHeightInput
        updateTextViewHeight()
    }

    private var isTextFieldOpened: Bool {
        return (isEditing || text?.nilIfEmpty != nil) || forceOpened
    }

    private var isPlaceholderLabelHidden: Bool {
        return (placeholder == nil || text?.nilIfEmpty != nil)
    }

    private func updateTextViewHeight() {
        delegate?.textViewInputDidChange?(self)
    }

    private func configureState(animated: Bool) {
        updatePlaceholder()
        updateTextView()

        let isChatButtonDisabled = isSendButtonDisabled ?? inputText?.isEmpty == true
        chatButton.isEnabled = isChatButtonDisabled ? false : privateTextFieldState == .disabled || privateTextFieldState == .readOnly ? false : true
        chatInputActionButton.isEnabled = privateTextFieldState == .disabled || privateTextFieldState == .readOnly ? false : true

        setNeedsLayout()
        layoutIfNeeded()

        if animated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.updateColors()
                    self.layoutIfNeeded()
                }, completion: nil)
        } else {
            updateColors()
            layoutIfNeeded()
        }
    }

    private func updatePlaceholder() {
        placeholderLabel.isHidden = isPlaceholderLabelHidden
    }

    private func updateTextView() {
        inputTextView.isUserInteractionEnabled = (state != .disabled && state != .readOnly)
    }

}



