//
//  BottomSheetBottomView.swift
//  ExampleiOS
//
//  Created on 21.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol BottomSheetBottomViewDelegate: AnyObject {
    func didTapLeftButton()
    func didTapRightButton()
}

final class BottomSheetBottomView: UIView, AppThemeable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    weak var delegate: BottomSheetBottomViewDelegate?
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let leftButton = GhostButton()
    private let rightButton = GhostButton()
    private var scheme = BottomSheetBottomViewCustomScheme() {
        didSet { updateScheme() }
    }
    
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
    
    // MARK: - AppThemeable
    
    func apply(theme: AppTheme) {
        leftButton.apply(theme: theme)
        rightButton.apply(theme: theme)
        scheme = BottomSheetBottomViewCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        setupLabels()
        setupButtons()
        addSubviews()
        configureConstraints()
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    private func setupButtons() {
        leftButton.setTitle("Выбрать все карты", for: [])
        leftButton.contentHorizontalAlignment = .left
        leftButton.accessibilityIdentifier = "SelectAllCards"
        leftButton.addTarget(self, action: #selector(tapLeftButton), for: .touchUpInside)
        rightButton.setTitle("Готово", for: [])
        rightButton.contentHorizontalAlignment = .right
        rightButton.accessibilityIdentifier = "Done"
        rightButton.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        [contentView].addToSuperview(self)
        
        [titleLabel,
         leftButton,
         rightButton].addToSuperview(contentView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.module * 2),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.doubleModule),
            contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: LayoutGrid.module * 2),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 8),
            
            leftButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.module * 2),
            contentView.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: LayoutGrid.doubleModule),
            leftButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6),
            leftButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 25),
            
            contentView.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor, constant: LayoutGrid.module * 2),
            contentView.bottomAnchor.constraint(equalTo: rightButton.bottomAnchor, constant: LayoutGrid.doubleModule),
            rightButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6),
            rightButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 15)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleFont.uiFont,
            textStyle: scheme.titleFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.textColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func tapLeftButton() {
        delegate?.didTapLeftButton()
    }
    
    @objc private func tapRightButton() {
        delegate?.didTapRightButton()
    }
    
}
