//
//  TimePicker.swift
//  AdmiralUI
//
//  Created on 15.03.2021.
//

import UIKit
import AdmiralTheme

public protocol TimePickerDelegate: AnyObject {
    func timePickerDateDidChange(timePicker: TimePicker, currentTime: Date)
}

public final class TimePicker: UIControl, AnyAppThemable, UIKeyInput, UITextInputTraits {
    
    // MARK: - Override states
    
    public override var isEnabled: Bool {
        didSet {
            isActive = isEnabled ? .normal : .disabled
        }
    }

    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        isActive = .selected
        return true
    }
    
    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        isActive = .normal
        return true
    }
    
    /// IntrinsicContentSize of control
    public override var intrinsicContentSize: CGSize {
        return Constants.size
    }
    
    // MARK: - Public Properties
    
    internal var scheme = TimePickerCustomTheme() {
        didSet { updateScheme() }
    }
    
    /// Current time of TimePicker
    public var currentTime: Date = Date() {
        didSet { setDate() }
    }
    
    /// Display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
    public var minuteInterval: Int? {
        didSet { rightTimeView.interval = minuteInterval }
    }
    
    /// Specify if timepicker is editable
    public var isEditable: Bool = true
    
    /// TimePickerDelegate
    public weak var delegate: TimePickerDelegate?
    
    // MARK: - UIKeyInput Properties
    
    public var hasText: Bool {
        switch timePickerEditingSide {
        case .none:
            guard
                let leftLabelText = leftLabelText,
                let rightLabelText = rightLabelText else { return false }
            
            let text = leftLabelText + rightLabelText
            return !text.isEmpty
        case .left:
            guard let leftLabelText = leftLabelText else { return false }
            
            return !leftLabelText.isEmpty
        case .right:
            guard let rightLabelText = rightLabelText else { return false }
            
            return !rightLabelText.isEmpty
        }
    }

    // MARK: - UITextInputTraits Properties
    
    public var keyboardType: UIKeyboardType = .decimalPad
    public override var canBecomeFirstResponder: Bool {
        return isEditable
    }
    
    // MARK: - Private Propeties
    
    private let leftTimeView = TimePickerWheelView()
    private let rightTimeView = TimePickerWheelView()
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    private let separatorLabel = UILabel()
    private let formatter = TimeFormatter()
    private var allTimeText: String = ""
    private var isActive: UIControl.State = .normal {
        didSet {
            if isActive == .normal {
                timePickerEditingSide = .none
                timePickerEditingMode = .scroll
                timePickerWheelEditingMode = .scroll
                updateCurrentTime()
                delegate?.timePickerDateDidChange(timePicker: self, currentTime: currentTime)
            }
            updateUI()
        }
    }
    
    private enum Constants {
        static let separator: String = ":"
        static let cornerRadius: CGFloat = LayoutGrid.module
        static let borderWidth: CGFloat = LayoutGrid.halfModule / 2
        static let textOffset: CGFloat = -LayoutGrid.halfModule / 2
        static let itemHeight: CGFloat = LayoutGrid.halfModule * 5
        static let size: CGSize = CGSize(width: 70.0, height: 34.0)
        static let doubleHourFormat: String = "HH"
        static let doubleHourAMPMFormat: String = "h"
        static let doubleMinuteFormat: String = "mm"
    }
    
    private enum TimeInputLabelType {
        case hours
        case minutes
    }
    
    private var leftLabelText: String? {
        get { return leftLabel.text }
        set {
            leftLabel.text = newValue
            if formatter.usesAMPM() {
                leftTimeView.currentNumber = (leftLabelText?.toInt() ?? 1)
            } else {
                leftTimeView.currentNumber = leftLabelText?.toInt() ?? 0
            }
            setNeedsLayout()
        }
    }
    
    private var rightLabelText: String? {
        get { return rightLabel.text }
        set {
            rightLabel.text = newValue
            rightTimeView.currentNumber = rightLabelText?.toInt() ?? 0
            setNeedsLayout()
        }
    }
    
    private var timePickerEditingSide: TimePickerEditingSide = .none {
        didSet { updateStates() }
    }
    
    private var timePickerEditingMode: TimePickerEditingMode = .scroll {
        didSet { updateStates() }
    }
    
    private var timePickerWheelEditingMode: TimePickerWheelEditingMode = .scroll {
        didSet { updateStates() }
    }
    
    private var states: TimePickerStates = .defaultState {
        didSet { updateUI() }
    }
    
    private let stateMachine = TimePickerStateMachine()
    private var isShouldClearLabel: Bool = true
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        semanticContentAttribute = .forceRightToLeft
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
        leftLabel.layoutSubviews()
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = TimePickerCustomTheme(theme: theme)
    }
    
    // MARK: - UIKeyInput Methods
    
    public func insertText(_ text: String) {
        timePickerWheelEditingMode = .textEdit

        if states == .leftEditingTextFieldTextEdit {
            if isShouldClearLabel {
                leftLabelText = ""
                isShouldClearLabel = false
            }
            leftLabelText = formatter.prepareTime(
                currentText: leftLabelText ?? "",
                newDigit: text,
                type: .hours).0
            leftTimeView.currentNumber = leftLabelText?.toInt() ?? 0
        } else if states == .rightEditingTextFieldTextEdit {
            if isShouldClearLabel {
                rightLabelText = ""
                isShouldClearLabel = false
            }
            
            rightLabelText = formatter.prepareTime(
                currentText: rightLabelText ?? "",
                newDigit: text,
                type: .min).1
            rightTimeView.currentNumber = rightLabelText?.toInt() ?? 0
        } else if states == .allEditingTextField {
            if isShouldClearLabel {
                leftLabelText = ""
                rightLabelText = ""
                allTimeText = ""
                isShouldClearLabel = false
            }

            let time = formatter.prepareTime(
                currentText: allTimeText,
                newDigit: text,
                type: .all)
            
            allTimeText = time.0 + time.1
            
            rightLabelText = time.1
            rightTimeView.currentNumber = self.rightLabelText?.toInt() ?? 0
            leftLabelText = time.0
            leftTimeView.currentNumber = leftLabelText?.toInt() ?? 0
        }
    }
    
    public func deleteBackward() {
        if timePickerWheelEditingMode == .scroll {
            switch timePickerEditingSide {
            case .none:
                leftLabelText?.removeAll()
                rightLabelText?.removeAll()
                allTimeText.removeAll()
            case .left:
                leftLabelText?.removeAll()
            case .right:
                rightLabelText?.removeAll()
            }
        }
        
        timePickerWheelEditingMode = .textEdit
        
        switch timePickerEditingSide {
        case .none:
            guard hasText else { return }
            
            if !(leftLabelText ?? "").isEmpty {
                leftLabelText?.removeLast()
            } else {
                rightLabelText?.removeLast()
            }
            allTimeText.removeLast()
        case .left:
            guard hasText else { return }
            
            leftLabelText?.removeLast()
        case .right:
            guard hasText else { return }
            
            rightLabelText?.removeLast()
        }
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        
        separatorLabel.text = Constants.separator
        separatorLabel.textAlignment = .center
        
        leftLabel.textAlignment = .right
        
        leftTimeView.textAlignment = .right
        leftTimeView.itemHeight = Constants.itemHeight
        leftTimeView.isCollectionHidden = true
        
        rightLabel.textAlignment = .right
        
        rightTimeView.textAlignment = .right
        rightTimeView.itemHeight = Constants.itemHeight
        rightTimeView.isCollectionHidden = true
        
        leftTimeView.maxNumber = formatter.usesAMPM() ? 12 : 23
        leftTimeView.minNumber = formatter.usesAMPM() ? 1 : 0
        rightTimeView.maxNumber = 59
        
        leftTimeView.delegate = self
        rightTimeView.delegate = self
    }
    
    private func addSubviews() {
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(separatorLabel)
        addSubview(leftTimeView)
        addSubview(rightTimeView)
        
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    private func configureConstraints() {
        separatorLabel.sizeToFit()
        
        let itemWidth = (max(0, frame.width - separatorLabel.frame.width) / 2) - LayoutGrid.halfModule
        
        leftTimeView.frame.origin.x = LayoutGrid.halfModule
        leftTimeView.frame.origin.y = 0
        leftTimeView.frame.size.height = frame.height
        leftTimeView.frame.size.width = itemWidth
        
        separatorLabel.frame.origin.x = leftTimeView.frame.maxX
        separatorLabel.frame.origin.y = (frame.height - separatorLabel.frame.height) / 2 + Constants.textOffset
        
        rightTimeView.frame.origin.x = separatorLabel.frame.maxX
        rightTimeView.frame.origin.y = 0
        rightTimeView.frame.size.height = frame.height
        rightTimeView.frame.size.width = itemWidth
        
        leftLabel.frame = leftTimeView.frame
        rightLabel.frame = rightTimeView.frame
    }
    
    private func updateScheme() {
        let font = UIFont.monospacedDigitSystemFont(ofSize: 22, weight: .regular)
        backgroundColor = scheme.backgroundColor.uiColor
        layer.borderColor = scheme.borderColor.parameter(for: isActive)?.cgColor
        rightTimeView.textColor = scheme.wheelTextColor.parameter(for: isActive)?.uiColor ?? .white
        rightTimeView.font = font
        separatorLabel.font = font

        rightLabel.textColor = scheme.rightTextColor.parameter(for: states, controlState: isActive)?.uiColor ?? .white
        rightLabel.font = font
        
        leftTimeView.textColor = scheme.wheelTextColor.parameter(for: isActive)?.uiColor ?? .white
        leftTimeView.font = font
        
        separatorLabel.textColor = scheme.separatorColor.parameter(for: states, controlState: isActive)?.uiColor
        
        leftLabel.textColor = scheme.leftTextColor.parameter(for: states, controlState: isActive)?.uiColor ?? .white
        leftLabel.font = font
    }
    
    private func currentHours() -> Date {
        let dateFormatter = DateFormatter()
        if formatter.usesAMPM() {
            dateFormatter.dateFormat = Constants.doubleHourAMPMFormat
        } else {
            dateFormatter.dateFormat = Constants.doubleHourFormat
        }
        
        let hours = Int(leftLabelText ?? "") ?? 0
        
        if let min = Int(rightLabelText ?? "") {
            if min > 59 {
                leftLabelText = String(hours + 1)
                rightLabelText = String(min - 60)
            }
        }
        
        return dateFormatter.date(from: leftLabelText ?? "") ?? Date().zeroDate
    }
    
    private func currentMinutes() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.doubleMinuteFormat
        return dateFormatter.date(from: rightLabel.text ?? "") ?? Date().zeroDate
    }
    
    private func updateCurrentTime() {
        currentTime = currentTime.combineHoursAndMinutes(
            hours: currentHours(),
            minutes: currentMinutes())
    }
    
    private func setDate() {
        var hours = ""
        if formatter.usesAMPM() {
            hours = currentTime.dateToString(dateFormat: "h")
        } else {
            hours = currentTime.dateToString(dateFormat: "HH")
        }
        
        leftLabelText = hours
        
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: currentTime)
        rightLabelText = String(format: "%02d", minutes)
        rightTimeView.currentNumber = minutes
    }
    
    private func updateUI() {
        switch states {
        case .defaultState:
            leftTimeView.isCollectionHidden = true
            rightTimeView.isCollectionHidden = true
            leftLabel.isHidden = false
            rightLabel.isHidden = false
            updateCurrentTime()
        case .allEditingScroll:
            leftTimeView.isCollectionHidden = false
            rightTimeView.isCollectionHidden = false
            leftLabel.isHidden = true
            rightLabel.isHidden = true
            isShouldClearLabel = true
        case .allEdititngScrollRightEditing:
            leftTimeView.isCollectionHidden = true
            rightTimeView.isCollectionHidden = false
            leftLabel.isHidden = false
            rightLabel.isHidden = true
        case .allEditingScrollLeftEditing:
            leftTimeView.isCollectionHidden = false
            rightTimeView.isCollectionHidden = true
            leftLabel.isHidden = true
            rightLabel.isHidden = false
        case .allEditingTextField, .leftEditingTextFieldTextEdit, .rightEditingTextFieldTextEdit:
            leftTimeView.isCollectionHidden = true
            rightTimeView.isCollectionHidden = true
            leftLabel.isHidden = false
            rightLabel.isHidden = false
        case .scrollEditing:
            leftTimeView.isCollectionHidden = false
            rightTimeView.isCollectionHidden = false
            leftLabel.isHidden = true
            rightLabel.isHidden = true
        case .scrollLeftEditing:
            leftTimeView.isCollectionHidden = false
            rightTimeView.isCollectionHidden = true
            leftLabel.isHidden = true
            rightLabel.isHidden = false
        case .scrollRightEditing:
            leftTimeView.isCollectionHidden = true
            rightTimeView.isCollectionHidden = false
            leftLabel.isHidden = false
            rightLabel.isHidden = true
        case .leftEditingTextFieldScroll:
            leftTimeView.isCollectionHidden = false
            rightTimeView.isCollectionHidden = true
            leftLabel.isHidden = true
            rightLabel.isHidden = false
            isShouldClearLabel = true
        case .rightEditingTextFieldTextScroll:
            leftTimeView.isCollectionHidden = true
            rightTimeView.isCollectionHidden = false
            leftLabel.isHidden = false
            rightLabel.isHidden = true
            isShouldClearLabel = true
        }
        updateScheme()
    }
    
    private func updateStates() {
        states = stateMachine.state.parameter(
            timePickerEditingSide: timePickerEditingSide,
            timePickerEditingMode: timePickerEditingMode,
            timePickerWheelEditingMode: timePickerWheelEditingMode,
            isSelected: isActive == .selected ? true : false) ?? .defaultState
    }

}

