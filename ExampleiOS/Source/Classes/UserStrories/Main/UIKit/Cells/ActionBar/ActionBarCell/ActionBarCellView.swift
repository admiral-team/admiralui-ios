//
//  ActionBarCellView.swift
//  ExampleiOS
//
//  Created by Борисов Кирилл Анатольевич on 23.05.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class ActionBarCellView: UIView, AnyAppThemable, AccessibilitySupport {

    // MARK: - AccessibilitySupport

    var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }

    // MARK: - Public Properties

    var isEnabled: Bool = true {
        didSet {
            actionBars.forEach({ $0.isEnabled = isEnabled })
        }
    }

    var scheme = LinksCellViewCustomScheme() {
        didSet { updateScheme() }
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = LayoutGrid.halfModule * 3
        return stackView
    }()

    private(set) var actionBars = [ActionCellView<ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>>]()

    // MARK: - Initializer

    init(
        actionBars: [ActionCellView<ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>>],
        titleText: String
    ) {
        self.actionBars = actionBars
        super.init(frame: .zero)

        configureUI()

        titleLabel.text = titleText
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        actionBars.forEach({ stackView.addArrangedSubview($0) })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        scheme = LinksCellViewCustomScheme(theme: theme)
        actionBars.forEach({ $0.apply(theme: theme) })
    }

    // MARK: - Private Methods

    private func configureUI() {
        autoManage()

        addSubviews()
        configureConstraints()
        configureLabel()
    }

    private func addSubviews() {
        [titleLabel, stackView].addToSuperview(self)
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

            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: LayoutGrid.doubleModule)
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
        stackView.backgroundColor = scheme.backgroundColor.uiColor
        backgroundColor = scheme.backgroundColor.uiColor
    }

}
