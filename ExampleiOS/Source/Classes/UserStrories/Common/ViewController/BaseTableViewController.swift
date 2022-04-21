//
//  BaseTableViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

class BaseTableViewController: UIViewController, UITableViewDelegate, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var isThemeSwitchButtonHidden: Bool {
        get { return themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }
    
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
    
    lazy var segmentControl = StandardSegmentedControl(frame: .zero)
 
    // MARK: - Private Properties
    
    private enum Constants {
        static let segmentViewHeight: CGFloat = 48.0
    }
    
    private lazy var tableViewTopConstraint: NSLayoutConstraint = {
        return tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.segmentViewHeight)
    }()
    private let themeSwitchView = ThemeSwitchView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        segmentControl.apply(theme: theme)
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }
    
    func setSegmentControl(hidden: Bool) {
        segmentControl.isHidden = hidden
        tableViewTopConstraint.constant = hidden ? 0 : Constants.segmentViewHeight
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureUI()
        configureManager()
    }
    
    private func addSubviews() {
        [tableView,
         segmentControl,
         themeSwitchView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
         })
    }
    
    private func configureUI() {
        addThemeSwitchView(themeSwitchView)
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.module),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentViewHeight),
            
            tableViewTopConstraint,
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureManager() {
        tableViewManager.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = tableViewManager
        tableView.registerCell(MenuListCell.self)
        tableView.registerCell(MainTableViewCell.self)
        tableView.registerCell(MainTitleTableViewCell.self)
        tableView.contentInset.bottom = LayoutGrid.module * 8
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableViewManager.tableView(tableView, viewForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableViewManager.tableView(tableView, viewForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewManager.tableView(tableView, didSelectRowAt: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutGrid.halfModule * 17
    }
    
}
