//
//  CalendarHorizontalHeaderView.swift
//  AdmiralUIKit
//
//  Created on 10.11.2021.
//

import AdmiralTheme
import UIKit

protocol CalendarHorizontalHeaderViewDelegate: AnyObject {
    func calendarHorizontalHeaderTapLeft()
    func calendarHorizontalHeaderTapRight()
    func calendarHorizontalHeaderTapDate()
}

class CalendarHorizontalHeaderView: UIView, AnyAppThemable {
    
    // MARK: - Internal Properties
    
    weak var delegate: CalendarHorizontalHeaderViewDelegate?
    
    var scheme = CalendarHorizontalHeaderViewScheme() {
        didSet { updateScheme() }
    }
    
    var title: String? {
        didSet {
            buttonWithArrow.text = title
        }
    }
    
    var isArrowUp: Bool = true {
        didSet {
            changeStateArrowUp()
        }
    }
    
    // MARK: - Private Properties
    
    var buttonWithArrow = ButtonWithArrow()
    var leftImageButton = GhostButton()
    var rightImageButton = GhostButton()
    var choiceButton = GhostButton()
    
    // MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func apply(theme: AppTheme) {
        scheme = CalendarHorizontalHeaderViewScheme(theme: theme)
        leftImageButton.apply(theme: theme)
        rightImageButton.apply(theme: theme)
        choiceButton.apply(theme: theme)
    }

    // MARK: - Internal Methods

    func setAccessibilityIds(
        headerLeftButtonId: String,
        headerRightButtonId: String,
        headerChoiseButtonId: String,
        headerButtonWithArrowId: String
    ) {
        leftImageButton.accessibilityIdentifier = headerLeftButtonId
        rightImageButton.accessibilityIdentifier = headerRightButtonId
        buttonWithArrow.accessibilityIdentifier = headerChoiseButtonId
        choiceButton.accessibilityIdentifier = headerButtonWithArrowId
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: defaultTheme)
        
        addSubviews()
        setupConstraints()
        setButtons()
    }
    
    private func changeStateArrowUp() {
        buttonWithArrow.isArrowUp = isArrowUp
        choiceButton.isHidden = isArrowUp
        leftImageButton.isHidden = !isArrowUp
        rightImageButton.isHidden = !isArrowUp
    }
    
    private func setButtons() {
        leftImageButton.setImage(Asset.System.Outline.chevronLeftOutline.image, for: .normal)
        rightImageButton.setImage(Asset.System.Outline.chevronRightOutline.image, for: .normal)
        choiceButton.setTitle("Выбрать", for: .normal)
 
        leftImageButton.addTarget(self, action: #selector(tapLeftButton), for: .touchUpInside)
        rightImageButton.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
        buttonWithArrow.addTarget(self, action: #selector(tapDate), for: .touchUpInside)
        choiceButton.addTarget(self, action: #selector(tapChoice), for: .touchUpInside)
    }
    
    @objc private func tapLeftButton() {
        delegate?.calendarHorizontalHeaderTapLeft()
    }
    
    @objc private func tapRightButton() {
        delegate?.calendarHorizontalHeaderTapRight()
    }
    
    @objc private func tapDate() {
        delegate?.calendarHorizontalHeaderTapDate()
    }
    
    @objc private func tapChoice() {
        delegate?.calendarHorizontalHeaderTapDate()
    }
    
    
    private func addSubviews() {
        [buttonWithArrow, leftImageButton, rightImageButton, choiceButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule),
            
            buttonWithArrow.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonWithArrow.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            choiceButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            choiceButton.leadingAnchor.constraint(
                greaterThanOrEqualTo: buttonWithArrow.trailingAnchor,
                constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: choiceButton.trailingAnchor),
            
            rightAnchor.constraint(equalTo: rightImageButton.rightAnchor),
            rightImageButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightImageButton.leadingAnchor.constraint(equalTo: leftImageButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            rightImageButton.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            rightImageButton.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            
            leftImageButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftImageButton.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            leftImageButton.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            leftImageButton.leadingAnchor.constraint(
                greaterThanOrEqualTo: buttonWithArrow.trailingAnchor,
                constant: LayoutGrid.doubleModule)
        ])
    }
    
    private func updateScheme() {
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        buttonWithArrow.scheme = scheme.buttonWithArrowScheme
        choiceButton.scheme = scheme.ghostButtonCustomScheme
        rightImageButton.scheme = scheme.ghostButtonCustomScheme
        leftImageButton.scheme = scheme.ghostButtonCustomScheme
    }
    
}
