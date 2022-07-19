//
//  MenuListViewController.swift
//  Example iOS
//
//  Created on 12.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class MenuListViewController: UIViewController, UITableViewDelegate, AnyAppThemable {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureManager()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    private func configureUI() {
        autoManage()
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(tableView.fillView(view: view))
    }
    
    private func configureManager() {
        tableViewManager.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = tableViewManager
        tableView.registerCell(MenuListCell.self)
        tableView.registerCell(MainTableViewCell.self)
        tableView.registerSupplementary(MenuTableViewHeaderView.self)
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableViewManager.tableView(tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableViewManager.tableView(tableView, viewForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewManager.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
