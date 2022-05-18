//
//  OutlineSliderCollectionViewCell.swift
//  AdmiralUIKit
//
//  Created on 06.04.2021.
//

import UIKit
import AdmiralTheme

class OutlineSliderItem: BaseOutlineSliderItem {
    var isEnabled: Bool
    var isSelected: Bool
    var title: String?
    var scheme: OutlineSliderScheme
    var badgeStyle: BadgeStyle?
    
    init(isEnabled: Bool, isSelected: Bool, title: String?, scheme: OutlineSliderScheme, badgeStyle: BadgeStyle? = nil) {
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.title = title
        self.scheme = scheme
        self.badgeStyle = badgeStyle
    }
}

class OutlineSliderCollectionViewCell: UICollectionViewCell, AnyAppThemable, AccessibilitySupport {

    // MARK: - Constants

    private enum Constants {
        static let resizedSpacing: CGFloat = 48
    }
    
    // MARK: - Internal Properties
    
    var state: UIControl.State = .normal {
        didSet { updateScheme() }
    }
    
    var isEnabled: Bool = true {
        didSet {
            state = isEnabled ? .normal : .disabled
        }
    }

    var title: String? {
        didSet { titleLabel.text = title }
    }

    var style: BadgeStyle? {
        didSet {
            guard let style = style else { return }
            badge.style = style
            updateScheme()
        }
    }
    
    var scheme = OutlineSliderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - AnyAppTheamable

    open func apply(theme: AppTheme) {
        badge.apply(theme: theme)
        scheme = OutlineSliderScheme(theme: theme)
    }

    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let badge = Badge()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        let titleLabelWidth = titleLabel.intrinsicContentSize.width
        
        guard let _ = style else {
            return CGSize(width: titleLabelWidth + 2 * LayoutGrid.module, height: LayoutGrid.quadrupleModule)
        }

        return CGSize(width: titleLabelWidth + Constants.resizedSpacing, height: LayoutGrid.quadrupleModule)
    }

    // MARK: - Internal Methods
    
    func configure(model: BaseOutlineSliderItem) {
        guard let outlineSliderModel = model as? OutlineSliderItem else { return }
        
        title = outlineSliderModel.title
        isEnabled = outlineSliderModel.isEnabled
        setSelected(isSelected: outlineSliderModel.isSelected)
        scheme = outlineSliderModel.scheme
        style = outlineSliderModel.badgeStyle
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        apply(theme: defaultTheme)
        configureUI()
        addSubviews()
        configureLayout()
    }
    
    private func setSelected(isSelected: Bool) {
        if isSelected {
            state.insert(.selected)
        } else {
            state.remove(.selected)
        }
    }
    
    private func addSubviews() {
        [titleLabel, badge].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate(titleLabel.fillView(view: self))
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            trailingAnchor.constraint(equalTo: badge.trailingAnchor, constant: LayoutGrid.module)
        ])
    }
    
    private func configureUI() {
        layer.borderWidth = LayoutGrid.halfModule / 2
        layer.cornerRadius = LayoutGrid.module
        badge.text = nil
        titleLabel.textAlignment = .center
        updateScheme()
    }

    private func updateUI() {
        badge.isHidden = style == nil
        badge.isEnabled = state != .disabled
    }

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
        updateUI()
    }
    
    private func updateSchemeFonts() {
        if let font = scheme.itemScheme.titleFont.parameter(for: state) {
            titleLabel.setDynamicFont(
                font: font.uiFont,
                textStyle: font.textStyle,
                adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        }
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.itemScheme.titleColor.parameter(for: state)?.uiColor
        layer.borderColor = scheme.borderColor.parameter(for: state)?.cgColor
        badge.scheme = scheme.badgeScheme
    }
    
}

