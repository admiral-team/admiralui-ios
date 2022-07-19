//
//  BottomSheetExampleViewController.swift
//  ExampleiOS
//
//  Created on 17.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BottomSheetExampleViewController: UIViewController, BottomSheetPresentable, AppThemeable {
    
    // MARK: - BottomSheetPresentable
    
    var panScrollable: UIScrollView? {
        tableView
    }
    
    var cornerRadius: CGFloat {
        24.0
    }
    
    var shortFormHeight: BottomSheetHeight {
        longFormHeight
    }
    
    var scrollIndicatorInsets: UIEdgeInsets {
        let bottomOffset = presentingViewController?.view.safeAreaInsets.bottom ?? 0
        return UIEdgeInsets(top: headerView.frame.size.height, left: 0, bottom: bottomOffset, right: 0)
    }
    
    // MARK: - AppThemable
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    private let headerView = BottomSheetHeaderTitleView()
    private var bottomView = BottomSheetBottomView()
    private var models = [BottomSheetTableViewCellViewModel]()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch Appearance.shared.theme.colors.style {
        case .light:
            return .default
        case .dark:
            return .lightContent
        @unknown default:
            return .default
        }
    }

    // MARK: - Private Methods
    
    private func commonInit() {
        autoManage()
        
        models = prepareData()
        
        addSubviews()
        configureTableView()
        setupConstraints()
    }
    
    private func addSubviews() {
        [tableView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BottomSheetTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.allowsMultipleSelection = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func prepareData() -> [BottomSheetTableViewCellViewModel] {
        var models = [BottomSheetTableViewCellViewModel]()
        let model = BottomSheetTableViewCellViewModel(
            title: "Зарплатная карта",
            isSelected: false,
            subtitle: "56 000.00 ₽",
            additionalTitle: nil,
            image: Asset.Card.visa.image)
        let model1 = BottomSheetTableViewCellViewModel(
            title: "Карта",
            isSelected: false,
            subtitle: "5 000.00 ₽",
            additionalTitle: nil,
            image: Asset.Card.visa.image)
        let model2 = BottomSheetTableViewCellViewModel(
            title: "Новая карта",
            isSelected: false,
            subtitle: "200 000.00 ₽ ",
            additionalTitle: nil,
            image: Asset.Card.visa.image)
        let model3 = BottomSheetTableViewCellViewModel(
            title: "Мультикарта",
            isSelected: false,
            subtitle: "2 000 000.00 ₽ ",
            additionalTitle: "• 6554",
            image: Asset.Card.visa.image)
        let model4 = BottomSheetTableViewCellViewModel(
            title: "Мультикарта",
            isSelected: false,
            subtitle: "11 000.00 ₽ ",
            additionalTitle: "• 5544",
            image: Asset.Card.visa.image)
        let model5 = BottomSheetTableViewCellViewModel(
            title: "Карта",
            isSelected: false,
            subtitle: "1000.00 ₽ ",
            additionalTitle: nil,
            image: Asset.Card.visa.image)
        models.append(contentsOf: [model, model1, model2, model3, model4, model5])
        return models
    }
    
}

// MARK: - BottomSheetNavigationViewDelegate

extension BottomSheetExampleViewController: BottomSheetHeaderDelegate {
    
    func didTapRightButtonItem(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension BottomSheetExampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BottomSheetTableViewCell
        else {
            return UITableViewCell()
        }
   
        cell.configureWith(model: models[indexPath.row])
        return cell
    }

}

// MARK: - UITableViewDelegate

extension BottomSheetExampleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.delegate = self
        headerView.titleText = "Выберите несколько карт"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        LayoutGrid.module * 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        bottomView.delegate = self
        return bottomView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        LayoutGrid.module * 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        LayoutGrid.halfModule * 17
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        model.isSelected = !model.isSelected
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
}

// MARK: - BottomSheetBottomViewDelegate

extension BottomSheetExampleViewController: BottomSheetBottomViewDelegate {
    
    func didTapRightButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapLeftButton() {
        models.forEach({ $0.isSelected = true })
        tableView.reloadData()
    }
    
}
