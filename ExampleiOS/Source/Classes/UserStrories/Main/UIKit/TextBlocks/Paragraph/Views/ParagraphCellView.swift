//
//  ParagraphView.swift
//  ExampleiOS
//
//  Created on 19.07.2022.
//


import AdmiralUIKit
import AdmiralTheme
import UIKit

class ParagraphCellView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Public Properties
    
    var scheme = TextBlocksCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private var paragraph = Paragraph()
    private var heightParagraph: CGFloat = LayoutGrid.module * 5
    
    // MARK: - Initializer

    init(paragraph: Paragraph, titleText: String? = nil, heightParagraph: CGFloat = LayoutGrid.module * 5) {
        super.init(frame: .zero)
        titleLabel.text = titleText
        self.paragraph = paragraph
        self.heightParagraph = heightParagraph
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInformerState(isEnabled: Bool) {
        paragraph.isEnabled = isEnabled
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = TextBlocksCustomScheme(theme: theme)
        paragraph.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureConstraints()
        configureLabel()
    }
    
    private func addSubviews() {
        [titleLabel,
         paragraph].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
    
    private func configureLabel() {
        titleLabel.textAlignment = .left
    }
    
    private func configureConstraints() {
        if titleLabel.text == nil {
            NSLayoutConstraint.activate([
                paragraph.topAnchor.constraint(equalTo: topAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                paragraph.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
                trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
                titleLabel.heightAnchor.constraint(equalToConstant: 20.0)
            ])
        }
        NSLayoutConstraint.activate([
            paragraph.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: paragraph.trailingAnchor, constant: LayoutGrid.doubleModule),
            paragraph.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            bottomAnchor.constraint(equalTo: paragraph.bottomAnchor, constant: LayoutGrid.doubleModule),
            paragraph.heightAnchor.constraint(equalToConstant: heightParagraph)
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
        titleLabel.textColor = scheme.titleColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }
    
}
