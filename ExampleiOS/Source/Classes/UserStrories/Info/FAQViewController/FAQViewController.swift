//
//  FAQViewController.swift
//  ExampleiOS
//
//  Created on 09.03.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class FAQViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Methods
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88.0
        return tableView
    }()
    private lazy var tableViewManager: TableViewListItemManager = {
        let manager = TableViewListItemManager()
        return manager
    }()
    private var sections = [InfoViewCellItems]() {
        didSet { tableView.reloadData() }
    }
    private var items = [TableViewListItem]()
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
        tableView.registerCell(FAQTableViewCells.self)
        tableViewManager.sections = createSections()
    }

    private func createSections() -> [MainSectionViewModel] {
        items = [
            FAQTableViewCellViewModel(
                title: "Зачем нужна дизайн-система?",
                // swiftlint:disable line_length
                subtitle: "Дизайн-система — это набор стилей и компонентов, который упрощает создание, тестирование, визуальное и техническое обновление продуктов, а также обеспечивает единообразие и узнаваемость их интерфейсов.",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Как подключить дизайн-систему?",
                subtitle: "Для подключения дизайн-системы стоит обратиться к любому члену команды \("Цифровые фреймворки")",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Как использовать дизайн-систему?",
                // swiftlint:disable line_length
                subtitle: "Для этого нужно подключить к рабочему файлу UI kit (iOS/Android) и дополнительно — к UI kit color. Далее в правой панели появятся стили, а в библиотеке — все компоненты. Вы можете использовать все базовые компоненты дизайн-системы, и при необходимости разрабатывать дополнительные внутри своего проекта или обратиться к команде \("Цифровые фреймворки") за помощью. Кроме того, у нас есть возможность разработки индивидуальной темы для вашего проекта.",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Это только для новых продуктов?",
                // swiftlint:disable line_length
                subtitle: "Дизайн-систему можно подключить к проекту на любом этапе его разработки, наша команда поможет вам запланировать переход по срокам дизайна макетов и разработке.",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Как переключать темы?",
                subtitle: "Подробная инструкция по подключению и использованию плагина есть в файле UI Kit Color или обратиться к нашей команде.",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Для каких платформ разрабатывается библиотека?",
                subtitle: "iOS и Android",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Для каких версий операционной системы разработана библиотека? ",
                subtitle: "Версия iOS 10 + / Android 5+",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Где хранится документация по библиотеке?",
                subtitle: "Вся документация размещена в репозитории BitBucket, доступ можно получить написав",
                isExpanded: false,
                tappableRange: "",
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Кто ее разрабатывает и поддерживает?",
                subtitle: "Департамент ИТ-архитектуры, стрим \("Цифровые фпеймворки")",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Увидел ошибку, кому и как сообщить?",
                subtitle: "По этому и другим вопросам можно писать нашему чат-боту «ссылка»",
                isExpanded: false,
                didSelect: nil),
            FAQTableViewCellViewModel(
                title: "Как создать свою тему в приложении?",
                subtitle: "В разделе Colors есть кнопка «Создать новую тему»: она позволяет создавать неограниченное количество тем и в режиме реального времени применять их на компонентах библиотеки. Темы создаются только в вашем аккаунте, в любой момент вы можете изменить или удалить их.",
                isExpanded: false,
                didSelect: nil)
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
}

// MARK: - UITableViewDelegate

extension FAQViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = items[indexPath.row] as? FAQTableViewCellViewModel else { return }
        item.isExpanded = !item.isExpanded
        tableViewManager.tableView?.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
