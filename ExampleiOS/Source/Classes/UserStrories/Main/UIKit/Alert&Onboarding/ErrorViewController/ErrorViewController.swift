//
//  ErrorViewController.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ErrorViewController: UIViewController, AnyAppThemable {

    // MARK: - Private Properties

    private let viewModel = ErrorViewModel()
    private let themeSwitchView = ThemeSwitchView(frame: .zero)
    private let errorView = ErrorView()

    private var isThemeSwitchViewHidden: Bool {
        get { return themeSwitchView.isHidden }
        set { themeSwitchView.isHidden = newValue }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - AnyAppThemable

    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        errorView.apply(theme: theme)
        themeSwitchView.apply(theme: theme)
    }

    func refreshTheme() {
        apply(theme: Appearance.shared.theme)
    }

    // MARK: - Private Methods

    private func configureUI() {
        autoManage()
        addSubviews()
        addThemeSwitchView(themeSwitchView)
        configureConstraints()
        setupUI()
    }

    private func setupUI() {
        isThemeSwitchViewHidden = false
        errorView.text = viewModel.text
        errorView.buttonTitle = viewModel.buttonTitle
        errorView.delegate = self
    }

    private func addSubviews() {
        [errorView].addToSuperview(view)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: errorView.bottomAnchor)
        ])
    }

}

extension ErrorViewController: ErrorViewDelegate {

    func didTapButton(_ errorView: ErrorView) {
        errorView.isLoading.toggle()
    }

}
