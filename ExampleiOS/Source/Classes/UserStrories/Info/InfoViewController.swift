//
//  InfoViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class InfoViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Methods
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
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

    private var appVersion: String? {
        AdmiralUIKit.LibraryInfo.version?.versionName
    }
    
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
        tableView.registerCell(InfoMainCell.self)
        tableView.registerCell(MenuInfoCell.self)
        tableViewManager.sections = createSections()
    }
    
    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = [
            InfoMainCellViewModel(title: "Версия: \(appVersion ?? "")"),
            
            MenuInfoCellViewModel(
                title: "Инфо",
                image: Asset.Info.infoSolid.image,
                didSelect: { [weak self] in self?.presentInformation() }),
            
            MenuInfoCellViewModel(
                title: "Контакты",
                image: Asset.Info.emailSolid.image,
                didSelect: { [weak self] in self?.presentContacts() }),
            
            MenuInfoCellViewModel(
                title: "FAQ",
                image: Asset.Info.helpSolid.image,
                didSelect: { [weak self] in self?.presentFAQ() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentContacts() {
        let viewController = ContactsViewController()
        viewController.title = "Контакты"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentInformation() {
        let viewController = InformationViewController()
        viewController.title = "Инфо"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentFAQ() {
        let viewController = FAQViewController()
        viewController.title = "FAQ"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension InfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewManager.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
