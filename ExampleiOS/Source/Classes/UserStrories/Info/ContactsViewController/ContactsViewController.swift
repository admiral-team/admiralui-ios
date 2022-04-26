//
//  ContactsViewController.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ContactsViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Methods
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()
    private var sections = [InfoViewCellItems]() {
        didSet {
            tableView.reloadData()
        }
    }
    private let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        setupConstraints()
        configureManager()
    }
    
    private func addSubviews() {
        [tableView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureManager() {
        tableViewManager.tableView = tableView
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = tableViewManager
        tableView.registerCell(ContactsTableViewCell.self)
        tableViewManager.sections = createSections()
    }
    
    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = [
            ContactsTableViewCellViewModel(
                title: "Поддержка",
                // swiftlint:disable line_length
                subtitle: "Наш чат-бот помогает оперативно принимать и обрабатывать все запросы. Если у вас есть предложения или  замечания, то вы можете написать ему в телеграмм:",
                additionaltitle: "Телеграмм канал",
                didSelect: { [weak self] in
                    self?.didSelectTelegramm()
                }),
            
            ContactsTableViewCellViewModel(
                title: "Хотите использовать дизайн-систему?",
                subtitle: "Для того, чтобы использовать дизайн-систему в своем проекте, стоит написать на рабочую почту или при желании назначить встречу:",
                didSelect: nil),
            
            ContactsTableViewCellViewModel(
                title: "Дарья",
                additionaltitle: "",
                didSelect: { [weak self] in
                    self?.didSelectEmail(path: "")
                }),
            
            ContactsTableViewCellViewModel(
                title: "Антон",
                additionaltitle: "",
                didSelect: { [weak self] in
                    self?.didSelectEmail(path: "")
                })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func didSelectTelegramm() {
        guard let url = URL(string: "https://t.me/digitalframeworks_mobilebot") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
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

// MARK: - UITableViewDelegate

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewManager.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
