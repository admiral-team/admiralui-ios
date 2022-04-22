//
//  TextOperationViewController.swift
//  ExampleiOS
//
//  Created on 14.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

 final class TextOperationViewController: UIViewController, AnyAppThemable {

    // MARK: - Private Properties

    private let viewModel = TextOperationViewModel()
    private let themeSwitchView = ThemeSwitchView(frame: .zero)

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(TextOperationCell.self, reuseIdentifier: "TextOperationCell")
        return tableView
    }()

    private lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()

    private var isThemeSwitchViewHidden: Bool {
        get { return themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }

    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }

    // MARK: - Private Methods

    private func addSubviews() {
        [tableView].addToSuperview(view)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.doubleModule),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureUI() {
        isThemeSwitchViewHidden = false
    }

    private func configureManager() {
        tableViewManager.tableView = tableView
        tableView.dataSource = tableViewManager
        tableView.delegate = self
        updateTable()
    }

    private func updateTable() {
        tableViewManager.sections = viewModel.sections
        tableView.reloadData()
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        setupConstraints()
        configureManager()
        configureUI()
    }

 }

 extension TextOperationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

 }
