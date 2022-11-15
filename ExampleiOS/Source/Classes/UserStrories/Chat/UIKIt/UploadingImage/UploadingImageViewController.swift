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

    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private lazy var segmentControl = StandardSegmentedControl(frame: .zero)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.registerCell(UploadingImageCell.self, reuseIdentifier: "UploadingImageCell")
        return tableView
    }()

    @available(iOS 13.0, *)
    private var backButton: UIBarButtonItem {
        let chevronLeft = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: chevronLeft, style: .plain, target: self, action: #selector(back))
        return backButton
    }

    private var isThemeSwitchViewHidden: Bool {
        get { themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    private var uploadImages: [UploadingGridItem] = [
        UploadingGridItem(
            models: [
                UploadImageItem(
                    image: Asset.Chat.photo.image,
                    style: .default
                )
            ],
            titleLabelText: "One file",
            chatTime: "21:21",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 2),
            titleLabelText: "Two files",
            chatTime: "21:22",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 3),
            titleLabelText: "Three files",
            chatTime: "21:23",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 4),
            titleLabelText: "Four files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 5),
            titleLabelText: "Five files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 6),
            titleLabelText: "Six files",
            chatTime: "21:24",
            chatDirection: .left
        ),
        UploadingGridItem(
            models: Array(repeating: UploadImageItem(
                image: Asset.Chat.photo.image,
                style: .default
            ), count: 4),
            titleLabelText: "Sent with error",
            chatTime: "21:24",
            chatDirection: .right,
            state: .error
        ),
        UploadingGridItem(
            models: [],
            titleLabelText: "",
            chatTime: "",
            chatDirection: .left,
            state: .default
        ),
        UploadingGridItem(
            models: [],
            titleLabelText: "",
            chatTime: "",
            chatDirection: .left,
            state: .default
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
        uploadImages.enumerated().forEach { index, _ in
            _ = uploadImages[index].models.enumerated().map { modelIndex, _ in
                uploadImages[index].models[modelIndex].state = control.selectedSegmentIndex == 1 ? .loading : .default
            }
        }
        updateTable()
    }

    private func showAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Повторить отправку", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { [weak self] _ in
            self?.uploadImages.remove(at: 6)
            self?.updateTable()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in }))
        present(alert, animated: true, completion: {})
    }

}

extension UploadingImageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        uploadImages.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = uploadImages[indexPath.row]
        if model.state == .error {
            showAlert()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UploadingImageCell", for: indexPath) as? UploadingImageCell else {
            return UITableViewCell()
        }
       cell.configure(for: uploadImages[indexPath.row])
       return cell
    }

}
