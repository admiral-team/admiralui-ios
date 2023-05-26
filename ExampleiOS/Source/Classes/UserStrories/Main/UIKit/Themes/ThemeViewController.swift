//
//  ThemeViewController.swift
//  ExampleiOS
//
//  Created on 18.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralImages
import UIKit

protocol ThemeViewControllerDelegete: AnyObject {
    func saveTheme(_ viewController: ThemeViewController)
    func removeTheme(_ viewController: ThemeViewController)
    func applyTheme(_ viewController: ThemeViewController)
}

final class ThemeViewController: BaseTableViewController {
    
    enum Mode {
        case apply
        case save
    }
    
    weak var delegate: ThemeViewControllerDelegete?
    
    var theme: AppTheme! {
        didSet { checkThemeDeleting(themeId: theme.identifier) }
    }
    
    var isEditingEnabled: Bool = true {
        didSet { updateEditingMode() }
    }
    
    var mode: Mode = .apply {
        didSet { updateButtons() }
    }
    
    // MARK: - Private Properties
    
    private let bottomButton = PrimaryButton()
    
    private lazy var deleteButton: UIBarButtonItem = {
        UIBarButtonItem(
            image: AdmiralImages.Asset.System.Outline.deleteOutline.image,
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton))
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isThemeSwitchButtonHidden = true
        setSegmentControl(hidden: true)
        
        tableView.separatorStyle = .none
        
        addSubviews()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateEditingMode()
        updateButtons()
        reloadData()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        bottomButton.apply(theme: theme)
        deleteButton.tintColor = theme.colors.elementAccent.uiColor

        reloadData()
    }
    
    func reloadData() {
        guard isViewLoaded else { return }
        title = theme.displayName
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
    
    private func configureUI() {
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        updateButtons()
        updateEditingMode()
    }
    
    private func updateButtons() {
        guard isViewLoaded else { return }
        switch mode {
        case .apply:
            bottomButton.setTitle("Применить", for: .normal)
        case .save:
            bottomButton.setTitle("Сохранить", for: .normal)
        }
    }
    
    private func updateEditingMode() {
        guard isViewLoaded else { return }
        reloadData()
    }

    private func checkThemeDeleting(themeId: String) {
        let themes = [
            AppTheme.ThemeIdentifiers.sMELight,
            AppTheme.ThemeIdentifiers.sMEDark,
            AppTheme.ThemeIdentifiers.dark,
            AppTheme.ThemeIdentifiers.light
        ]
        navigationItem.rightBarButtonItem = themes.contains(themeId) ? nil : deleteButton
        reloadData()
    }

    
    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = [
            MenuListViewModel(
                title: theme.displayName,
                subtitle: "Название темы",
                isEnabled: isEditingEnabled,
                didSelect: { [weak self] in
                    guard let self = self else { return }
                    guard self.isEditingEnabled else { return }
                    self.presentName()
                },
                accessibillityId: theme.displayName),
            MenuListViewModel(
                title: "Colors",
                subtitle: "Цвета темы",
                didSelect: { [weak self] in self?.presentColors() },
                accessibillityId: "Colors"),
            
            MenuListViewModel(
                title: "Fonts",
                subtitle: "Шрифты темы",
                didSelect: { [weak self] in self?.presentFonts() },
                accessibillityId: "Fonts")
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    @objc private func didTapBottomButton() {
        switch mode {
        case .apply:
            delegate?.applyTheme(self)
        case .save:
            delegate?.saveTheme(self)
        }
    }
    
    @objc private func didTapRightBarButton() {
        delegate?.removeTheme(self)
    }
    
    private func presentName() {
        let viewController = EditSingleTextViewController()
        viewController.title = "Тема"
        viewController.text = theme.displayName
        viewController.textEditName = "Название темы"
        viewController.infoMessage = "Редактирование названия темы"
        viewController.actionName = "Готово"
        viewController.delegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentColors() {
        let viewController = ThemeColorsViewController()
        viewController.title = "Colors"
        viewController.isEditEnabled = isEditingEnabled
        viewController.colorTokens = ThemesRepostory.colorTokens(for: theme)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentFonts() {
        let viewController = FontsViewController()
        viewController.title = "Fonts"
        viewController.fonts = theme.fonts
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension ThemeViewController: EditSingleTextViewControllerDelegate {
    
    func didEndEditText(_ viewController: EditSingleTextViewController) {
        guard let text = viewController.text else { return }
        theme.displayName = text
        navigationController?.popViewController(animated: true)
        mode = .save
    }
    
    func enableAction(_ viewController: EditSingleTextViewController) -> Bool {
        guard let text = viewController.text else {
            return false
        }
        return !text.isEmptyOrWhitespace()
    }
    
}

// MARK: - Extensions

private extension String {
    func isEmptyOrWhitespace() -> Bool {
        guard !self.isEmpty else { return true }
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}

extension ThemeViewController: ThemeColorsViewControllerDelegate {
    
    func updateColor(_ viewController: ThemeColorsViewController, colorToken: ColorToken) {
        ThemesRepostory.replace(token: colorToken, for: theme)
        mode = .save
    }
    
}
