//
//  TextView.swift
//  AdmiralUI
//
//  Created on 10.03.2021.
//

import UIKit
import AdmiralTheme

/// A  multiline text region.
open class TextView: TextViewInput, AnyAppThemable, AccessibilitySupport {
    
    private enum Constants {
        static let separatorLineWidth: CGFloat = 1.0 / UIScreen.main.scale
        static let trailingViewSizeSmall: CGSize = CGSize(width: 3 * LayoutGrid.module, height: 3 * LayoutGrid.module)
        static let trailingViewSizeLarge: CGSize = CGSize(width: 5 * LayoutGrid.module, height: 5 * LayoutGrid.module)
    }
    
    /// The text view state.
    public var state: TextInputState {
        get { return privateTextFieldState }
        set { setState(newValue, animated: false) }
    }
    
    /// A Boolean value that determines whether the separator is hidden.
    public var isSeparatorHidden: Bool {
        get { return decorationView.separatorView.alpha == 0 }
        set { decorationView.separatorView.alpha = newValue ? 0 : 1 }
    }
    
    /// A Boolean value indicating whether the control is in the selected state.
    public var isSelected: Bool = false {
        didSet { updateColors() }
    }
    
    /// The text view's name.
    public var name: String? {
        get { return decorationView.name }
        set { decorationView.name = newValue }
    }
    
    /// The string that displays when there is no other text in the text field.
    public var placeholder: String? {
        get { return decorationView.placeholder }
        set { update(placeholder: newValue) }
    }
    
    /// The string that displays some additional info.
    public var info: String? {
        get { return decorationView.info }
        set { decorationView.info = newValue }
    }
    
    /// The maximum number of lines to use for info.
    public var infoNumberOfLines: Int {
        get { return decorationView.informerLabel.numberOfLines }
        set { decorationView.informerLabel.numberOfLines = newValue }
    }
    
    /// The text view’s trailing view.
    public var trailingView: UIView? {
        get { return decorationView.trailingView }
        set {
            updateTrailingView()
            decorationView.trailingView = newValue
        }
    }
    
    /// The  type of text view trailing view.
    public var trailingViewStyle: TextInputTrailingViewStyle = .default {
        didSet { updateTrailingView() }
    }
    
    // MARK: - Internal Properties
        
    var forceOpened: Bool = false {
        didSet { configureState(anmated: false) }
    }

    var scheme = TextFieldScheme() {
        didSet { updateScheme() }
    }
    