// MARK: - TimePickerWheelViewDelegate

extension TimePicker: TimePickerWheelViewDelegate {
    
    func timePickerWheelViewDidTap(_ view: TimePickerWheelView) {
        guard isEditable else { return }
        
        let _ = becomeFirstResponder()
        
        if (view == leftTimeView && timePickerEditingSide == .right) || (view == rightTimeView && timePickerEditingSide == .left) {
            timePickerEditingMode = .sides
            timePickerWheelEditingMode = .scroll
        } else if timePickerWheelEditingMode == .textEdit && timePickerEditingMode == .all {
            timePickerEditingSide = .none
            timePickerWheelEditingMode = .scroll
        } else {
            timePickerEditingMode = timePickerEditingMode == .all ? .sides : .all
            if timePickerEditingMode == .all {
                timePickerEditingSide = .none
            }
            timePickerWheelEditingMode = .scroll
        }
        
        if timePickerEditingMode == .sides {
            timePickerEditingSide = view == leftTimeView ? .left : .right
        }
    }
    
    func timePickerWheelViewViewWillBeginDragging(_ view: TimePickerWheelView) {
        isActive = .selected
        timePickerWheelEditingMode = .scroll
        
        if view == leftTimeView {
            timePickerEditingSide = .left
        } else if view == rightTimeView {
            timePickerEditingSide = .right
        }
    }
    
    func timePickerWheelCurrentNumberDidChange(_ view: TimePickerWheelView) {
        isActive = .selected
        if view == leftTimeView {
            leftLabelText = String(format: "%02d", view.currentNumber)
        } else if view == rightTimeView {
            rightLabelText = String(format: "%02d", view.currentNumber)
        }
        
        if states == .scrollRightEditing || states == .scrollLeftEditing {
            isActive = .normal
        } else if states == .allEdititngScrollRightEditing || states == .allEditingScrollLeftEditing {
            timePickerEditingSide = .none
        }
        
        updateCurrentTime()
    }
    
    func timePickerWheelViewFormattedText(_ view: TimePickerWheelView, for number: Int) -> String? {
        if view == leftTimeView {
            if formatter.usesAMPM() {
                return String(number)
            } else {
                return String(format: "%02d", number)
            }
        } else if view == rightTimeView {
            let maxDigitCount = "\(view.maxNumber)".count
            return String(format: "%0\(maxDigitCount)d", number)
        } else {
            return nil
        }
    }
    
}
