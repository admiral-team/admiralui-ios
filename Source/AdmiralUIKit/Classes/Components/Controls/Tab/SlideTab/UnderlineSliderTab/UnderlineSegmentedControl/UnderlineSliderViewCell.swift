//
//  UnderlineSliderViewCell.swift
//  AdmiralUIKit
//
//  Created on 06.04.2021.
//

import UIKit
import AdmiralTheme

class UnderlineSliderItem: BaseUnderlineSegmentedItem {
    var isEnabled: Bool
    var isSelected: Bool
    var title: String?
    var scheme: UnderlineSliderScheme
    var badgeStyle: BadgeStyle?
    var accesibilityId: String?
    
    init(
        isEnabled: Bool,
        isSelected: Bool,
        title: String?,
        scheme: UnderlineSliderScheme,
        badgeStyle: BadgeStyle? = nil,
        accesibilityId: String? = nil
    ) {
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.title = title
        self.scheme = scheme
        self.badgeStyle = badgeStyle
        self.accesibilityId = accesibilityId
    }
}

class UnderlineSliderViewCell: UICollectionViewCell, AccessibilitySupport {
    
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
    
    var scheme = UnderlineSliderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - AnyAppTheamable

    open func apply(theme: AppTheme) {
        badge.apply(theme: theme)
        scheme = UnderlineSliderScheme(theme: theme)
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

        return CGSize(width: titleLabelWidth + LayoutGrid.doubleModule * 3, height: LayoutGrid.quadrupleModule)
    }
    
    // MARK: - Internal Methods
    
    func configure(item: BaseUnderlineSegmentedItem) {
        guard let outlineSliderModel = item as? UnderlineSliderItem else { return }
        
        title = outlineSliderModel.title
        isEnabled = outlineSliderModel.isEnabled
        setSelected(isSelected: outlineSliderModel.isSelected)
        scheme = outlineSliderModel.scheme
        style = outlineSliderModel.badgeStyle
        accessibilityIdentifier = outlineSliderModel.accesibilityId
    }
    
    // MARK: - Private Methods

    private func commonInit() {
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
        [titleLabel, badge].forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            badge.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),
            badge.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule)
        ])
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        badge.text = nil
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
        badge.scheme = scheme.badgeScheme
    }
    
}