    var decorationView: TextInputDecorationView!
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateFonts() }
    }
    
    // MARK: - Private Properties
    
    private var isTextViewEditing: Bool = false
    private var privateTextFieldState: TextInputState = .normal
    
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
        configureState(anmated: animated)
    }
    
    /// Sets the  state, allowing you to animate the change visually.
    /// - Parameters:
    ///   - state: State.
    ///   - animated: Specify true to animate the change in text; otherwise, specify false.
    open func setState(_ state: TextInputState, animated: Bool) {
        privateTextFieldState = state
        configureState(anmated: animated)
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
                    self.isSeparatorHidden = hidden
                }, completion: nil)
        } else {
            isSeparatorHidden = hidden
        }
    }
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        self.scheme = TextFieldScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    override func commonInit() {
        super.commonInit()
        addSubviews()
        configureUI()
    }
    
    override func textViewStateNeedUpdate() {
        configureState(anmated: true)
    }
    
    private func addSubviews() {
        decorationView = TextInputDecorationView(textInput: inputTextView)
        [decorationView].addToSuperview(self)
        decorationView.fillView(view: self).activate()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        inputTextView.backgroundColor = .clear
        inputTextView.delegate = self
        inputTextView.isScrollEnabled = false
        inputTextView.textContainerInset = .zero
        inputTextView.textContainer.lineFragmentPadding = 0
        inputTextView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        decorationView.separatorView.lineWidth = Constants.separatorLineWidth

        addGestures()
        configureState(anmated: false)
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        decorationView.tapAreaView.addGestureRecognizer(tap)
    }
    
    @objc private func didTap() {
        guard !inputTextView.isFirstResponder else { return }
        becomeFirstResponder()
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
    }
    
    private func updateColors() {
        inputTextView.tintColor = scheme.tintColor.uiColor
        decorationView.placeholderLabel.textColor = scheme.placeholderColor.uiColor

        switch state {
        case .normal:
            inputTextView.textColor = scheme.textColor.uiColor
            decorationView.nameLabel.textColor = (isEditing || (isSelected && decorationView.isOpened)) ? scheme.tintColor.uiColor : scheme.underlineColor.uiColor
            decorationView.separatorView.lineColor = (isEditing || isSelected) ? scheme.tintColor.uiColor : scheme.underlineColor.uiColor
            decorationView.informerLabel.textColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .error:
            inputTextView.textColor = scheme.textColor.uiColor
            decorationView.nameLabel.textColor = scheme.errorColor.uiColor
            decorationView.informerLabel.textColor = scheme.errorColor.uiColor
            decorationView.separatorView.lineColor = scheme.errorColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .disabled:
            inputTextView.textColor = scheme.disabledColor.uiColor
            decorationView.nameLabel.textColor = scheme.disabledColor.uiColor
            decorationView.informerLabel.textColor = scheme.disabledColor.uiColor
            decorationView.separatorView.lineColor = scheme.disabledColor.uiColor
            decorationView.separatorView.lineMode = .solid
        case .readOnly:
            inputTextView.textColor = scheme.textColor.uiColor
            decorationView.nameLabel.textColor = scheme.underlineColor.uiColor
            decorationView.informerLabel.textColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineColor = scheme.underlineColor.uiColor
            decorationView.separatorView.lineMode = .dashed(dash: LayoutGrid.halfModule, gap: LayoutGrid.halfModule, phase: 0)
        }
    }
    
    private func update(placeholder: String?) {
        decorationView.placeholderLabel.text = placeholder
        updatePlaceholder()
    }
    
    private func updateTrailingView() {
        switch trailingViewStyle {
        case .small:
            decorationView.layoutParameters.trailingViewAlignmentStyle = .bottom(offset: 2)
            decorationView.layoutParameters.trailingViewSize = Constants.trailingViewSizeSmall
        case .large:
            decorationView.layoutParameters.trailingViewAlignmentStyle = .bottom(offset: 8)
            decorationView.layoutParameters.trailingViewSize = Constants.trailingViewSizeLarge
        }
    }
    
}

// MARK: - State Configuration

extension TextView {
    
    private var isTextFieldOpened: Bool {
        return (isEditing || text?.nilIfEmpty != nil) || forceOpened
    }

    private var isPlaceholderLabelHidden: Bool {
        return ((isTextFieldOpened || placeholder == nil) && text?.nilIfEmpty != nil) ||
               (!isTextFieldOpened && name?.nilIfEmpty != nil)
    }

    private var isPlaceholderLabelNeedOffset: Bool {
        return (name?.nilIfEmpty == nil && isEditing) || (name?.nilIfEmpty != nil && (isEditing || !forceOpened))
    }

    private var isTextFieldHidden: Bool {
        return !isTextFieldOpened
    }
    
    private func configureState(anmated: Bool) {
        updatePlaceholder()
        updateTextView()
        
        setNeedsLayout()
        layoutIfNeeded()

        if anmated {
            UIView.animate(
                withDuration: Durations.Default.half,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    self.updateDecorationView()
                    self.updateColors()
                    self.layoutIfNeeded()
                }, completion: nil)
        } else {
            updateDecorationView()
            updateColors()
            layoutIfNeeded()
        }
    }
    
    private func updateDecorationView() {
        decorationView.isOpened = self.isTextFieldOpened
    }
    
    private func updatePlaceholder() {
        decorationView.placeholderLabel.isHidden = isPlaceholderLabelHidden
        decorationView.enablePlaceholderOffset = isPlaceholderLabelNeedOffset
    }
    
    private func updateTextView() {
        inputTextView.isHidden = isTextFieldHidden
        inputTextView.isUserInteractionEnabled = (state != .disabled && state != .readOnly)
    }

}
