//
//  MapButtonCellView.swift
//  ExampleiOS
//
//  Created on 18.02.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class MapButtonCellView: UIView, AnyAppThemable, AccessibilitySupport {

    // MARK: - Public Properties

    var isEnabled: Bool = true {
        didSet {
            buttons.forEach({ $0.isEnabled = isEnabled })
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
        stackView.spacing = LayoutGrid.module * 5
        return stackView
    }()

    private(set) var buttons = [UIButton]()

    private var scheme = MapButtonCellScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Initializer

    init(buttons: [UIButton], titleText: String) {
        self.buttons = buttons
        titleLabel.text = titleText
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = MapButtonCellScheme(theme: theme)
        buttons.forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
    }

    // MARK: - Private Methods

    private func configureUI() {
        autoManage()

        addSubviews()
        configureConstraints()
        configureLabel()
        configureStackView()
    }

    private func addSubviews() {
        [titleLabel, scrollView].addToSuperview(self)
        [stackView].addToSuperview(scrollView)
    }

    private func configureLabel() {
        titleLabel.textAlignment = .left
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.halfModule * 7),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 5),

            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: LayoutGrid.doubleModule),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            scrollView.heightAnchor.constraint(equalToConstant: 70.0),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: LayoutGrid.doubleModule),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    private func configureStackView() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        buttons.forEach({ stackView.addArrangedSubview($0) })
        stackView.addArrangedSubview(UIView())
    }

    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }

    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory
        )
    }

    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }

}
