//
//  SelectThemeTemplateViewController.swift
//  ExampleiOS
//
//  Created on 20.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol SelectThemeTemplateViewControllerDelegate: AnyObject {
    func didSelecteThemeTemplate(_ viewController: SelectThemeTemplateViewController, theme: AppTheme)
}

final class SelectThemeTemplateViewController: BaseTableViewController {
    
    weak var delegate: SelectThemeTemplateViewControllerDelegate?
    
    private let headerView = ThemeInfoHeaderView()
    private let bottomButton = PrimaryButton()
    private let themes: [AppTheme] = [.light, .dark]
    private var selectedTheme: AppTheme = .light

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        isThemeSwitchButtonHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        headerView.apply(theme: theme)
        reloadData()
    }
    
    func reloadData() {
        guard isViewLoaded else { return }
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods
    
    private func configureUI() {
        setSegmentControl(hidden: true)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        headerView.infoLabel.text = "Выберите шаблон:"
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        tableView.sizeHeaderToFit()
        
        [bottomButton].addToSuperview(view)
        NSLayoutConstraint.activate([
            view.bottomSafeAreaAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6)
        ])
        
        bottomButton.setTitle("Создать новую тему", for: [])
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
    }

    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = themes.map() { theme in
            return MainTitleTableViewCellViewModel(
                title: theme.displayName ?? "",
                subtitle: selectedTheme == theme ? "Выбрано" : nil,
                didSelect: { [weak self] in self?.didSelect(theme: theme) }
            )
        }
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func didSelect(theme: AppTheme) {
        selectedTheme = theme
        reloadData()
    }
    
    @objc private func didTapBottomButton() {
        delegate?.didSelecteThemeTemplate(self, theme: selectedTheme)
    }
    
}
