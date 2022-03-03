//
//  IconCell.swift
//  Example iOS
//
//  Created on 13.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

struct IconCellViewModel {
    let image: UIImage
    let title: String
}

final class IconCell: UICollectionViewCell, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - Private Properties

    var imageView = UIImageView()
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    private let titleLabel = UILabel()
    private var scheme = IconCellCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = IconCellCustomScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func configure(viewModel: IconCellViewModel) {
        imageView.image = viewModel.image
        let title = viewModel.title
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setImageView()
        setupLabels()
        configureConstraints()
    }
    
    private func addSubviews() {
        [imageView,
         titleLabel].forEach({
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func setImageView() {
        imageView.contentMode = .center
    }
    
    private func setupLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            imageView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 7),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: LayoutGrid.halfModule),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelLabelFont.uiFont,
            textStyle: scheme.titleLabelLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        imageView.tintColor = scheme.imageViewTintColor.uiColor
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        contentView.backgroundColor = scheme.backgroundColor.uiColor
    }

}
