//
//  TextMessageViewController.swift
//  ExampleiOS
//
//  Created on 20.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class TextMessageViewController: UIViewController, AnyAppThemable {

    // MARK: - Private Properties

    private let themeSwitchView = ThemeSwitchView(frame: .zero)

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
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

    private var chatMessages: [ChatMessageCellViewModel] = [
        ChatMessageCellViewModel(
            message: "Привет, какой у вас вопрос ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .left,
            name: "Антон"
        ),
        ChatMessageCellViewModel(
            message: "Будем рады ответить !",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .left,
            state: .error
        ),
        ChatMessageCellViewModel(
            message: "Каким образом использовать ChatBubbleView ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .sent,
            state: .error
        ),
        ChatMessageCellViewModel(
            message: "Повторная попытка отправки сообщения ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .sent
        )
    ]

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

    private func configureUI() {
        isThemeSwitchViewHidden = false
    }

    private func configureManager() {
        tableViewManager.tableView = tableView
        tableView.separatorStyle = .none
        tableView.dataSource = tableViewManager
        tableView.delegate = self
        tableView.registerCell(ChatMessageCell.self)
        updateTable()
    }

    private func updateTable() {
        tableViewManager.sections = createSections()
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }

    private func createSections() -> [MainSectionViewModel] {
        [MainSectionViewModel(items: chatMessages)]
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        configureManager()
        configureUI()
    }

    private func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Повторить отправку", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: {})
    }

}

extension TextMessageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = chatMessages[indexPath.row]
        if model.state == .error {
            showAlert()
        }
    }

}
