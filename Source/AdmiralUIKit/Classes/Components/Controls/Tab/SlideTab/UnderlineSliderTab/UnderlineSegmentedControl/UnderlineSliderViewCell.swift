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
    var accesibilityId: String?
    
    init(
        isEnabled: Bool,
        isSelected: Bool,
        title: String?,
        scheme: UnderlineSliderScheme,
        accesibilityId: String? = nil
    ) {
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.title = title
        self.scheme = scheme
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
    
    var scheme = UnderlineSliderScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    
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
        let width = titleLabelWidth + 2 * LayoutGrid.module
        return CGSize(width: width,
                      height: LayoutGrid.quadrupleModule)
    }
    
    // MARK: - Internal Methods
    
    func configure(item: BaseUnderlineSegmentedItem) {
        guard let outlineSliderModel = item as? UnderlineSliderItem else { return }
        
        title = outlineSliderModel.title
        isEnabled = outlineSliderModel.isEnabled
        setSelected(isSelected: outlineSliderModel.isSelected)
        scheme = outlineSliderModel.scheme
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
        [titleLabel].forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: LayoutGrid.quadrupleModule)
        ])
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        updateScheme()
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
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
    }
    
}
