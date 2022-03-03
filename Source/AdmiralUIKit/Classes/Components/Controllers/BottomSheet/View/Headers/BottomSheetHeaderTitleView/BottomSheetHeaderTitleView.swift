//
//  BottomSheetNavigationView.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public class BottomSheetHeaderTitleView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    open weak var delegate: BottomSheetHeaderDelegate?
    
    public var scheme = BottomSheetHeaderTitleViewScheme() {
        didSet { updateScheme() }
    }
    
    /// The font of title.
    open var titleFont: UIFont? {
        get { return titleLabel.font }
        set { titleLabel.font = newValue }
    }

    /// The title text.
    open var titleText: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The titleLabel text aligment.
    open var titleTextAligment: NSTextAlignment {
        get { return titleLabel.textAlignment }
        set { titleLabel.textAlignment = newValue }
    }
   
    /// The boolean value to sho/hide rightButtonItem.
    open var isRightButtonItemHidden: Bool {
        get { return rightButtonItem.isHidden }
        set {
            rightButtonItem.isHidden = newValue
            titleLabelTrailingContraint.constant = LayoutGrid.doubleModule
            layoutIfNeeded()
        }
    }
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let rightButtonItem = UIButton()
    private lazy var titleLabelTrailingContraint: NSLayoutConstraint = {
        return trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module * 6)
    }()
    
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
        scheme = BottomSheetHeaderTitleViewScheme(theme: theme)
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
        rightButtonItem.isHidden = false
        rightButtonItem.setImage(PrivateAsset.Custom.BottomSheet.close.image, for: [])
        rightButtonItem.addTarget(self, action: #selector(tapRightButtonItem(sender:)), for: .touchUpInside)
    }
    
    private func addSubviews() {
        [titleLabel, rightButtonItem].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabelTrailingContraint,
            
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
            font: scheme.font.uiFont,
            textStyle: scheme.font.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.textColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
    @objc private func tapRightButtonItem(sender: UIButton) {
        delegate?.didTapRightButtonItem(sender: sender)
    }
    
}
