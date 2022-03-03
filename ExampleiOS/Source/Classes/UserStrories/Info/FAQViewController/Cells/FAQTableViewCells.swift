//
//  FAQTableViewCells.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

// MARK: - ViewModel

class FAQTableViewCellViewModel: TableViewListItem {
    let title: String
    let subtitle: String
    let tappableRange: String?
    var isExpanded: Bool

    var reuseIdentifier: String {
        String(describing: FAQTableViewCells.self)
    }
    
    var didSelect: (() -> Void)?
    
    init(
        title: String,
        subtitle: String,
        isExpanded: Bool,
        tappableRange: String? = nil,
        didSelect: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.tappableRange = tappableRange
        self.isExpanded = isExpanded
        self.didSelect = didSelect
    }
}

final class FAQTableViewCells: UITableViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Public Properties
    
    var isExpanded: Bool = false {
        didSet {
            subtitleLabelHeightConstraint.isActive = !isExpanded
            subtitleLabelBottomConstraint.constant = isExpanded ? LayoutGrid.halfModule * 3 : 0
            subtitleLabelTopConstraint.constant = isExpanded ? LayoutGrid.halfModule * 9 : LayoutGrid.halfModule * 7
            disclosureImage.transform = isExpanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform(rotationAngle: CGFloat.zero)
        }
    }
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Private Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let disclosureImage = UIImageView()
    private lazy var subtitleLabelHeightConstraint: NSLayoutConstraint = {
        return subtitleLabel.heightAnchor.constraint(equalToConstant: 0)
    }()
    private lazy var subtitleLabelBottomConstraint: NSLayoutConstraint = {
        return contentView.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 3)
    }()
    private lazy var subtitleLabelTopConstraint: NSLayoutConstraint = {
        return subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 9)
    }()
    private var scheme = FAQTableViewCellCustomScheme() {
        didSet { updateScheme() }
    }
    private var tappableRange: String?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = FAQTableViewCellCustomScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupLabels()
        setupImages()
        addConstraints()
        setSelectionStyle()
    }

    private func addSubviews() {
        [titleLabel,
         subtitleLabel,
         disclosureImage].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
         })
    }
    
    private func setupImages() {
        disclosureImage.image = Asset.disclosureUp.image
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGrid.module * 3),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            disclosureImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.module),
            
            disclosureImage.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            disclosureImage.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 6),
            contentView.trailingAnchor.constraint(equalTo: disclosureImage.trailingAnchor, constant: LayoutGrid.doubleModule),
            disclosureImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            subtitleLabelTopConstraint,
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            subtitleLabelBottomConstraint
        ])
    }
    
    private func setSelectionStyle() {
        selectionStyle = .none
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
        
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleLabelFont.uiFont,
            textStyle: scheme.subtitleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
    }
    
    @objc private func tapLabel(gesture: UITapGestureRecognizer) {
        guard
            let tappableRange = tappableRange,
            let text = subtitleLabel.text else { return }
        
        let range = (text as NSString).range(of: tappableRange)
        
        if gesture.didTapAttributedTextInLabel(label: subtitleLabel, inRange: range) {
            didSelectEmail(path: tappableRange)
        }
    }
    
    private func didSelectEmail(path: String) {
        guard let url = URL(string: "mailto:\(path)") else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
}

// MARK: - TableViewListItemConfigurable

extension FAQTableViewCells: TableViewListItemConfigurable {
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? FAQTableViewCellViewModel else { return }
        
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        isExpanded = item.isExpanded
        self.tappableRange = item.tappableRange
        
        if let tappableRange = item.tappableRange {
            let range = (item.subtitle as NSString).range(of: tappableRange)
            let attributedString = NSMutableAttributedString(string: item.subtitle)
            attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: scheme.linkTextColor.uiColor,
                range: range)
            subtitleLabel.attributedText = attributedString
            subtitleLabel.isUserInteractionEnabled = true
            subtitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
        }
    }
    
}
