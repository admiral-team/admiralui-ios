//
//  BottomSheetHeaderSmallTitleView.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import UIKit
import AdmiralTheme

public class BottomSheetHeaderSmallTitleView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    open weak var delegate: BottomSheetHeaderDelegate?
    public var scheme = BottomSheetHeaderSmallTitleScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    /// The title text.
    open var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The cancel button  text.
    open var rightButtonText: String? {
        get { return rightButtonItem.currentTitle }
        set { rightButtonItem.setTitle(newValue, for: []) }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let rightButtonItem = UIButton()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    convenience public init() {
        self.init(frame: CGRect())
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Returns an object initialized from data in a given unarchiver.
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AppTheamable
    
    open func apply(theme: AppTheme) {
        scheme = BottomSheetHeaderSmallTitleScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        configureUI()
    }
    
    private func configureUI() {
        apply(theme: defaultTheme)
        
        setupLabels()
        addSubviews()
        setupButtons()
        configureConstraints()
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
    }
    
    private func setupButtons() {
        rightButtonItem.setTitle("Отмена", for: [])
        rightButtonItem.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButtonItem.titleLabel?.lineBreakMode = .byClipping
        rightButtonItem.addTarget(self, action: #selector(tapRightButtonItem(sender:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        [rightButtonItem,
         titleLabel].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            rightButtonItem.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: rightButtonItem.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle)
        rightButtonItem.titleLabel?.setDynamicFont(
            font: scheme.rightButtonFont.uiFont,
            textStyle: scheme.rightButtonFont.textStyle)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleTextColor.uiColor
        rightButtonItem.setTitleColor(scheme.rightButtonTextColor.uiColor, for: .normal)
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func tapRightButtonItem(sender: UIButton) {
        delegate?.didTapRightButtonItem(sender: sender)
    }
    
}
