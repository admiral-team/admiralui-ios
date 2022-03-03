//
//  TagCellView.swift
//  ExampleiOS
//
//  Created on 03.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TagCellView: UIView, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            tagViews.forEach({ $0.isEnabled = isEnabled })
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = LayoutGrid.halfModule * 3
        return stackView
    }()
    private(set) var tagViews = [TagControl]()
    private var scheme = TagCellViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(tagViews: [TagControl<UIView, UIView>], titleText: String) {
        self.tagViews = tagViews
        super.init(frame: .zero)
        
        configureUI()
        
        titleLabel.text = titleText
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        tagViews.forEach({ stackView.addArrangedSubview($0) })
        stackView.addArrangedSubview(UIView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = TagCellViewCustomScheme(theme: theme)
        tagViews.forEach({ $0.apply(theme: theme) })
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
         scrollView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
        
        [stackView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        })
    }
    
    private func configureLabel() {
        titleLabel.textAlignment = .left
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: LayoutGrid.doubleModule),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            scrollView.heightAnchor.constraint(equalToConstant: 36.0),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: LayoutGrid.doubleModule),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
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
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }

}
