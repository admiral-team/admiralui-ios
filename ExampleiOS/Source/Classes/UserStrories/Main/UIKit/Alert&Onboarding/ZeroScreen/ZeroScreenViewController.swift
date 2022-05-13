//
//  ZeroScreenViewController.swift
//  ExampleiOS
//
//  Created on 17.02.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ZeroScreenViewController: BaseViewController {

    // MARK: - Private Properties

    private var scheme = ZeroScreenControllerScheme() {
        didSet { updateScheme() }
    }

    private lazy var zeroScreen = ZeroScreenView(image: Asset.Onboarding.one.image,
                                            title: viewModel.title,
                                            subTitle: viewModel.subTitle,
                                            buttonTitle: viewModel.buttonTitle)

    private let viewModel = ZeroScreenViewModel()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - AnyAppThemable

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        scheme = ZeroScreenControllerScheme(theme: theme)
        zeroScreen.apply(theme: theme)
    }

    // MARK: - Private Methods

    private func configureUI() {
        autoManage()
        addSubviews()
        configureConstraints()
        zeroScreen.delegate = self
    }

    private func addSubviews() {
        [zeroScreen].addToSuperview(view)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            zeroScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            zeroScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            zeroScreen.topAnchor.constraint(equalTo: view.topAnchor),
            zeroScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateScheme() {
        updateSchemeColors()
    }

    private func updateSchemeColors() {
        view.backgroundColor = scheme.backgroundColor.uiColor
        zeroScreen.scheme = scheme.zeroScreenViewScheme
    }

}

extension ZeroScreenViewController: ZeroScreenViewDelegate {
    
    // MARK: - ZeroScreenViewDelegate Methods
    
    func didTapButton(_ zeroScreenView: ZeroScreenView) {
        print("Tap ZeroScreen button")
    }

}
