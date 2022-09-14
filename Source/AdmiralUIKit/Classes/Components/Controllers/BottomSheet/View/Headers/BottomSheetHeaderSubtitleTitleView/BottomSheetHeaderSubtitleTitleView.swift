//
//  BottomSheetHeaderSubtitleTitleView.swift
//  AdmiralUI
//
//  Created on 25.01.2021.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

public class BottomSheetHeaderSubtitleTitleView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    open weak var delegate: BottomSheetHeaderDelegate?
    public var scheme = BottomSheetHeaderSubtitleTitleViewScheme() {
        didSet { updateScheme() }
    }

    /// The title text.
    open var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The subtitle text.
    open var subtitleText: String? {
        get { return subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
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
        scheme = BottomSheetHeaderSubtitleTitleViewScheme(theme: theme)
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
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .left
    }
    
    private func setupButtons() {
        rightButtonItem.isHidden = false
        rightButtonItem.setImage(Asset.Service.Outline.closeOutline.image, for: [])
        rightButtonItem.addTarget(self, action: #selector(tapRightButtonItem(sender:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        [titleLabel,
         subtitleLabel,
         rightButtonItem].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.module * 6),
            subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule),
            
            trailingAnchor.constraint(equalTo: rightButtonItem.trailingAnchor, constant: LayoutGrid.doubleModule),
            rightButtonItem.widthAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            rightButtonItem.heightAnchor.constraint(equalToConstant: LayoutGrid.tripleModule),
            rightButtonItem.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.font = scheme.subtitleLabelFont.uiFont
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func tapRightButtonItem(sender: UIButton) {
        delegate?.didTapRightButtonItem(sender: sender)
    }
    
}
