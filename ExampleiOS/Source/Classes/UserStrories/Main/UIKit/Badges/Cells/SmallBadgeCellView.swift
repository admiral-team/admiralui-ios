//
//  SmallBadgeCellView.swift
//  ExampleiOS
//
//  Created on 05.04.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SmallBadgeCellView<T>: UIView, AnyAppThemable, AccessibilitySupport where T: Badge {

    // MARK: - Public Properties

    var isEnabled: Bool = true {
        didSet {
            badgeView.isEnabled = isEnabled
        }
    }

    var scheme = BadgeCellViewCustomScheme() {
        didSet { updateScheme() }
    }

    // MARK: - AccessibilitySupport

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let badgeView: Badge
    private let contentView = UIView()
    private let imageView = UIImageView()

    private let disclosureImageView: UIImageView = {
        let disclosureImageView = UIImageView()
        disclosureImageView.image = UIImage(named: "disclosure")
        return disclosureImageView
    }()

    // MARK: - Initializer

    init(title: String, badgeView: T) {
        self.titleLabel.text = title
        self.badgeView = badgeView
        super.init(frame: .zero)

        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.width / 2
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        badgeView.apply(theme: theme)
        scheme = BadgeCellViewCustomScheme(theme: theme)
    }

    // MARK: - Private Methods

    private func commonInit() {
        addSubviews()
        configureLabel()
        setupConstraits()
        configureImageViews()
    }

    private func addSubviews() {
        [titleLabel, contentView, badgeView, disclosureImageView].addToSuperview(self)
        [imageView].addToSuperview(contentView)
    }

    private func configureImageViews() {
        imageView.image = Asset.Badges.bonus.image
    }

    private func configureLabel() {
        titleLabel.textAlignment = .left
    }

    private func setupConstraits() {
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: LayoutGrid.halfModule),
            badgeView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.module),

            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutGrid.doubleModule),

            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            contentView.widthAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),
            contentView.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 11),

            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24.0),
            imageView.heightAnchor.constraint(equalToConstant: 24.0),

            disclosureImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: disclosureImageView.trailingAnchor, constant: LayoutGrid.module),

            heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 16)
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
        backgroundColor = scheme.backgroundColor.uiColor
        titleLabel.textColor = scheme.textColor.uiColor
        contentView.backgroundColor = scheme.contentViewColor.uiColor
        imageView.tintColor = scheme.imageViewColor.uiColor
    }

    @objc private func stepperValueChanged(_ stepper: InputNumber) {
        badgeView.text = String(Int(stepper.value))
    }

}
