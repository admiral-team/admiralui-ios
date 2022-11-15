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
        get { themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    @available(iOS 13.0, *)
    private var backButton: UIBarButtonItem {
        let chevronLeft = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: chevronLeft, style: .plain, target: self, action: #selector(back))
        return backButton
    }

    private var uploadFiles = [
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 1.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 2.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 4.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 5.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 7.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 8.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 9.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .right,
            fileName: "File 10.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            chatStatus: .receive,
            progressCircleStyle: .default,
            trackProgressStyle: .accent
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 11.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        ),
        UploadingFileCellItem(
            state: .download,
            direction: .left,
            fileName: "File 12.pdf",
            fileSize: "65.6 МБ",
            chatTime: "14:52",
            progressCircleStyle: .accent,
            trackProgressStyle: .default
        )
    ]

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationItem.leftBarButtonItems = [backButton]
        }
        configureLayout()
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
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
        uploadFiles.enumerated().forEach { index, _ in
            uploadFiles[index].state = control.selectedSegmentIndex == 1 ? .loading : .download
        }
        updateTable()
    }

}

extension UploadingFileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        uploadFiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadingFileCell", for: indexPath) as? UploadingFileCell else {
            return UITableViewCell()
        }
        cell.configure(for: uploadFiles[indexPath.row])
        return cell
    }

}
