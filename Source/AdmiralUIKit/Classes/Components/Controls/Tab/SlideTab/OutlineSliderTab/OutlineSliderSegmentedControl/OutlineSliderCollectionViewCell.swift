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
    
    init(isEnabled: Bool, isSelected: Bool, title: String?, scheme: OutlineSliderScheme) {
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.title = title
        self.scheme = scheme
    }
}

class OutlineSliderCollectionViewCell: UICollectionViewCell, AccessibilitySupport {
    
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
    
    var scheme = OutlineSliderScheme() {
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
    
    func configure(model: BaseOutlineSliderItem) {
        guard let outlineSliderModel = model as? OutlineSliderItem else { return }
        
        title = outlineSliderModel.title
        isEnabled = outlineSliderModel.isEnabled
        setSelected(isSelected: outlineSliderModel.isSelected)
        scheme = outlineSliderModel.scheme
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
        [titleLabel].addToSuperview(self)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate(titleLabel.fillView(view: self))
    }
    
    private func configureUI() {
        layer.borderWidth = 2
        layer.cornerRadius = LayoutGrid.module
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
        layer.borderColor = scheme.borderColor.parameter(for: state)?.cgColor
    }
    
}

