//
//  ColorsViewController.swift
//  ExampleiOS
//
//  Created on 04.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ThemesViewController: BaseTableViewController {
        
    private let bottomButton = PrimaryButton()
    private weak var modalNavigationController: UINavigationController?
    private var modalController = ModallyPresentedNavigationControllerDelegate()
    
    private var newThemeDisplayName: String?
    private let repository = ThemesRepostory()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isThemeSwitchButtonHidden = true
        setSegmentControl(hidden: true)
       
        setupButtons()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isThemeSwitchButtonHidden = true
        reloadData()
        addSubviews()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        bottomButton.apply(theme: theme)
        reloadData()
    }
    
    func reloadData() {
        guard isViewLoaded else { return }
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods
    
    private func addSubviews() {
        [bottomButton].addToSuperview(view)
        NSLayoutConstraint.activate([
            view.bottomSafeAreaAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: LayoutGrid.halfModule * 6),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6)
        ])
    }
    
    private func setupButtons() {
        bottomButton.setTitle("Создать новую тему", for: [])
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
    }
    
    private func createSections() -> [MainSectionViewModel] {
        let selectedTheme = repository.selectedTheme
        let allThemes = repository.themes
        
        let items: [TableViewListItem] = allThemes.map() { theme in
            let isSelected = theme == selectedTheme
            return MainTitleTableViewCellViewModel(
                title: theme.displayName ?? "",
                subtitle: isSelected ? "Выбрано" : "",
                didSelect: { [weak self] in self?.present(theme: theme) }
            )
        }
        
        return [MainSectionViewModel(items: items)]
    }
    
    @objc private func didTapBottomButton() {
        presentName()
    }
    
    private func present(theme: AppTheme) {
        let viewController = ThemeViewController()
        let disableEditingThemes = [
            AppTheme.ThemeIdentifiers.dark,
            AppTheme.ThemeIdentifiers.light
        ]

        viewController.delegate = self
        viewController.theme = theme
        viewController.title = "Тема"
        viewController.isEditingEnabled = !disableEditingThemes.contains(theme.identifier)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentName() {
        let viewController = EditSingleTextViewController()
        viewController.title = "Новая тема"
        viewController.textEditName = "Название темы"
        viewController.textPlaceholder = "Theme one"
        viewController.infoMessage = "Придумайте название для новой темы"
        viewController.actionName = "Далее"
        viewController.delegate = self
        
        let navController = BaseNavigationController(rootViewController: viewController)
        navController.delegate = modalController
        modalNavigationController = navController
        
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    private func presentSelectTemplate() {
        let viewController = SelectThemeTemplateViewController()
        viewController.title = "Новая тема"
        viewController.delegate = self
        modalNavigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - ThemeViewControllerDelegate

extension ThemesViewController: ThemeViewControllerDelegete {
    
    func saveTheme(_ viewController: ThemeViewController) {
        guard let theme = viewController.theme else { return }
        
        repository.save(theme: theme)

        if theme == repository.selectedTheme {
            repository.apply(theme: theme)
            navigationController?.popViewController(animated: true)
        } else {
            viewController.mode = .apply
        }
    }
    
    func removeTheme(_ viewController: ThemeViewController) {
        repository.remove(theme: viewController.theme)
        navigationController?.popViewController(animated: true)
    }
    
    func applyTheme(_ viewController: ThemeViewController) {
        repository.apply(theme: viewController.theme)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - EditSingleTextViewControllerDelegate

extension ThemesViewController: EditSingleTextViewControllerDelegate {
    
    func didEndEditText(_ viewController: EditSingleTextViewController) {
        newThemeDisplayName = viewController.text
        presentSelectTemplate()
    }
    
    func enableAction(_ viewController: EditSingleTextViewController) -> Bool {
        return viewController.text?.nilIfEmpty != nil
    }
    
}

// MARK: - SelectThemeTemplateViewControllerDelegate

extension ThemesViewController: SelectThemeTemplateViewControllerDelegate {
    
    func didSelecteThemeTemplate(_ viewController: SelectThemeTemplateViewController, theme: AppTheme) {
        let theme = AppTheme(
            id: UUID().uuidString,
            displayName: newThemeDisplayName,
            colors: theme.colors,
            fonts: theme.fonts)
        
        repository.save(theme: theme)
        reloadData()
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    
}
