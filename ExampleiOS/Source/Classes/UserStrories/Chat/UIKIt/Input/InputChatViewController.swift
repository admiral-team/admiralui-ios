//
//  InputChatViewController.swift
//  ExampleiOS
//
//  Created on 24.11.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class InputChatViewController: UIViewController, AnyAppThemable {

    // MARK: - Contants

    private enum Constants {
        static let chatSpacing: CGFloat = LayoutGrid.doubleModule
        static let scrollViewPaddingBottom: CGFloat = 60
        static let chatPlaceHolder: String = "Введите сообщение"
        static let segmentViewHeight: CGFloat = LayoutGrid.doubleModule * 3
    }

    // MARK: - Private Properties

    private let viewModel = InputChatViewModel()
    private let chatInputView = ChatInputView()
    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private let binder = KeyboardBinder()
    private var chatInputBottomConstraint = NSLayoutConstraint()
    private lazy var segmentControl = StandardSegmentedControl(frame: .zero)

    // MARK: - Private computed properties

    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(ChatMessageCell.self, reuseIdentifier: "ChatMessageCell")
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()

    private var isThemeSwitchViewHidden: Bool {
        get { themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        binder.bindToKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.unbindFromKeyboardNotifications()
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
        segmentControl.apply(theme: theme)
    }

    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }

    // MARK: - Private Methods

    private func configureUI() {
        binder.bindable = self

        isThemeSwitchViewHidden = true
        chatInputView.actionState = .attachFiles
        chatInputView.placeholder = Constants.chatPlaceHolder
        chatInputView.chatInputDelegate = self
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureManager() {
        // tableViewManager.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        // tableViewManager.sections = viewModel.sections
    }

    private func updateTable() {
        // tableViewManager.sections = viewModel.sections
        tableView.reloadData()
    }

    private func addMessage() {
        viewModel.addMessage(chatInputView.inputText)
    }

    private func addSubviews() {
        [chatInputView, tableView, segmentControl].addToSuperview(view)
    }

    private func configureConstraints() {
        chatInputBottomConstraint = view.bottomAnchor.constraint(equalTo: chatInputView.bottomAnchor, constant: Constants.chatSpacing)
        NSLayoutConstraint.activate([
            chatInputBottomConstraint,
            chatInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.chatSpacing),
            view.trailingAnchor.constraint(equalTo: chatInputView.trailingAnchor, constant: Constants.chatSpacing),
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.module),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),

            view.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentViewHeight),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            chatInputView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: LayoutGrid.module)
        ])
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        configureManager()
        configureUI()
        addGestures()
    }

    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tableView.addGestureRecognizer(tap)
    }

    @objc private func didTap() {
        view.endEditing(true)
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        chatInputView.setState(control.selectedSegmentIndex == 1 ? .disabled : .normal, animated: true)
    }

}

// MARK: - KeyboardBindable

extension InputChatViewController: KeyboardBindable {

    func keyboardFrameWillShow(info: KeyboardInfo) {
        chatInputBottomConstraint.constant = info.bottomOffset + (LayoutGrid.halfModule * 5)
    }

    func keyboardFrameWillHide(info: KeyboardInfo) {
        chatInputBottomConstraint.constant = Constants.chatSpacing
    }

}


extension InputChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as? ChatMessageCell else {
            return UITableViewCell()
        }
        cell.configure(for: viewModel.messages[indexPath.row])
        return cell
    }

}

extension InputChatViewController: ChatInputViewDelegate {

    func textViewSizeDidChange(_ chatInput: ChatInputView, size: CGSize) {
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.scrollToBottom(isAnimated: false)
    }

    func didTapSendButton(_ chatInput: ChatInputView) {
        addMessage()
        chatInputView.setText("", animated: false)
        updateTable()
    }

}

private extension UITableView {

    func scrollToBottom(isAnimated: Bool = true) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection: self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }

}
