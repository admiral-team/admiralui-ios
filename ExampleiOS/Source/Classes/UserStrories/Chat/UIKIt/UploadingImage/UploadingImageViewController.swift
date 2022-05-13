//
//  UploadingImageViewController.swift
//  ExampleiOS
//
//  Created on 29.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class UploadingImageViewController: UIViewController, AnyAppThemable {

    // MARK: - Contants

    private enum Constants {
        static let segmentViewHeight: CGFloat = 48.0
    }

    // MARK: - Private Properties

    private let viewModel = UploadingImageViewModel()
    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private lazy var segmentControl = StandardSegmentedControl(frame: .zero)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(UploadingImageCell.self, reuseIdentifier: "UploadingImageCell")
        return tableView
    }()

    private var isThemeSwitchViewHidden: Bool {
        get { return themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        tableView.backgroundColor = theme.colors.backgroundBasic.uiColor
        themeSwitchView.apply(theme: theme)
        segmentControl.apply(theme: theme)
    }

    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }

    // MARK: - Private Methods

    private func configureUI() {
        isThemeSwitchViewHidden = false

        segmentControl.setTitles(["Default", "Loading"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
    }


    private func configureManager() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        updateTable()
    }

    private func updateTable() {
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }

    private func addSubviews() {
        [tableView, segmentControl].addToSuperview(view)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.module),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),

            view.trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.heightAnchor.constraint(equalToConstant: Constants.segmentViewHeight),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.doubleModule),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        configureManager()
        configureUI()
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        viewModel.changeState(by: control.selectedSegmentIndex)
        updateTable()
    }

    private func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Повторить отправку", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: {})
    }

}

extension UploadingImageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.uploadImages.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.uploadImages[indexPath.row]
        if model.state == .error {
            showAlert()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadingImageCell", for: indexPath) as? UploadingImageCell else {
            return UITableViewCell()
        }
       cell.configure(for: viewModel.uploadImages[indexPath.row])
       return cell
    }

}
