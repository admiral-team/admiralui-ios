//
//  TableViewListItemManager.swift
//  Example iOS
//
//  Created on 12.10.2020.
//

import UIKit


protocol TableViewListItemSection {
    var header: TableViewListItem? { get }
    var footer: TableViewListItem? { get }
    var items: [TableViewListItem] { get }
}

protocol TableViewListItem {
    var reuseIdentifier: String { get }
    var didSelect: (() -> Void)? { get }
}

protocol TableViewListItemConfigurable {
    func configure(for item: TableViewListItem)
}

final class TableViewListItemManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var sections: [TableViewListItemSection] = [] {
        didSet { reloadData() }
    }
    
    weak var tableView: UITableView?
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    private func didSelectItem(at indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        item.didSelect?()
    }
    
    private func configureViewIfNeeded(_ view: UIView, for item: TableViewListItem) {
        guard let view = view as? TableViewListItemConfigurable else { return }
        view.configure(for: item)
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func numberOfSections(in: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        configureViewIfNeeded(cell, for: item)
        
        return cell
    }
    
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let item = sections[section].footer,
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.reuseIdentifier)
        else { return nil }

        configureViewIfNeeded(footerView, for: item)

        return footerView
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let item = sections[section].header,
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.reuseIdentifier)
        else { return nil }
        
        configureViewIfNeeded(headerView, for: item)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem(at: indexPath)
    }
    
}
