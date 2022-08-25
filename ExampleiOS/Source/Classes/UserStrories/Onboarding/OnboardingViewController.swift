//
//  OnboardingViewController.swift
//  ExampleiOS
//
//  Created on 29.03.2021.
//

import AdmiralTheme
import AdmiralUIKit
import UIKit

class OnboardingViewController: UIViewController, AnyAppThemable, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    var adjustsFontForContentSizeCategory: Bool = Appearance.shared.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Contants
    
    enum Constants {
        static let backgroundViewHeight: CGFloat = 200.0
        static let backgroundViewWidth: CGFloat = 200.0
        
        static let imageViewHeight: CGFloat = 154.0
        static let imageViewWidth: CGFloat = 154.0
    }
    
    // MARK: - Private Properties
    
    private let backgroundView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var scheme = OnBoardingViewControllerCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = OnBoardingViewControllerCustomScheme(theme: theme)
    }
    
    // MARK: - Internal Methods
    
    func configure(model: OnboardingPageModel) {
        iconImageView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
    
        addSubviews()
        configureLabels()
        configureConstraints()
        configureBackgroundView()
    }
    
    private func configureBackgroundView() {
        backgroundView.layer.cornerRadius = Constants.backgroundViewHeight / 2
        backgroundView.clipsToBounds = true
    }
    
    private func configureLabels() {
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        
        titleLabel.numberOfLines = 2
        subtitleLabel.numberOfLines = 0
    }
    
    private func addSubviews() {
        [backgroundView, titleLabel, subtitleLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [iconImageView].forEach {
            backgroundView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: Constants.backgroundViewHeight),
            backgroundView.widthAnchor.constraint(equalToConstant: Constants.backgroundViewWidth),
            
            iconImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: LayoutGrid.module * 7),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: LayoutGrid.doubleModule),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutGrid.tripleModule)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.module * 5)
        ])
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        titleLabel.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
        subtitleLabel.setDynamicFont(
            font: scheme.subtitleLabelFont.uiFont,
            textStyle: scheme.subtitleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        titleLabel.textColor = scheme.titleLabelTextColor.uiColor
        view.backgroundColor = scheme.backgroundColor.uiColor
        backgroundView.backgroundColor = scheme.backgroundViewColor.uiColor
        subtitleLabel.textColor = scheme.subtitleLabelTextColor.uiColor
    }
    
}
