//
//  CodeInputControl.swift
//  AdmiralUI
//
//  Created on 03.11.2020.
//

import UIKit

/// A set of optional methods that you use to manage the editing and validation of text in a code input object.
@objc public protocol CodeInputControlDelegate: AnyObject {
    /// Asks the delegate whether to process the pressing of the Return button for the control.
    @objc optional func codeInputControlShouldReturn(control: CodeInputControl)
    
    /// Tells the delegate when editing control input.
    @objc optional func codeInputControlDidFinish(_ control: CodeInputControl, text: String)
    
    /// Called when the text has changed.
    @objc optional func codeInputControl(_ control: CodeInputControl, textDidChange text: String)
    
    /// Asks the delegate whether to change the specified text.
    @objc optional func codeInputControl(_ control: CodeInputControl, shouldChange newString: String) -> Bool
}

/// Abstract class of input control.
open class CodeInputControl: UIControl {

    public enum Style: Int {
        case `default`
        case contrast
    }
    
    public enum Status: Int {
        case normal
        case success
        case error
    }
    
    // MARK: - Public Properties
    
    open var style: Style = .default {
        didSet { updateStates() }
    }
    
    /// Number of items in control.
    open var itemsCount = 4 {
        willSet { prepareViews(elementsCount: newValue) }
    }
    
    /// Delegate
    open weak var delegate: CodeInputControlDelegate?
    
    /// Input text
    open var text: String {
        get {
            return codeViews
                .compactMap { $0.text }
                .reduce("") { $0 + $1 }
        }
        set {
            cursorPosition = 0
            codeViews.forEach { $0.text = nil }
            newValue.forEach { insert(text: String($0), delegate: nil) }
        }
    }
    
    /// Current controll status.
    open var status: Status = .normal {
        didSet { updateStatesAnimated() }
    }
    
    /// The property that indicate is control focused.
    open var isOnFocus: Bool = false {
        didSet { updateStatesAnimated() }
    }
    
    /// The property that indicate that control is filled.
    open var filled: Bool {
        return cursorPosition >= itemsCount
    }
    
    /// Set this propetry to true to ignore all user input.
    open var ignoreUserInput: Bool = false
    
    // MARK: - UITextInputTraits
    
    /// The type of keyboard to display for a given text-based view.
    open var keyboardType: UIKeyboardType = .default
    
    // MARK: - Internal Properties
    
    var codeViews = [CodeInputItemView]()
    var parameters = Layout.Parameters()
    
    var cursorPosition = 0 {
        didSet { updateStatesAnimated() }
    }
    
    // MARK: - UIResponder
    
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        prepareViews(elementsCount: itemsCount)
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        defer { isOnFocus = true }
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        defer { isOnFocus = false }
        return super.resignFirstResponder()
    }
    
    // MARK: - Public Methods
    
    /// Abstract method to create new input view.
    /// Must be overridden in subclass.
    /// - Returns: Custom code input item CodeInputItemView.
    func createNewItem() -> CodeInputItemView {
        fatalError("This is abstract property. Override it to return new item.")
    }
        
    // MARK: - Internal Methods
    
    func updateStatesAnimated() {
        let durartion = Durations.Default.single
        
        UIView.animate(
            withDuration: durartion,
            delay: 0,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                self?.updateStates()
            }, completion: nil)
    }
    
    func updateStates() {
        codeViews.forEach { $0.isOnFocus = false }
        codeViews.forEach { $0.style = self.style }
        
        if cursorPosition < codeViews.count {
            codeViews[cursorPosition].isOnFocus = isOnFocus
        } else {
            codeViews.last?.isOnFocus = false
        }
        
        codeViews.forEach { $0.status = status }
        updateColors()
    }
    
    func updateColors() {
        //
    }
    
    // MARK: - Private Methods
    
    private func prepareViews(elementsCount: Int) {
        let count = codeViews.count
        
        if elementsCount > count {
            for i in count..<elementsCount {
                let view = createNewItem()
                view.tag = i + 1
                
                addSubview(view)
                codeViews.append(view)
            }
            updateStates()
        } else if elementsCount < count {
            var tmpCount = count
            
            for i in elementsCount..<tmpCount {
                codeViews[i].removeFromSuperview()
                codeViews.remove(at: i)

                tmpCount -= 1
            }
            
            cursorPosition = min(self.cursorPosition, tmpCount)
        }
    }
    
    // MARK: - Layout
    
    override open var intrinsicContentSize: CGSize {
        return self.sizeThatFits(self.frame.size)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let count = self.codeViews.count
        let itemSize = self.parameters.itemSize
        let minSpacing = self.parameters.minSpacing
        
        let width = itemSize.width * CGFloat(count) + CGFloat(max(0, count - 1)) * minSpacing
        
        return CGSize(width: width, height: itemSize.height)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let result = self.calculateLayout(size: self.frame.size)
        result.digitViews.enumerated().forEach { self.codeViews[$0.offset].frame = $0.element }
        
        self.invalidateIntrinsicContentSize()
    }

}

