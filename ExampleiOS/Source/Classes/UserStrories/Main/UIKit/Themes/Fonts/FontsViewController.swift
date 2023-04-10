//
//  FontViewController.swift
//  Example iOS
//
//  Created on 13.10.2020.
//

import AdmiralUIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class FontsViewController: MenuListViewController {
    
    var fonts: FontPalette! {
        didSet { reloadData() }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.registerCell(FontCell.self)
        tableViewManager.sections = createSections()
        tableView.sectionHeaderHeight = 64.0
        tableView.estimatedSectionHeaderHeight = 64.0
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
    }
    
    func reloadData() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        64.0
    }
    
    // MARK: - Private Methods
    
    private func createSections() -> [MenuListSectionViewModel] {
        [
            createHeadlines(themeFonts: fonts),
            createSubtitle(themeFonts: fonts),
            createSubhead(themeFonts: fonts),
            createCaption(themeFonts: fonts),
            createBody(themeFonts: fonts)
        ]
    }
    
    private func createHeadlines(themeFonts: FontPalette) -> MenuListSectionViewModel {
        let items: [TableViewListItem] = [
            FontViewModel(title: "Large Title 1", font: fonts.largeTitle1),
            FontViewModel(title: "Large Title 2", font: fonts.largeTitle2),
            FontViewModel(title: "Title 1", font: fonts.title1),
            FontViewModel(title: "Title 2", font: fonts.title2)
        ]
        return MenuListSectionViewModel(
            items: items,
            header: MenuTableViewHeaderViewViewModel(title: "Headlines"))
    }
    
    private func createSubtitle(themeFonts: FontPalette) -> MenuListSectionViewModel {
        let items: [TableViewListItem] = [
            FontViewModel(title: "Subtitle 1", font: fonts.subtitle1),
            FontViewModel(title: "Subtitle 2", font: fonts.subhead2),
            FontViewModel(title: "Subtitle 3", font: fonts.subhead3),
            FontViewModel(title: "Headline", font: fonts.headline)
        ]
        return MenuListSectionViewModel(
            items: items,
            header: MenuTableViewHeaderViewViewModel(title: "Subtitle"))
    }
    
    private func createBody(themeFonts: FontPalette) -> MenuListSectionViewModel {
        let items: [TableViewListItem] = [
            FontViewModel(title: "Body 1", font: fonts.body1),
            FontViewModel(title: "Body 2", font: fonts.body2)
        ]
        return MenuListSectionViewModel(
            items: items,
            header: MenuTableViewHeaderViewViewModel(title: "Body"))
    }
    
    private func createSubhead(themeFonts: FontPalette) -> MenuListSectionViewModel {
        let items: [TableViewListItem] = [
            FontViewModel(title: "Subhead 1", font: fonts.subhead1),
            FontViewModel(title: "Subhead 2", font: fonts.subhead2),
            FontViewModel(title: "Subhead 3", font: fonts.subhead3),
            FontViewModel(title: "Subhead 4", font: fonts.subhead4)
        ]
        return MenuListSectionViewModel(
            items: items,
            header: MenuTableViewHeaderViewViewModel(title: "Subhead"))
    }
    
    private func createCaption(themeFonts: FontPalette) -> MenuListSectionViewModel {
        let items: [TableViewListItem] = [
            FontViewModel(title: "Caption 1", font: themeFonts.caption1),
            FontViewModel(title: "Caption 2", font: themeFonts.caption2)
        ]
        return MenuListSectionViewModel(
            items: items,
            header: MenuTableViewHeaderViewViewModel(title: "Caption"))
    }
    
}
