//
//  MainViewController.swift
//  Example iOS
//
//  Created on 12.10.2020.
//

import AdmiralUIKit
import AdmiralUIResources
import AdmiralTheme
import UIKit

class MainViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Properties
    
    private let searchBar = SearchBar()
    private var items: [MainTableViewCellViewModel] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    private lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()

    private let themeSwitchView = ThemeSwitchView()
    private var isSearching: Bool = false {
        didSet { tableViewManager.reloadData() }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        commonInit()
        tableViewManager.sections = [MainSectionViewModel(items: items)]
    }

    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        searchBar.apply(theme: theme)
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        addSubviews()
        configureUI()
        createItems()
        configureSeacrhBar()
        configureManager()
        hideKeyboardWhenTappedAround() 
    }
    
    private func addSubviews() {
        [tableView,
         searchBar].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
         })
    }
    
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: LayoutGrid.doubleModule),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.module),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.module)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addThemeSwitchView(themeSwitchView)        
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
    
    private func configureSeacrhBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
    }
    
    // swiftlint:disable:next function_body_length
    private func createItems() {
        items = [
            MainTableViewCellViewModel(
                title: "Themes",
                subtitle: "Цветовая палитра и схема",
                image: Asset.Main.pencil.image,
                didSelect: { [weak self] in self?.presentColors() }),
            
            MainTableViewCellViewModel(
                title: "Icons",
                subtitle: "Subtitle",
                image: Asset.Main.gem.image,
                didSelect: { [weak self] in self?.presentIcons() }),
            
            MainTableViewCellViewModel(
                title: "Buttons",
                subtitle: "Кнопки",
                image: Asset.Main.main.image,
                didSelect: { [weak self] in self?.presentButtons() }),
            
            MainTableViewCellViewModel(
                title: "TextFields",
                subtitle: "Поля ввода",
                image: Asset.Main.draw.image,
                didSelect: { [weak self] in self?.presentTextFields() }),
            
            MainTableViewCellViewModel(
                title: "Cells",
                subtitle: "Списки",
                image: Asset.Main.list.image,
                didSelect: { [weak self] in self?.presentCells() }),
            
            MainTableViewCellViewModel(
                title: "Text Blocks",
                subtitle: "Текстовые блоки",
                image: Asset.Main.textBlocks.image,
                didSelect: { [weak self] in self?.presentTextBlocks() }),
            
            MainTableViewCellViewModel(
                title: "Tabs",
                subtitle: "Вкладки",
                image: Asset.Main.gem.image,
                didSelect: { [weak self] in self?.presentTabs() }),
            
            MainTableViewCellViewModel(
                title: "Informers & Notifications",
                subtitle: "Информеры",
                image: Asset.Main.chat.image,
                didSelect: { [weak self] in self?.presentInformersNotifications() }),
            
            MainTableViewCellViewModel(
                title: "Tags & Chips",
                subtitle: "Тэги и чипсы",
                image: Asset.Main.pin.image,
                didSelect: { [weak self] in self?.presentTags() }),
            
            MainTableViewCellViewModel(
                title: "Badges",
                subtitle: "Количественные зачения",
                image: Asset.Main.badges.image,
                didSelect: { [weak self] in self?.presentBadges() }),
            
            MainTableViewCellViewModel(
                title: "RadioButton",
                subtitle: "Радио кнопка",
                image: Asset.Main.radiobuttons.image,
                didSelect: { [weak self] in self?.presentRadioAndSwitcher() }),
            
            MainTableViewCellViewModel(
                title: "Сheckbox",
                subtitle: "Селектор",
                image: Asset.Main.gem.image,
                didSelect: { [weak self] in self?.presentCheckbox() }),
            
            MainTableViewCellViewModel(
                title: "Switcher",
                subtitle: "Переключатель",
                image: Asset.Main.checkboxes.image,
                didSelect: { [weak self] in self?.presentSwitcher() }),
            
            MainTableViewCellViewModel(
                title: "Links",
                subtitle: "Ссылки",
                image: Asset.Main.links.image,
                didSelect: { [weak self] in self?.presentLinkControl() }),
            
            MainTableViewCellViewModel(
                title: "Spiner",
                subtitle: "Демонстрация процесса загрузки",
                image: Asset.Main.spinner.image,
                didSelect: { [weak self] in self?.presentActivityIndicator() }),
            
            MainTableViewCellViewModel(
                title: "Page Controls",
                subtitle: "Прогресс просмотра страниц",
                image: Asset.Main.pageControls.image,
                didSelect: { [weak self] in self?.presentPageControls() }),
            MainTableViewCellViewModel(
                title: "Shimmers",
                subtitle: "Демонстрация процесса загрузки",
                image: Asset.Main.refresh.image,
                didSelect: { [weak self] in self?.presentShimmering() }),
            
            MainTableViewCellViewModel(
                title: "Time Picker",
                subtitle: "Выбор времени",
                image: Asset.Main.time.image,
                didSelect: { [weak self] in self?.presentTimePickerl() }),
            
            MainTableViewCellViewModel(
                title: "Calendar",
                subtitle: "Каледарь",
                image: Asset.Main.calendar.image,
                didSelect: { [weak self] in self?.presentCalendar() }),
      
            MainTableViewCellViewModel(
                title: "Alerts",
                subtitle: "Информирующие сообщения",
                image: Asset.Main.envelope.image,
                didSelect: { [weak self] in self?.presentAlert() }),
            
            MainTableViewCellViewModel(
                title: "Tool bar",
                subtitle: "Панель инструментов",
                image: Asset.Main.chat.image,
                didSelect: { [weak self] in self?.presentToolbar() }),

            MainTableViewCellViewModel(
                title: "Bottom sheets",
                subtitle: "Информационная панель",
                image: Asset.Main.bottomSheets.image,
                didSelect: { [weak self] in self?.presentBottomSheets() }),

            MainTableViewCellViewModel(
                title: "Currency",
                subtitle: "Таблица курсов валют",
                image: Asset.Main.currency.image,
                didSelect: { [weak self] in self?.presentCurrency() }),

            MainTableViewCellViewModel(
                title: "Chat",
                subtitle: "Чат",
                image: Asset.Main.chat.image,
                didSelect: { [weak self] in self?.presentChat() }),

            MainTableViewCellViewModel(
                title: "Map Elements",
                subtitle: "Элементы для карты",
                image: AdmiralUIResources.Asset.Location.Solid.locationSolid.image,
                didSelect: { [weak self] in self?.presentMapElements() })
        ]
    }
    
    private func filterData(text: String) {
        let searchItems = items.filter({ $0.title.contains(text) })
        tableViewManager.sections = [MainSectionViewModel(items: searchItems)]
    }
    
    @objc private func tapThemeSwitchButton(_ button: UIButton) {
        themeSwitchView.setIsHidden(!button.isSelected, animated: true)
        
        if !themeSwitchView.isHidden {
            themeSwitchView.reloadData()
        }
    }
    
}

