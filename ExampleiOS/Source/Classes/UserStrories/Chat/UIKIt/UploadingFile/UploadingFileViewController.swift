//
//  UploadingFileViewController.swift
//  ExampleiOS
//
//  Created on 27.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class UploadingFileViewController: UIViewController, AnyAppThemable {

    // MARK: - Contants

    private enum Constants {
        static let segmentViewHeight: CGFloat = 48.0
    }

    // MARK: - Private Properties

    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private let viewModel = UploadingFileViewModel()

    private lazy var segmentControl = StandardSegmentedControl(frame: .zero)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(UploadingFileCell.self, reuseIdentifier: "UploadingFileCell")
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
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: LayoutGrid.module)
        ])
    }

    private func configureLayout() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        configureUI()
        configureTable()
    }

    private func updateTable() {
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }

    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        viewModel.changeState(by: control.selectedSegmentIndex)
        updateTable()
    }

}

extension UploadingFileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.uploadFiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadingFileCell", for: indexPath) as? UploadingFileCell else {
            return UITableViewCell()
        }
        cell.configure(for: viewModel.uploadFiles[indexPath.row])
        return cell
    }

}