// MARK: - UIKeyInput

extension CodeInputControl: UIKeyInput {

    public var hasText: Bool {
        return cursorPosition > 0
    }
    
    public func insertText(_ text: String) {
        guard !self.ignoreUserInput else { return }
        self.insert(text: text, delegate: self.delegate)
    }
    
    public func deleteBackward() {
        self.deleteText(delegate: self.delegate)
    }
    
    private func insert(text: String, delegate: CodeInputControlDelegate? = nil) {
        let nextTag = self.cursorPosition + 1
        
        guard text != "\n" else {
            delegate?.codeInputControlShouldReturn?(control: self)
            return
        }
        
        guard
            !text.isEmpty,
            nextTag <= self.itemsCount,
            let view = self.viewWithTag(nextTag) as? CodeInputItemView
        else {
            delegate?.codeInputControlDidFinish?(self, text: text)
            return
        }
        
        let shouldChange = delegate?.codeInputControl?(self, shouldChange: text) ?? true
        
        guard shouldChange else { return }
        
        view.text = text
        self.cursorPosition += 1

        delegate?.codeInputControl?(self, textDidChange: self.text)
    }
    
    private func deleteText(delegate: CodeInputControlDelegate? = nil) {
        guard self.cursorPosition > 0,
            let view = viewWithTag(self.cursorPosition) as? CodeInputItemView else {
                return
        }
        
        let shouldChange = delegate?.codeInputControl?(self, shouldChange: "") ?? true
        
        guard shouldChange else { return }
        
        view.text = ""
        self.cursorPosition -= 1
        
        delegate?.codeInputControl?(self, textDidChange: self.text)
    }

}

// MARK: - Layout

extension CodeInputControl {

    struct Layout {
        struct Parameters {
            var itemSize = CGSize(width: 44, height: 44)
            var minSpacing: CGFloat = 16
        }
        struct Frames {
            var spacing: CGFloat
            var digitViews: [CGRect]
        }
    }
    
    func calculateLayout(size: CGSize) -> Layout.Frames {
        let count = self.codeViews.count
        let itemSize = self.parameters.itemSize
        let minSpacing = self.parameters.minSpacing
        
        var spacing: CGFloat = 0
        
        if count > 1 {
            spacing = max((size.width - CGFloat(count) * itemSize.width) / (CGFloat(count) - 1), minSpacing)
        }
        
        var frames = [CGRect]()
        var offsetX: CGFloat = 0
        
        for _ in 0..<count {
            let frame = CGRect(x: offsetX, y: 0, width: itemSize.width, height: itemSize.height)
            offsetX += itemSize.width + spacing
            
            frames.append(frame)
        }
        
        return Layout.Frames(spacing: spacing, digitViews: frames)
    }

}