// MARK: - UISearchBarDelegate

extension MainViewController: SearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: SearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: SearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            tableViewManager.sections = [MainSectionViewModel(items: items)]
            isSearching = false
        } else {
            filterData(text: searchText)
            isSearching = true
        }
    }
    
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
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

// MARK: - MainViewControllerRouting

extension MainViewController {
    
    private func presentTextFields() {
        let viewController = TextFieldsViewController()
        viewController.title = "Text fields"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentButtons() {
        let viewController = ButtonsViewController()
        viewController.title = "Buttons"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentColors() {
        let viewController = ThemesViewController()
        viewController.title = "Themes"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentTextBlocks() {
        let viewController = TextBlocksViewController()
        viewController.title = "Text Blocks"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentIcons() {
        let viewController = IconsViewController()
        viewController.title = "Icons"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentActivityIndicator() {
        let viewController = SpinnerViewController()
        viewController.title = "Spinner"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentTags() {
        let viewController = TagsChipsViewController()
        viewController.title = "Tags & Chips"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentBadges() {
        let viewController = BadgesViewController()
        viewController.title = "Badges"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentRadioAndSwitcher() {
        let viewController = RadioButtonViewController()
        viewController.title = "RadioButton"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCheckbox() {
        let viewController = CheckboxViewController()
        viewController.title = "Checkbox"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentSwitcher() {
        let viewController = SwitcherViewController()
        viewController.title = "Switcher"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentTabs() {
        let viewController = TabsViewController()
        viewController.title = "Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentAlert() {
        let viewController = AlertOnboardingViewController()
        viewController.title = "Alerts & Onboarding"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCalendar() {
        let viewController = CalendarsViewController()
        viewController.title = "Calendar"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCells() {
        let viewController = CellsViewController()
        viewController.title = "Cells"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentInformersNotifications() {
        let viewController = InformersAndToastsViewController()
        viewController.title = "Informers & Notifications"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentToolbar() {
        let viewController = ToolbarViewController()
        viewController.title = "Toolbar"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentBottomSheets() {
        let viewController = BottomSheetViewController()
        viewController.title = "Bottom-Sheets"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentShimmering() {
        let viewController = ShimmersViewController()
        viewController.title = "Shimmers"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentPageControls() {
        let viewController = PageControlsViewController()
        viewController.title = "Page Controls"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentLinkControl() {
        let viewController = LinksViewController()
        viewController.title = "Links"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentTimePickerl() {
        let viewController = TimePickerViewController()
        viewController.title = "Time Picker"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentChat() {
        let viewController = ChatViewController()
        viewController.title = "Чат"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentCurrency() {
        let viewController = CurrencyViewController()
        viewController.title = "Currency"
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func presentMapElements() {
        let viewController = MapButtonsViewController()
        viewController.title = "Map Elements"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
