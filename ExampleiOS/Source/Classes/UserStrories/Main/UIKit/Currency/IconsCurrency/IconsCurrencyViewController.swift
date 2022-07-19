//
//  IconsCurrencyViewController.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class IconsCurrencyViewController: UIViewController, AnyAppThemable {

    // MARK: - Private Properties

    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private let viewModel = IconsCurrencyViewModel()

    private var isThemeSwitchViewHidden: Bool {
        get { themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    private lazy var cell = configureTitleCell()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = .zero
        stackView.alignment = .fill
        return stackView
    }()

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        stackView.arrangedSubviews.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
        cell.apply(theme: theme)
        themeSwitchView.apply(theme: theme)
    }

    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }

    // MARK: - Private Methods

    private func configureUI() {
        isThemeSwitchViewHidden = false
    }

    private func addSubviews() {
        [stackView, cell].addToSuperview(view)
    }

    private func configureTitleCell() -> ListCell<ListCellEmpty, TitleWithArrowListView, ButtonListView> {
        let subtitleListView = TitleWithArrowListView()
        subtitleListView.title = viewModel.title
        let buttonListView = ButtonListView()
        buttonListView.title = viewModel.buttonTitle
        return ListCell(centerView: subtitleListView, tralingView: buttonListView)
    }

    private func configureHeader() {
        let header = CurrencyHeaderView()
        header.sellText = viewModel.headerItem.sellText
        header.buyText = viewModel.headerItem.buyText
        header.isTextSpacingEnabled = viewModel.headerItem.isTextSpacingEnabled
        stackView.addArrangedSubview(header)
    }

    private func configureCurrency() {
        viewModel.items.forEach {
            let row = CurrencyView()
            row.image = $0.image
            row.buyText = $0.buyText
            row.currencyText = $0.currencyText
            row.sellText = $0.sellText
            row.image = $0.image
            row.buyCellType = $0.buyCellType
            row.sellCellType = $0.sellCellType
            stackView.addArrangedSubview(row)
        }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            cell.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.quadrupleModule),

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: LayoutGrid.doubleModule),
            stackView.topAnchor.constraint(equalTo: cell.bottomAnchor, constant: LayoutGrid.halfModule * 3)
        ])
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        configureHeader()
        configureCurrency()
        configureUI()
        apply(theme: Appearance.shared.theme)
    }

}
