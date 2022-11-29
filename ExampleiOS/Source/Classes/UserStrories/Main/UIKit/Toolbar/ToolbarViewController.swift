//
//  ToolbarController.swift
//  ExampleiOS
//
//  Created on 01.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class ToolbarViewController: BaseTableViewController, CodeInputControlDelegate, ToolbarDelegate {

    // MARK: - Private Properties
    
    private let toolbar = Toolbar()
    private let stepper = InputNumber()
    private var items = [ToolbarItem]()
    private let item1 = ToolbarItem(title: "Оплатить", image: Asset.Toolbar.card.image, accesibilityId: "ToolBarItemOne")
    private let item2 = ToolbarItem(title: "Пополнить", image: Asset.Toolbar.getCash.image, accesibilityId: "ToolBarItemTwo")
    private let item3 = ToolbarItem(title: "Подробнее", image: Asset.Toolbar.info.image,
                                    accesibilityId: "ToolBarItemThree")
    private let item4 = ToolbarItem(title: "Настройки", image: Asset.Toolbar.settings.image, accesibilityId: "ToolBarItemFour")

    private enum Constants {
        static let selectedItem: Int = 1
        static let toolbarSpacing: CGFloat = LayoutGrid.halfModule * 7
        static let enabledItemIndex: Int = 2
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentControl(hidden: true)
        configureUI()
    }
    
    // MARK: - AppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        stepper.apply(theme: theme)
        toolbar.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        stepper.minimumValue = 1
        stepper.value = 4
        stepper.maximumValue = 4
        stepper.text = "Количество пунктов"
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        stepper.minusButtonAccesibilityId = "ToolBarInputNumberMinusButton"
        stepper.plusButtonAccesibilityId = "ToolBarInputNumberPlusButton"
        
        addSubviews()
        setupToolbar()
        configureConstraints()
    }

    private func setupToolbar() {
        items.append(contentsOf: [item1, item2, item3, item4])
        toolbar.setItems(items: items)
        toolbar.style = .vertical
        toolbar.delegate = self
        toolbar.selectionStyle = .selected
        toolbar.selectedItem = Constants.selectedItem
        toolbar.setToolbarItemWidth(width: LayoutGrid.doubleModule * 4)
        toolbar.accessibilityIdentifier = "ToolBar"
    }
    
    @objc private func stepperValueChanged(_ stepper: InputNumber) {
        let sliceItems = Array(items[0...(Int(stepper.value) - 1)])
        if sliceItems.count == 1 {
            toolbar.style = .horizontal
        } else {
            toolbar.style = .vertical
        }

        toolbar.setItems(items: sliceItems)
    }
    
    private func addSubviews() {
        [toolbar,
         stepper].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: LayoutGrid.doubleModule),
            stepper.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.tripleModule),
            stepper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),

            toolbar.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: LayoutGrid.tripleModule),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant: LayoutGrid.doubleModule),
            toolbar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
    
    // MARK: - ToolbarDelegate
    
    func didSelectItem(at index: Int) {
        toolbar.selectedItem = index
    }

}
